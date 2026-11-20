import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/deck.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/card.dart';

void main() {
  group('Cards', () {
    test('52 unique cards, 4 suits x 13 ranks', () {
      expect(PlayingCard.all, hasLength(52));
      expect(PlayingCard.all.map((c) => c.id).toSet(), hasLength(52));
      for (final s in Suit.values) {
        expect(PlayingCard.all.where((c) => c.suit == s), hasLength(13));
      }
      for (var i = 0; i < 52; i++) {
        expect(PlayingCard.fromId(i).id, i);
      }
    });

    test('colours and labels', () {
      expect(PlayingCard(Suit.hearts, 1).isRed, isTrue);
      expect(PlayingCard(Suit.diamonds, 5).isRed, isTrue);
      expect(PlayingCard(Suit.spades, 5).isRed, isFalse);
      expect(PlayingCard(Suit.clubs, 13).rankLabel, 'K');
      expect(PlayingCard(Suit.clubs, 10).rankLabel, '10');
      expect(() => PlayingCard(Suit.clubs, 0), throwsArgumentError);
      expect(() => PlayingCard.fromId(52), throwsArgumentError);
    });
  });

  group('Seeded shuffle', () {
    test('same seed -> same order; different seeds differ', () {
      expect(Deck.shuffled(42), Deck.shuffled(42));
      expect(Deck.shuffled(42), isNot(Deck.shuffled(43)));
    });

    test('shuffle is a permutation for many seeds', () {
      for (var seed = 0; seed < 500; seed++) {
        expect(Deck.isCompleteDeck(Deck.shuffled(seed)), isTrue);
      }
    });

    test('regression: seed 1 order is frozen forever', () {
      // If this fails, the PRNG changed and every saved/daily deal would
      // silently change. Never update this expectation casually.
      expect(Deck.shuffled(1).take(6).map((c) => c.id).toList(), _seed1Prefix);
    });

    test('PRNG distribution is roughly uniform', () {
      final rng = SeededRandom(7);
      final buckets = List.filled(10, 0);
      for (var i = 0; i < 100000; i++) {
        buckets[rng.nextInt(10)]++;
      }
      for (final b in buckets) {
        expect(b, inInclusiveRange(9500, 10500));
      }
    });

    test('fnv1a is stable', () {
      expect(Deck.fnv1a(''), 0x811C9DC5);
      expect(Deck.fnv1a('2026-01-01'), Deck.fnv1a('2026-01-01'));
      expect(Deck.fnv1a('2026-01-01'), isNot(Deck.fnv1a('2026-01-02')));
    });
  });
}

const _seed1Prefix = <int>[24, 44, 23, 10, 43, 31];
