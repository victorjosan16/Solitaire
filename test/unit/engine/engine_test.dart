import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/deck.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/klondike_engine.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/card.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_config.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_state.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/move.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/pile_ref.dart';
import 'package:solitaire_nova/features/solitaire/domain/rules/klondike_rules.dart';
import 'package:solitaire_nova/features/solitaire/domain/scoring/scoring.dart';

import 'test_helpers.dart';

final T = PileRef.tableau;
final F = PileRef.foundation;
const W = PileRef.waste;
const S = PileRef.stock;

GameState apply(GameState s, Move m) => KlondikeEngine.apply(s, m).state;

MoveError? err(GameState s, Move m) => KlondikeRules.validate(s, m);

void main() {
  group('Initial deal', () {
    final s = KlondikeEngine.dealSeed(12345, GameConfig.draw1);

    test('seven columns of 1..7 with only the top card face up', () {
      for (var i = 0; i < 7; i++) {
        expect(s.tableau[i], hasLength(i + 1));
        for (var j = 0; j < i; j++) {
          expect(s.tableau[i][j].faceUp, isFalse);
        }
        expect(s.tableau[i].last.faceUp, isTrue);
      }
    });

    test('24 stock, empty waste and foundations, 52 unique cards', () {
      expect(s.stock, hasLength(24));
      expect(s.waste, isEmpty);
      expect(s.foundations.every((f) => f.isEmpty), isTrue);
      expect(Deck.isCompleteDeck(s.allCards), isTrue);
      expect(s.score, 0);
      expect(s.moves, 0);
    });

    test('deal is reproducible from the seed', () {
      expect(KlondikeEngine.dealSeed(12345, GameConfig.draw1), s);
      expect(KlondikeEngine.dealSeed(12346, GameConfig.draw1), isNot(s));
    });

    test('deal order: row by row, stock top is next undealt card', () {
      final deck = Deck.ordered();
      final d = KlondikeEngine.deal(deck, GameConfig.draw1);
      expect(d.tableau[0][0].card, deck[0]);
      expect(d.tableau[1][0].card, deck[1]);
      expect(d.tableau[6][0].card, deck[6]);
      expect(d.tableau[1][1].card, deck[7]);
      expect(d.stock.last, deck[28]);
      expect(d.stock.first, deck[51]);
    });

    test('rejects incomplete decks', () {
      expect(
        () =>
            KlondikeEngine.deal(Deck.ordered()..removeLast(), GameConfig.draw1),
        throwsArgumentError,
      );
    });
  });

  group('Tableau rules', () {
    test('descending alternating colour is legal', () {
      final s = board(
        tableau: [
          [up('8S')],
          [up('7H')],
          [up('7C')],
          [],
          [],
          [],
          [],
        ],
      );
      expect(err(s, TransferMove(T(1), T(0))), isNull); // 7H on 8S
      expect(err(s, TransferMove(T(2), T(0))), MoveError.illegalTarget);
    });

    test('wrong rank is illegal', () {
      final s = board(
        tableau: [
          [up('8S')],
          [up('6H')],
          [up('9H')],
          [],
          [],
          [],
          [],
        ],
      );
      expect(err(s, TransferMove(T(1), T(0))), MoveError.illegalTarget);
      expect(err(s, TransferMove(T(2), T(0))), MoveError.illegalTarget);
    });

    test('only kings move to an empty column', () {
      final s = board(
        tableau: [
          [up('KH')],
          [up('QS')],
          [down('2C'), up('KC')],
          [],
          [],
          [],
          [],
        ],
      );
      expect(err(s, TransferMove(T(1), T(3))), MoveError.illegalTarget);
      expect(err(s, TransferMove(T(0), T(3))), isNull);
      final after = apply(s, TransferMove(T(2), T(3)));
      expect(after.tableau[3].single.card, c('KC'));
      expect(after.tableau[2].single.faceUp, isTrue, reason: 'auto flip');
    });

    test('king-headed sequence to empty column', () {
      final s = board(
        tableau: [
          [down('2C'), up('KH'), up('QS'), up('JH')],
          [],
          [],
          [],
          [],
          [],
          [],
        ],
      );
      expect(err(s, TransferMove(T(0), T(1), 3)), isNull);
      expect(err(s, TransferMove(T(0), T(1), 2)), MoveError.illegalTarget);
      final a = apply(s, TransferMove(T(0), T(1), 3));
      expect(a.tableau[1].map((t) => t.card), [c('KH'), c('QS'), c('JH')]);
    });

    test('multi-card sequence must be valid and face up', () {
      final s = board(
        tableau: [
          [down('2C'), up('9H'), up('8S'), up('7D')],
          [up('10C')],
          [up('10S'), up('9D'), up('8D')], // broken sequence
          [up('9C')],
          [], [], [],
        ],
      );
      expect(err(s, TransferMove(T(0), T(1), 3)), isNull);
      expect(err(s, TransferMove(T(0), T(1), 4)), MoveError.faceDownCard);
      expect(err(s, TransferMove(T(2), T(3), 2)), MoveError.notASequence);
      expect(err(s, TransferMove(T(0), T(1), 5)), MoveError.invalidCount);
      expect(err(s, TransferMove(T(0), T(0), 1)), MoveError.samePile);
      expect(err(s, TransferMove(T(4), T(1), 1)), MoveError.emptySource);
    });

    test('cannot place on a face-down top card', () {
      final s = board(
        tableau: [
          [down('8S')],
          [up('7H')],
          [],
          [],
          [],
          [],
          [],
        ],
      );
      expect(err(s, TransferMove(T(1), T(0))), MoveError.illegalTarget);
    });
  });

  group('Foundation rules', () {
    test('ace starts its own suit foundation only', () {
      final s = board(waste: ['AH'], tableau: List.generate(7, (_) => []));
      final h = Suit.hearts.index;
      expect(err(s, TransferMove(W, F(h))), isNull);
      expect(
        err(s, TransferMove(W, F(Suit.spades.index))),
        MoveError.illegalTarget,
      );
    });

    test('ascending same suit', () {
      final s = board(
        foundations: [fnd('C', 4), [], [], []],
        tableau: [
          [up('5C')],
          [up('6C')],
          [up('5S')],
          [],
          [],
          [],
          [],
        ],
      );
      expect(err(s, TransferMove(T(0), F(0))), isNull);
      expect(err(s, TransferMove(T(1), F(0))), MoveError.illegalTarget);
      expect(err(s, TransferMove(T(2), F(0))), MoveError.illegalTarget);
    });

    test('only one card at a time to a foundation', () {
      final s = board(
        foundations: [fnd('C', 4), [], [], []],
        tableau: [
          [up('6H'), up('5C')],
          [],
          [],
          [],
          [],
          [],
          [],
        ],
      );
      expect(err(s, TransferMove(T(0), F(0), 2)), MoveError.invalidCount);
    });

    test('foundation to tableau is configurable', () {
      final tab = <List<TableauCard>>[
        [up('6H')],
        [],
        [],
        [],
        [],
        [],
        [],
      ];
      final on = board(foundations: [fnd('C', 5), [], [], []], tableau: tab);
      expect(err(on, TransferMove(F(0), T(0))), isNull);
      final off = board(
        config: const GameConfig(allowFoundationToTableau: false),
        foundations: [fnd('C', 5), [], [], []],
        tableau: tab,
      );
      expect(
        err(off, TransferMove(F(0), T(0))),
        MoveError.foundationToTableauDisabled,
      );
      expect(err(on, TransferMove(F(0), F(1))), MoveError.illegalTarget);
    });

    test('nothing can be moved to stock or waste, nor from stock', () {
      final s = board(
        waste: ['5H'],
        tableau: [
          [up('6S')],
          [],
          [],
          [],
          [],
          [],
          [],
        ],
      );
      expect(err(s, TransferMove(T(0), W)), MoveError.illegalTarget);
      expect(err(s, TransferMove(T(0), S)), MoveError.illegalTarget);
      expect(err(s, TransferMove(S, T(0))), MoveError.illegalTarget);
    });
  });

  group('Stock and waste', () {
    test('draw 1 moves the top stock card to the waste', () {
      final s = KlondikeEngine.dealSeed(9, GameConfig.draw1);
      final top = s.stock.last;
      final a = apply(s, const DrawMove());
      expect(a.waste.single, top);
      expect(a.stock, hasLength(23));
      expect(a.moves, 1);
    });

    test('draw 3 order: third card drawn ends on top', () {
      final s = KlondikeEngine.dealSeed(9, GameConfig.draw3);
      final st = s.stock;
      final a = apply(s, const DrawMove());
      expect(a.waste, [st[23], st[22], st[21]]);
      expect(a.wasteTop, st[21]);
      expect(a.stock, hasLength(21));
      expect(a.wasteFanStart, 0);
    });

    test('draw 3 with fewer than three cards draws what is left', () {
      var s = board(
        config: GameConfig.draw3,
        stock: ['2C', '3C'],
        tableau: List.generate(7, (_) => []),
        fillStock: false,
      );
      s = apply(s, const DrawMove());
      expect(s.waste.map((e) => '$e'), ['3C', '2C']);
      expect(s.stock, isEmpty);
      expect(err(s, const DrawMove()), MoveError.stockEmpty);
    });

    test('recycle restores the original stock order', () {
      var s = KlondikeEngine.dealSeed(77, GameConfig.draw3);
      final original = s.stock;
      while (s.stock.isNotEmpty) {
        s = apply(s, const DrawMove());
      }
      expect(s.waste, hasLength(24));
      s = apply(s, const RecycleMove());
      expect(s.stock, original);
      expect(s.waste, isEmpty);
      expect(s.recycles, 1);
    });

    test('recycle illegal while stock has cards or waste empty', () {
      final s = KlondikeEngine.dealSeed(77, GameConfig.draw1);
      expect(err(s, const RecycleMove()), MoveError.stockNotEmpty);
      final e = board(fillStock: false, tableau: List.generate(7, (_) => []));
      expect(err(e, const RecycleMove()), MoveError.wasteEmpty);
    });

    test('recycle limit is enforced', () {
      var s = board(
        config: const GameConfig(maxRecycles: 1),
        waste: ['2C', '3C'],
        fillStock: false,
        tableau: List.generate(7, (_) => []),
      );
      s = apply(s, const RecycleMove());
      s = apply(apply(s, const DrawMove()), const DrawMove());
      expect(err(s, const RecycleMove()), MoveError.noRecyclesLeft);
      expect(s.canRecycle, isFalse);
    });

    test('waste top can be played', () {
      final s = board(
        waste: ['7H'],
        tableau: [
          [up('8C')],
          [],
          [],
          [],
          [],
          [],
          [],
        ],
      );
      final a = apply(s, TransferMove(W, T(0)));
      expect(a.waste, isEmpty);
      expect(a.tableau[0].last.card, c('7H'));
      expect(err(s, TransferMove(W, T(0), 2)), MoveError.invalidCount);
    });
  });

  group('Scoring', () {
    test('standard points', () {
      final s = board(
        waste: ['7H', 'AC'],
        tableau: [
          [up('8C')],
          [down('3D'), up('AS')],
          [],
          [],
          [],
          [],
          [],
        ],
      );
      var a = apply(s, TransferMove(W, F(0)));
      expect(a.score, Scoring.wasteToFoundation);
      a = apply(a, TransferMove(W, T(0)));
      expect(a.score, Scoring.wasteToFoundation + Scoring.wasteToTableau);
      a = apply(a, TransferMove(T(1), F(Suit.spades.index)));
      expect(
        a.score,
        Scoring.wasteToFoundation +
            Scoring.wasteToTableau +
            Scoring.tableauToFoundation +
            Scoring.revealTableauCard,
      );
    });

    test('score never goes negative and undo restores it exactly', () {
      final s = board(
        waste: ['2C'],
        fillStock: false,
        tableau: List.generate(7, (_) => []),
      );
      final r = KlondikeEngine.apply(s, const RecycleMove());
      expect(r.state.score, 0);
      expect(KlondikeEngine.undo(r.state, r.record), s);
    });

    test('time bonus', () {
      expect(Scoring.timeBonus(const Duration(seconds: 10)), 0);
      expect(Scoring.timeBonus(const Duration(seconds: 100)), 7000);
      expect(
        Scoring.finalScore(
          baseScore: 500,
          elapsed: const Duration(seconds: 700),
        ),
        1500,
      );
    });
  });

  group('Undo', () {
    void roundTrip(GameState s, Move m) {
      final r = KlondikeEngine.apply(s, m);
      expect(KlondikeEngine.undo(r.state, r.record), s, reason: '$m');
      // Also through JSON (persisted undo log).
      final rec = MoveRecord.fromJson(r.record.toJson());
      expect(KlondikeEngine.undo(r.state, rec), s, reason: 'json $m');
    }

    test('every move type is exactly reversible', () {
      final s = board(
        waste: ['7H', 'AC'],
        foundations: [[], [], [], fnd('S', 6)],
        tableau: [
          [up('8C')],
          [down('3D'), up('9H'), up('8S')],
          [down('4D'), up('KH')],
          [],
          [up('7D')],
          [],
          [],
        ],
        score: 50,
      );
      roundTrip(s, const DrawMove());
      roundTrip(s, TransferMove(W, F(0))); // waste -> foundation
      roundTrip(apply(s, TransferMove(W, F(0))), TransferMove(W, T(0)));
      roundTrip(s, TransferMove(T(2), T(3))); // king to empty + flip
      roundTrip(s, TransferMove(F(3), T(4))); // 6S on 7D
      roundTrip(s, TransferMove(T(4), T(1))); // 7D on 8S
    });

    test('draw 3 + recycle undo', () {
      var s = KlondikeEngine.dealSeed(5, GameConfig.draw3);
      final history = <(GameState, MoveRecord)>[];
      for (var i = 0; i < 12; i++) {
        final m = s.stock.isNotEmpty ? const DrawMove() : const RecycleMove();
        final r = KlondikeEngine.apply(s, m);
        history.add((s, r.record));
        s = r.state;
      }
      for (final (before, rec) in history.reversed) {
        s = KlondikeEngine.undo(s, rec);
        expect(s, before);
      }
    });
  });

  group('Victory', () {
    test('win only when all 52 cards are on foundations', () {
      final almost = board(
        foundations: [fnd('C', 13), fnd('D', 13), fnd('H', 13), fnd('S', 12)],
        tableau: [
          [up('KS')],
          [],
          [],
          [],
          [],
          [],
          [],
        ],
        fillStock: false,
      );
      expect(almost.isWon, isFalse);
      final won = apply(almost, TransferMove(T(0), F(3)));
      expect(won.isWon, isTrue);
      expect(won.foundationCount, 52);
      expect(err(won, const DrawMove()), MoveError.gameOver);
      expect(KlondikeEngine.legalMoves(won), isEmpty);
    });
  });

  group('Serialization', () {
    test('GameState JSON round trip', () {
      var s = KlondikeEngine.dealSeed(31337, GameConfig.draw3);
      s = apply(s, const DrawMove());
      expect(GameState.fromJson(s.toJson()), s);
    });

    test('Move JSON round trip', () {
      for (final m in <Move>[
        const DrawMove(),
        const RecycleMove(),
        TransferMove(T(3), F(2)),
        TransferMove(W, T(6), 1),
        TransferMove(T(1), T(2), 4),
      ]) {
        expect(Move.fromJson(m.toJson()), m);
      }
      expect(() => PileRef.decode('X1'), throwsFormatException);
    });
  });
}
