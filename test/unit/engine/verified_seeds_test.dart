import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/klondike_engine.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/solver.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/verified_seeds.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_config.dart';

void main() {
  void verify(List<int> seeds, GameConfig config) {
    for (final seed in seeds) {
      final r = KlondikeSolver(maxNodes: 60000).solveSeed(seed, config);
      expect(r.solved, isTrue, reason: 'seed $seed must be solvable');
      var s = KlondikeEngine.dealSeed(seed, config);
      for (final m in r.solution!) {
        s = KlondikeEngine.apply(s, m).state;
      }
      expect(s.isWon, isTrue, reason: 'seed $seed replay');
    }
  }

  test('seed lists are non-trivial and unique', () {
    expect(verifiedDraw1Seeds.length, greaterThanOrEqualTo(366));
    expect(verifiedDraw1Seeds.toSet().length, verifiedDraw1Seeds.length);
    expect(verifiedDraw3Seeds.toSet().length, verifiedDraw3Seeds.length);
  });

  test('sample of draw-1 winning seeds re-verified by replay', () {
    verify([
      for (var i = 0; i < verifiedDraw1Seeds.length; i += 20)
        verifiedDraw1Seeds[i],
    ], GameConfig.draw1);
  });

  test('sample of draw-3 winning seeds re-verified by replay', () {
    verify([
      for (var i = 0; i < verifiedDraw3Seeds.length; i += 20)
        verifiedDraw3Seeds[i],
    ], GameConfig.draw3);
  });
}
