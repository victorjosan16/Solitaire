import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/deck.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/klondike_engine.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_config.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_state.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/move.dart';
import 'package:solitaire_nova/features/solitaire/domain/rules/klondike_rules.dart';

/// Checks every structural invariant of a Klondike board.
void expectValid(GameState s, String ctx) {
  expect(Deck.isCompleteDeck(s.allCards), isTrue, reason: '52 unique $ctx');
  for (var i = 0; i < 4; i++) {
    final f = s.foundations[i];
    for (var r = 0; r < f.length; r++) {
      expect(f[r].suit.index, i, reason: ctx);
      expect(f[r].rank, r + 1, reason: ctx);
    }
  }
  for (final col in s.tableau) {
    // Face-down cards never sit on top of face-up ones.
    final first = KlondikeRules.firstFaceUpIndex(col);
    for (var i = first; i < col.length; i++) {
      expect(col[i].faceUp, isTrue, reason: 'facedown above faceup $ctx');
    }
    // A non-empty column always has a face-up top card (auto flip).
    if (col.isNotEmpty) expect(col.last.faceUp, isTrue, reason: ctx);
  }
  expect(s.score, greaterThanOrEqualTo(0));
  expect(s.moves, greaterThanOrEqualTo(0));
}

void main() {
  for (final config in [
    GameConfig.draw1,
    GameConfig.draw3,
    const GameConfig(maxRecycles: 2, allowFoundationToTableau: false),
  ]) {
    test('random legal play keeps invariants; undo restores exactly '
        '(${config.rulesKey})', () {
      for (var seed = 0; seed < 150; seed++) {
        final rng = SeededRandom(seed * 7919 + 1);
        var s = KlondikeEngine.dealSeed(seed, config);
        final initial = s;
        final trail = <(GameState, MoveRecord)>[];
        for (var step = 0; step < 250; step++) {
          final legal = KlondikeEngine.legalMoves(s);
          if (legal.isEmpty) break;
          final m = legal[rng.nextInt(legal.length)];
          final r = KlondikeEngine.apply(s, m);
          trail.add((s, r.record));
          s = r.state;
          expectValid(s, 'seed $seed step $step $m');
          // Persisted state round-trips at every step.
          expect(GameState.fromJson(s.toJson()), s);
        }
        for (final (before, rec) in trail.reversed) {
          s = KlondikeEngine.undo(s, rec);
          expect(s, before);
        }
        expect(s, initial);
      }
    });
  }
}
