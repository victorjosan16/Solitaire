import '../models/card.dart';

/// Deterministic 32-bit PRNG (Mulberry32). We deliberately do not use
/// `dart:math` Random so that deals are reproducible forever, on every
/// platform and SDK version: a seed always maps to the same deal.
class SeededRandom {
  SeededRandom(int seed) : _state = seed & 0xFFFFFFFF;

  int _state;

  /// Next unsigned 32-bit value.
  int nextUint32() {
    _state = (_state + 0x6D2B79F5) & 0xFFFFFFFF;
    var t = _state;
    t = _imul(t ^ (t >>> 15), t | 1);
    t ^= (t + _imul(t ^ (t >>> 7), t | 61)) & 0xFFFFFFFF;
    return (t ^ (t >>> 14)) & 0xFFFFFFFF;
  }

  /// Uniform-ish integer in [0, max). Uses Lemire's multiply-shift.
  int nextInt(int max) {
    assert(max > 0 && max <= 0xFFFFFFFF);
    return (nextUint32() * max) >>> 32;
  }

  static int _imul(int a, int b) => (a * b) & 0xFFFFFFFF;
}

class Deck {
  Deck._();

  /// A fresh ordered deck (clubs A..K, diamonds, hearts, spades).
  static List<PlayingCard> ordered() => List.of(PlayingCard.all);

  /// Fisher–Yates shuffle driven by [SeededRandom]. Same seed → same order.
  static List<PlayingCard> shuffled(int seed) {
    final cards = ordered();
    final rng = SeededRandom(seed);
    for (var i = cards.length - 1; i > 0; i--) {
      final j = rng.nextInt(i + 1);
      final tmp = cards[i];
      cards[i] = cards[j];
      cards[j] = tmp;
    }
    return cards;
  }

  /// Validates that [cards] is a permutation of the 52-card deck.
  static bool isCompleteDeck(Iterable<PlayingCard> cards) {
    final ids = <int>{};
    var n = 0;
    for (final c in cards) {
      ids.add(c.id);
      n++;
    }
    return n == 52 && ids.length == 52;
  }

  /// Stable 32-bit FNV-1a hash, used e.g. to derive seeds from strings.
  static int fnv1a(String input) {
    var hash = 0x811C9DC5;
    for (final unit in input.codeUnits) {
      hash ^= unit & 0xFF;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
      hash ^= unit >> 8;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return hash;
  }
}
