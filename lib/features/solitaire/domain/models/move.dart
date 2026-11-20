import 'pile_ref.dart';

/// A player intent. Moves are validated by the engine before applying.
sealed class Move {
  const Move();

  Map<String, Object?> toJson();

  static Move fromJson(Map<String, Object?> json) => switch (json['t']) {
    'd' => const DrawMove(),
    'r' => const RecycleMove(),
    'x' => TransferMove(
      PileRef.decode(json['f']! as String),
      PileRef.decode(json['to']! as String),
      json['n'] as int? ?? 1,
    ),
    _ => throw FormatException('Unknown move', json),
  };
}

/// Turn 1 or 3 cards (per config) from the stock onto the waste.
class DrawMove extends Move {
  const DrawMove();
  @override
  Map<String, Object?> toJson() => {'t': 'd'};
  @override
  bool operator ==(Object other) => other is DrawMove;
  @override
  int get hashCode => 1;
  @override
  String toString() => 'Draw';
}

/// Turn the whole waste back into the stock.
class RecycleMove extends Move {
  const RecycleMove();
  @override
  Map<String, Object?> toJson() => {'t': 'r'};
  @override
  bool operator ==(Object other) => other is RecycleMove;
  @override
  int get hashCode => 2;
  @override
  String toString() => 'Recycle';
}

/// Move [count] cards from the top of [from] to [to].
class TransferMove extends Move {
  const TransferMove(this.from, this.to, [this.count = 1]);
  final PileRef from;
  final PileRef to;
  final int count;

  @override
  Map<String, Object?> toJson() => {
    't': 'x',
    'f': from.encode(),
    'to': to.encode(),
    'n': count,
  };

  @override
  bool operator ==(Object other) =>
      other is TransferMove &&
      other.from == from &&
      other.to == to &&
      other.count == count;

  @override
  int get hashCode => Object.hash(from, to, count);

  @override
  String toString() => '$from->$to x$count';
}

/// Everything needed to exactly reverse an applied move (command pattern).
class MoveRecord {
  const MoveRecord({
    required this.move,
    required this.scoreDelta,
    this.flippedSourceCard = false,
    this.drawnCount = 0,
    this.previousWasteFanStart = 0,
  });

  final Move move;

  /// Actual change applied to the score (after clamping at zero).
  final int scoreDelta;

  /// True if removing cards from a tableau column auto-revealed a card.
  final bool flippedSourceCard;

  /// For [DrawMove]: how many cards were actually turned.
  final int drawnCount;

  final int previousWasteFanStart;

  Map<String, Object?> toJson() => {
    'm': move.toJson(),
    's': scoreDelta,
    if (flippedSourceCard) 'fl': true,
    if (drawnCount != 0) 'dc': drawnCount,
    if (previousWasteFanStart != 0) 'wf': previousWasteFanStart,
  };

  factory MoveRecord.fromJson(Map<String, Object?> json) => MoveRecord(
    move: Move.fromJson((json['m']! as Map).cast<String, Object?>()),
    scoreDelta: json['s'] as int? ?? 0,
    flippedSourceCard: json['fl'] as bool? ?? false,
    drawnCount: json['dc'] as int? ?? 0,
    previousWasteFanStart: json['wf'] as int? ?? 0,
  );
}
