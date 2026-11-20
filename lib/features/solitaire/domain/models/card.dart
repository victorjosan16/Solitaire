/// Core card primitives. Pure Dart: no Flutter imports allowed in domain/.
library;

enum Suit {
  clubs,
  diamonds,
  hearts,
  spades;

  bool get isRed => this == Suit.diamonds || this == Suit.hearts;

  /// Single-letter code used in compact serialization and debug output.
  String get code => const ['C', 'D', 'H', 'S'][index];
}

/// An immutable playing card. Identity is a stable integer 0..51
/// (`suit.index * 13 + rank - 1`) which is what we persist.
class PlayingCard {
  const PlayingCard._(this.suit, this.rank);

  factory PlayingCard(Suit suit, int rank) {
    if (rank < 1 || rank > 13) {
      throw ArgumentError.value(rank, 'rank', 'must be 1..13');
    }
    return all[suit.index * 13 + rank - 1];
  }

  factory PlayingCard.fromId(int id) {
    if (id < 0 || id >= 52) {
      throw ArgumentError.value(id, 'id', 'must be 0..51');
    }
    return all[id];
  }

  final Suit suit;

  /// 1 = Ace, 11 = Jack, 12 = Queen, 13 = King.
  final int rank;

  int get id => suit.index * 13 + rank - 1;
  bool get isRed => suit.isRed;
  bool get isAce => rank == 1;
  bool get isKing => rank == 13;

  /// Rank label as printed on the card index (A, 2..10, J, Q, K).
  String get rankLabel => switch (rank) {
    1 => 'A',
    11 => 'J',
    12 => 'Q',
    13 => 'K',
    _ => '$rank',
  };

  static final List<PlayingCard> all = List<PlayingCard>.unmodifiable([
    for (final s in Suit.values)
      for (var r = 1; r <= 13; r++) PlayingCard._(s, r),
  ]);

  @override
  String toString() => '$rankLabel${suit.code}';
}

/// A card as it sits in a tableau column: face up or face down.
class TableauCard {
  const TableauCard(this.card, {required this.faceUp});

  final PlayingCard card;
  final bool faceUp;

  TableauCard flipped() => TableauCard(card, faceUp: !faceUp);

  @override
  bool operator ==(Object other) =>
      other is TableauCard && other.card == card && other.faceUp == faceUp;

  @override
  int get hashCode => Object.hash(card, faceUp);

  @override
  String toString() => faceUp ? '$card' : '[$card]';
}
