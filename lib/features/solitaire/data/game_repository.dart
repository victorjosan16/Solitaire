import '../../../core/database/json_document_store.dart';
import '../../../core/logging/app_logger.dart';
import '../domain/models/game_snapshot.dart';

/// Persists the single in-progress game (resume after process death).
class GameRepository {
  GameRepository(this._store);

  final JsonDocumentStore _store;

  static const spec = DocumentSpec(
    name: 'current_game',
    version: GameSnapshot.schemaVersion,
    // Future: migrations[1] = (data) => {...data, 'newField': default}
  );

  /// Returns the saved game, or null if none / unrecoverable. A corrupt
  /// snapshot never crashes the app: it is logged and discarded.
  Future<GameSnapshot?> loadCurrent() async {
    final r = await _store.load(spec);
    final data = r.data;
    if (data == null) return null;
    try {
      return GameSnapshot.fromJson(data);
    } on FormatException catch (e) {
      AppLogger.w('game.snapshot_invalid', {'source': r.source.name}, e);
      return null;
    }
  }

  Future<void> save(GameSnapshot snapshot) =>
      _store.save(spec, snapshot.toJson());

  Future<void> clear() => _store.delete(spec.name);

  Future<void> flush() => _store.flush();
}
