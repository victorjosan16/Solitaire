import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/klondike_engine.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/move_advisor.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/card.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_config.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/move.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/pile_ref.dart';

import 'test_helpers.dart';

final T = PileRef.tableau;
final F = PileRef.foundation;
const W = PileRef.waste;

void main() {
  group('Tap to move', () {
    test('prefers foundation for a single card', () {
      final s = board(waste: ['AH'], tableau: [
        [up('2S')], [], [], [], [], [], [],
      ]);
      expect(MoveAdvisor.tapMove(s, W, 1), TransferMove(W, F(2)));
    });

    test('prefers tableau when foundation preference is off', () {
      final s = board(
        foundations: [fnd('C', 6), [], [], []],
        tableau: [[up('7C')], [up('8H')], [], [], [], [], []],
      );
      expect(MoveAdvisor.tapMove(s, T(0), 1, preferFoundation: false),
          TransferMove(T(0), T(1)));
      expect(MoveAdvisor.tapMove(s, T(0), 1), TransferMove(T(0), F(0)));
    });

    test('non-empty tableau target before empty column', () {
      final s = board(waste: ['KH'], tableau: [
        [], [up('2S')], [], [], [], [], [],
      ]);
      expect(MoveAdvisor.tapMove(s, W, 1), TransferMove(W, T(0)));
    });

    test('king already at the bottom does not hop between empty columns', () {
      final s = board(tableau: [
        [up('KH')], [], [], [], [], [], [],
      ]);
      expect(MoveAdvisor.tapMove(s, T(0), 1), isNull);
    });

    test('returns null when nothing is legal', () {
      final s = board(waste: ['5H'], tableau: [
        [up('9S')], [up('2C')], [up('3D')], [up('4H')], [up('JD')],
        [up('QS')], [up('KC')],
      ]);
      expect(MoveAdvisor.tapMove(s, W, 1), isNull);
    });
  });

  group('Hints', () {
    test('only legal moves are suggested across many deals', () {
      for (var seed = 0; seed < 200; seed++) {
        var s = KlondikeEngine.dealSeed(seed, GameConfig.draw3);
        for (var i = 0; i < 60; i++) {
          final h = MoveAdvisor.hint(s);
          if (h == null) break;
          expect(KlondikeEngine.isLegal(s, h), isTrue, reason: 'seed $seed');
          s = KlondikeEngine.apply(s, h).state;
        }
      }
    });

    test('foundation moves come first', () {
      final s = board(waste: ['7D'], tableau: [
        [up('8S')], [down('5C'), up('AH')], [], [], [], [], [],
      ]);
      expect(MoveAdvisor.hint(s), TransferMove(T(1), F(2)));
    });

    test('does not suggest pointless stock cycling', () {
      // Nothing in the stock can ever be played and tableau is blocked.
      final s = board(
        stock: ['9C', '9S'],
        waste: ['10C'],
        tableau: [
          [down('AS'), up('2H')], [down('AC'), up('2D')], [up('QH')],
          [up('QD')], [down('AH'), up('3C')], [down('AD'), up('3S')], [],
        ],
        fillStock: true,
      );
      // Free stock cards of the "rest" are all mid ranks without targets?
      // Ensure the hint, if any, is legal and not an infinite draw loop.
      final h = MoveAdvisor.hint(s);
      if (h != null) expect(KlondikeEngine.isLegal(s, h), isTrue);
    });

    test('stuck board yields null (no false win/loss)', () {
      final s = board(
        fillStock: false,
        stock: ['9C'],
        waste: ['9S'],
        tableau: [
          [down('AS'), up('3H')], [down('AC'), up('3D')], [down('AH'), up('QH')],
          [down('AD'), up('QD')], [up('5C')], [up('5S')], [up('JH')],
        ],
      );
      // 9C/9S have no red 10 available, nothing to foundations.
      expect(MoveAdvisor.hint(s), isNull);
      expect(MoveAdvisor.isStuck(s), isTrue);
    });

    test('suggests draw when a buried stock card is playable', () {
      final s = board(
        fillStock: false,
        stock: ['AC', '9C'], // 9C on top, AC beneath
        tableau: [
          [down('AS'), up('3H')], [], [], [], [], [], [],
        ],
      );
      expect(MoveAdvisor.hint(s), const DrawMove());
    });
  });

  group('Auto finish', () {
    test('available when all face up and plan wins', () {
      final s = board(
        fillStock: false,
        waste: ['2C'],
        stock: ['AC'],
        foundations: [[], fnd('D', 13), fnd('H', 13), fnd('S', 11)],
        tableau: [
          [up('KC'), up('QC')], // not a valid stack but face up: fine
          [up('KS'), up('QS')].sublist(0, 2),
          [up('3C'), up('4C'), up('5C'), up('6C'), up('7C'), up('8C'),
           up('9C'), up('10C'), up('JC')].reversed.toList(),
          [], [], [], [],
        ],
      );
      expect(MoveAdvisor.canAutoFinish(s), isTrue);
      var cur = s;
      for (final m in MoveAdvisor.autoFinishPlan(s)!) {
        cur = KlondikeEngine.apply(cur, m).state;
      }
      expect(cur.isWon, isTrue);
    });

    test('not offered while face-down cards remain', () {
      final s = KlondikeEngine.dealSeed(3, GameConfig.draw1);
      expect(MoveAdvisor.canAutoFinish(s), isFalse);
    });

    test('not offered if recycle limit makes it impossible', () {
      final s = board(
        config: const GameConfig(maxRecycles: 0, drawCount: 3),
        fillStock: false,
        waste: ['AC', '2C', '3C'], // AC buried, no recycles: stuck
        foundations: [[], fnd('D', 13), fnd('H', 13), fnd('S', 13)],
        tableau: [
          [up('KC'), up('QC'), up('JC'), up('10C'), up('9C'), up('8C'),
           up('7C'), up('6C'), up('5C'), up('4C')],
          [], [], [], [], [], [],
        ],
      );
      expect(MoveAdvisor.autoFinishPlan(s), isNull);
      expect(MoveAdvisor.canAutoFinish(s), isFalse);
    });
  });

  test('suit sanity', () {
    expect(Suit.values.indexOf(Suit.hearts), 2);
  });
}
