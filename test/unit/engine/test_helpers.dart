import 'package:solitaire_nova/features/solitaire/domain/models/card.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_config.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_state.dart';

PlayingCard c(String code) {
  // e.g. "AS", "10H", "KD"
  final suit = switch (code[code.length - 1]) {
    'C' => Suit.clubs,
    'D' => Suit.diamonds,
    'H' => Suit.hearts,
    'S' => Suit.spades,
    _ => throw ArgumentError(code),
  };
  final r = code.substring(0, code.length - 1);
  final rank = switch (r) {
    'A' => 1,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    _ => int.parse(r),
  };
  return PlayingCard(suit, rank);
}

TableauCard up(String code) => TableauCard(c(code), faceUp: true);
TableauCard down(String code) => TableauCard(c(code), faceUp: false);

/// Builds a state from explicit piles. Cards not mentioned anywhere are put
/// into the stock (in id order) so the board always holds exactly 52 cards,
/// unless [fillStock] is false.
GameState board({
  GameConfig config = GameConfig.draw1,
  List<String> stock = const [],
  List<String> waste = const [],
  List<List<String>> foundations = const [[], [], [], []],
  List<List<TableauCard>> tableau = const [[], [], [], [], [], [], []],
  bool fillStock = true,
  int score = 0,
}) {
  final used = <int>{
    for (final s in stock) c(s).id,
    for (final s in waste) c(s).id,
    for (final f in foundations)
      for (final s in f) c(s).id,
    for (final col in tableau)
      for (final t in col) t.card.id,
  };
  final rest = [
    for (final card in PlayingCard.all)
      if (!used.contains(card.id)) card,
  ];
  return GameState(
    config: config,
    stock: [if (fillStock) ...rest, for (final s in stock) c(s)],
    waste: [for (final s in waste) c(s)],
    foundations: [
      for (final f in foundations) [for (final s in f) c(s)],
    ],
    tableau: tableau,
    score: score,
  );
}

/// Full foundation for a suit letter up to [rank] inclusive.
List<String> fnd(String suit, int rank) => [
  for (var r = 1; r <= rank; r++)
    '${switch (r) {
      1 => 'A',
      11 => 'J',
      12 => 'Q',
      13 => 'K',
      _ => '$r',
    }}$suit',
];
