import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/core/database/json_document_store.dart';
import 'package:solitaire_nova/features/solitaire/data/game_repository.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/deck.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/klondike_engine.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_config.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_mode.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_snapshot.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/move.dart';

GameSnapshot sampleSnapshot({int seed = 99, int draws = 3}) {
  final deck = Deck.shuffled(seed);
  var state = KlondikeEngine.deal(deck, GameConfig.draw1);
  final history = <MoveRecord>[];
  for (var i = 0; i < draws; i++) {
    final r = KlondikeEngine.apply(state, const DrawMove());
    state = r.state;
    history.add(r.record);
  }
  final t = DateTime.utc(2026, 1, 2, 3, 4, 5);
  return GameSnapshot(
    gameId: 'g-$seed',
    seed: seed,
    mode: GameMode.random,
    config: GameConfig.draw1,
    deckOrder: [for (final c in deck) c.id],
    state: state,
    history: history,
    elapsedMs: 12345,
    startedAt: t,
    updatedAt: t,
    hintsUsed: 1,
  );
}

void main() {
  late Directory dir;
  late JsonDocumentStore store;
  const spec = DocumentSpec(name: 'doc', version: 1);

  setUp(() {
    dir = Directory.systemTemp.createTempSync('nova_store');
    store = JsonDocumentStore(dir);
  });
  tearDown(() => dir.deleteSync(recursive: true));

  test('missing document', () async {
    final r = await store.load(spec);
    expect(r.source, LoadSource.missing);
    expect(r.data, isNull);
  });

  test('save/load round trip, writes are serialized', () async {
    for (var i = 0; i < 20; i++) {
      store.save(spec, {'n': i}); // not awaited on purpose
    }
    await store.flush();
    final r = await store.load(spec);
    expect(r.data, {'n': 19});
    expect(File('${dir.path}/doc.json.tmp').existsSync(), isFalse);
  });

  test('corrupt primary falls back to backup', () async {
    await store.save(spec, {'v': 'old'});
    await store.save(spec, {'v': 'new'});
    File('${dir.path}/doc.json').writeAsStringSync('{"schemaVer');
    final r = await store.load(spec);
    expect(r.source, LoadSource.backup);
    expect(r.data, {'v': 'old'});
  });

  test('both files corrupt -> corrupted, no crash', () async {
    File('${dir.path}/doc.json').writeAsStringSync('garbage');
    File('${dir.path}/doc.json.bak').writeAsStringSync('[1,2');
    final r = await store.load(spec);
    expect(r.source, LoadSource.corrupted);
  });

  test('interrupted write (stray tmp) leaves last good data intact', () async {
    await store.save(spec, {'v': 1});
    // Simulate a crash mid-write: half-written tmp, primary untouched.
    File('${dir.path}/doc.json.tmp').writeAsStringSync('{"schemaVersion":1,"da');
    final r = await JsonDocumentStore(dir).load(spec);
    expect(r.data, {'v': 1});
    // Next save overwrites the stray tmp cleanly.
    await store.save(spec, {'v': 2});
    expect((await store.load(spec)).data, {'v': 2});
  });

  test('migrations upgrade old documents in order', () async {
    File('${dir.path}/doc.json').writeAsStringSync(jsonEncode({
      'schemaVersion': 1,
      'data': {'a': 1},
    }));
    final v3 = DocumentSpec(
      name: 'doc',
      version: 3,
      migrations: {
        1: (d) => {...d, 'b': 2},
        2: (d) => {...d, 'c': (d['a']! as int) + (d['b']! as int)},
      },
    );
    final r = await store.load(v3);
    expect(r.data, {'a': 1, 'b': 2, 'c': 3});
  });

  test('documents from a newer schema are not misread', () async {
    File('${dir.path}/doc.json').writeAsStringSync(jsonEncode({
      'schemaVersion': 9,
      'data': {'a': 1},
    }));
    final r = await store.load(spec);
    expect(r.data, isNull);
  });

  group('GameRepository', () {
    test('kill/restart: snapshot restores exactly', () async {
      final snap = sampleSnapshot();
      await GameRepository(store).save(snap);
      // "Process death": brand-new store + repository on the same directory.
      final restored = await GameRepository(JsonDocumentStore(dir))
          .loadCurrent();
      expect(restored, isNotNull);
      expect(restored!.state, snap.state);
      expect(restored.history.length, 3);
      expect(restored.elapsedMs, 12345);
      expect(restored.hintsUsed, 1);
      expect(restored.deckOrder, snap.deckOrder);
      // Undo log still works after restore.
      var s = restored.state;
      for (final rec in restored.history.reversed) {
        s = KlondikeEngine.undo(s, rec);
      }
      expect(s, KlondikeEngine.deal(restored.deck, GameConfig.draw1));
    });

    test('structurally invalid snapshot is rejected (duplicate card)', () {
      final json = sampleSnapshot().toJson();
      final state = (json['state']! as Map).cast<String, Object?>();
      final stock = List<int>.from(state['stock']! as List);
      stock[0] = stock[1];
      state['stock'] = stock;
      expect(() => GameSnapshot.fromJson(json), throwsFormatException);
    });

    test('corrupted game file -> null, app starts fresh', () async {
      File('${dir.path}/current_game.json').writeAsStringSync('{{{');
      expect(await GameRepository(store).loadCurrent(), isNull);
    });
  });
}
