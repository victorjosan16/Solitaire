import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../logging/app_logger.dart';

/// Upgrades the `data` payload of a document from `fromVersion` to
/// `fromVersion + 1`.
typedef Migration = Map<String, Object?> Function(Map<String, Object?> data);

/// Describes one persisted document type.
class DocumentSpec {
  const DocumentSpec({
    required this.name,
    required this.version,
    this.migrations = const {},
  });

  final String name;

  /// Current schema version written by this build.
  final int version;

  /// `migrations[n]` upgrades version n → n+1.
  final Map<int, Migration> migrations;
}

enum LoadSource { primary, backup, missing, corrupted }

class LoadResult {
  const LoadResult(this.data, this.source);
  final Map<String, Object?>? data;
  final LoadSource source;
}

/// Offline-first transactional document store.
///
/// Why not SQLite/Drift: the app persists a handful of small documents
/// (current game ≈ 10–40 KB, profile ≈ 5–20 KB) that are always read and
/// written whole. An atomic write-temp-then-rename gives the same
/// all-or-nothing guarantee per document as a SQLite transaction, with no
/// native dependency, no code generation and trivially testable recovery.
/// Every economy mutation lives inside the single `profile` document, so a
/// coin grant and its idempotency-ledger entry are committed together.
///
/// Guarantees:
/// * Writes are serialized (one at a time, in call order).
/// * Each write goes to `<name>.json.tmp`, is flushed, then renamed over
///   `<name>.json`; the previous good file is kept as `<name>.json.bak`.
/// * A torn/corrupt primary file falls back to the backup; if both are bad
///   the caller receives [LoadSource.corrupted] and starts fresh.
/// * Documents carry `schemaVersion` and are migrated forward on load.
class JsonDocumentStore {
  JsonDocumentStore(this.directory);

  final Directory directory;
  Future<void> _queue = Future.value();

  File _file(String name) => File('${directory.path}/$name.json');
  File _tmp(String name) => File('${directory.path}/$name.json.tmp');
  File _bak(String name) => File('${directory.path}/$name.json.bak');

  Future<LoadResult> load(DocumentSpec spec) async {
    await _queue; // never read while a write is in flight
    final primary = _tryRead(_file(spec.name), spec);
    if (primary != null) return LoadResult(primary, LoadSource.primary);
    final hadPrimary = _file(spec.name).existsSync();
    final backup = _tryRead(_bak(spec.name), spec);
    if (backup != null) {
      AppLogger.w('store.recovered_from_backup', {'doc': spec.name});
      return LoadResult(backup, LoadSource.backup);
    }
    if (hadPrimary || _bak(spec.name).existsSync()) {
      AppLogger.w('store.corrupted', {'doc': spec.name});
      return const LoadResult(null, LoadSource.corrupted);
    }
    return const LoadResult(null, LoadSource.missing);
  }

  Map<String, Object?>? _tryRead(File f, DocumentSpec spec) {
    try {
      if (!f.existsSync()) return null;
      final decoded = jsonDecode(f.readAsStringSync());
      if (decoded is! Map) return null;
      final env = decoded.cast<String, Object?>();
      var version = env['schemaVersion'];
      var data = env['data'];
      if (version is! int || data is! Map) return null;
      var map = data.cast<String, Object?>();
      if (version > spec.version) {
        // Written by a newer build: refuse rather than corrupt it.
        AppLogger.w('store.newer_schema', {'doc': spec.name, 'v': version});
        return null;
      }
      while (version as int < spec.version) {
        final m = spec.migrations[version];
        if (m == null) {
          AppLogger.w('store.no_migration', {'doc': spec.name, 'v': version});
          return null;
        }
        map = m(map);
        version++;
      }
      return map;
    } catch (e) {
      AppLogger.w('store.read_failed', {'doc': spec.name}, e);
      return null;
    }
  }

  /// Atomically persists [data]. Serialized with other writes.
  Future<void> save(DocumentSpec spec, Map<String, Object?> data) {
    final payload = jsonEncode({
      'schemaVersion': spec.version,
      'savedAt': DateTime.now().toUtc().toIso8601String(),
      'data': data,
    });
    final next = _queue.then((_) => _write(spec.name, payload));
    // Keep the queue alive even if a write fails.
    _queue = next.catchError((Object e, StackTrace st) {
      AppLogger.e('store.write_failed', {'doc': spec.name}, e, st);
    });
    return next;
  }

  Future<void> _write(String name, String payload) async {
    if (!directory.existsSync()) directory.createSync(recursive: true);
    final tmp = _tmp(name);
    final raf = tmp.openSync(mode: FileMode.write);
    try {
      raf.writeStringSync(payload);
      raf.flushSync();
    } finally {
      raf.closeSync();
    }
    final primary = _file(name);
    if (primary.existsSync()) {
      // Keep the last known-good version as a backup.
      if (_tryRawValid(primary)) primary.copySync(_bak(name).path);
    }
    tmp.renameSync(primary.path);
  }

  bool _tryRawValid(File f) {
    try {
      return jsonDecode(f.readAsStringSync()) is Map;
    } catch (_) {
      return false;
    }
  }

  Future<void> delete(String name) async {
    await _queue;
    for (final f in [_file(name), _tmp(name), _bak(name)]) {
      if (f.existsSync()) f.deleteSync();
    }
  }

  /// Waits for pending writes (used on app pause and in tests).
  Future<void> flush() => _queue;
}
