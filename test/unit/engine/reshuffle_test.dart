import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/deck.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/klondike_engine.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_config.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_state.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/move.dart';
import 'package:solitaire_nova/features/solitaire/domain/rules/klondike_rules.dart';

/// Plays [n] random legal moves so foundations / waste are non-trivial.
GameState midGame(int seed, int n) {
  var s = KlondikeEngine.dealSeed(seed, GameConfig.draw1);
  final rng = SeededRandom(seed);
  for (var i = 0; i < n; i++) {
    final legal = KlondikeEngine.legalMoves(s);
    // Prefer foundation moves so foundations fill up.
    final f = legal
        .whereType<TransferMove>()
        .where((m) => m.to.isFoundation)
        .toList();
    final m = f.isNotEmpty ? f.first : legal[rng.nextInt(legal.length)];
    s = KlondikeEngine.apply(s, m).state;
  }
  return s;
}

void main() {
  test(
    'keeps foundations, score, passes; 52 unique cards; tops face up only',
    () {
      for (var seed = 1; seed <= 60; seed++) {
        final before = midGame(seed, 80);
        final after = KlondikeEngine.reshuffle(before, seed * 31);
        expect(after.foundations, before.foundations);
        expect(after.score, before.score);
        expect(after.recycles, before.recycles);
        expect(after.moves, before.moves + 1);
        expect(Deck.isCompleteDeck(after.allCards), isTrue);
        expect(after.waste, isEmpty);
        for (final col in after.tableau) {
          for (var i = 0; i < col.length; i++) {
            expect(col[i].faceUp, i == col.length - 1);
          }
          expect(
            KlondikeRules.firstFaceUpIndex(col),
            col.isEmpty ? 0 : col.length - 1,
          );
        }
        // Opening shape: column c holds min(c+1, ...) cards, filled row by row.
        final n = KlondikeEngine.shufflableCount(before);
        expect(
          after.tableau.fold(0, (a, c) => a + c.length) + after.stock.length,
          n,
        );
        expect(after.tableau.fold(0, (a, c) => a + c.length), n < 28 ? n : 28);
        expect(GameState.fromJson(after.toJson()), after);
      }
    },
  );

  test('deterministic for the same seed, different for another', () {
    final s = midGame(5, 40);
    expect(KlondikeEngine.reshuffle(s, 1), KlondikeEngine.reshuffle(s, 1));
    expect(
      KlondikeEngine.reshuffle(s, 1),
      isNot(KlondikeEngine.reshuffle(s, 2)),
    );
  });

  test('few cards left: partial first row, nothing in stock', () {
    var s = midGame(9, 400);
    final n = KlondikeEngine.shufflableCount(s);
    final after = KlondikeEngine.reshuffle(s, 3);
    expect(after.stock.length, n > 28 ? n - 28 : 0);
    // The game stays playable: moves are still legal and invariant-safe.
    for (final m in KlondikeEngine.legalMoves(after).take(5)) {
      expect(
        Deck.isCompleteDeck(KlondikeEngine.apply(after, m).state.allCards),
        isTrue,
      );
    }
  });
}
