import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/klondike_engine.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/solver.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_config.dart';

void main() {
  test('solver solutions replay legally to a win', () {
    var solved = 0;
    for (var seed = 1; seed <= 40; seed++) {
      final r = KlondikeSolver(maxNodes: 50000)
          .solveSeed(seed, GameConfig.draw1);
      if (!r.solved) continue;
      solved++;
      var s = KlondikeEngine.dealSeed(seed, GameConfig.draw1);
      for (final m in r.solution!) {
        s = KlondikeEngine.apply(s, m).state; // throws if illegal
      }
      expect(s.isWon, isTrue, reason: 'seed $seed');
    }
    // A thoughtful solver wins the large majority of draw-1 deals.
    expect(solved, greaterThan(20));
  });
}
