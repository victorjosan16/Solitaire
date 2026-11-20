/// How a deal was chosen. Random deals are never labelled winnable.
enum GameMode {
  /// Arbitrary shuffle: may or may not be solvable.
  random,

  /// A deal from the verified-winnable seed list.
  winning,

  /// The date-specific daily challenge (also verified winnable).
  daily,
}
