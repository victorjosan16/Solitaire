/// Addresses a pile on the board.
enum PileKind { stock, waste, foundation, tableau }

class PileRef {
  const PileRef._(this.kind, this.index);

  static const PileRef stock = PileRef._(PileKind.stock, 0);
  static const PileRef waste = PileRef._(PileKind.waste, 0);

  factory PileRef.foundation(int index) {
    RangeError.checkValueInInterval(index, 0, 3, 'index');
    return PileRef._(PileKind.foundation, index);
  }

  factory PileRef.tableau(int index) {
    RangeError.checkValueInInterval(index, 0, 6, 'index');
    return PileRef._(PileKind.tableau, index);
  }

  final PileKind kind;
  final int index;

  bool get isTableau => kind == PileKind.tableau;
  bool get isFoundation => kind == PileKind.foundation;
  bool get isWaste => kind == PileKind.waste;
  bool get isStock => kind == PileKind.stock;

  /// Compact encoding: "S", "W", "F0".."F3", "T0".."T6".
  String encode() => switch (kind) {
    PileKind.stock => 'S',
    PileKind.waste => 'W',
    PileKind.foundation => 'F$index',
    PileKind.tableau => 'T$index',
  };

  static PileRef decode(String s) {
    switch (s[0]) {
      case 'S':
        return stock;
      case 'W':
        return waste;
      case 'F':
        return PileRef.foundation(int.parse(s.substring(1)));
      case 'T':
        return PileRef.tableau(int.parse(s.substring(1)));
    }
    throw FormatException('Bad pile ref', s);
  }

  @override
  bool operator ==(Object other) =>
      other is PileRef && other.kind == kind && other.index == index;

  @override
  int get hashCode => Object.hash(kind, index);

  @override
  String toString() => encode();
}
