import 'card.dart';
import 'game_config.dart';
import 'pile_ref.dart';

/// Immutable snapshot of a Klondike board.
///
/// Conventions:
/// * `stock` – all face down, the LAST element is the top card.
/// * `waste` – all face up, the LAST element is the top (playable) card.
/// * `foundations[i]` holds only cards of `Suit.values[i]`, Ace first.
/// * `tableau[c]` – index 0 is the bottom card, last is the top card.
class GameState {
  GameState({
    required this.config,
    required List<PlayingCard> stock,
    required List<PlayingCard> waste,
    required List<List<PlayingCard>> foundations,
    required List<List<TableauCard>> tableau,
    this.score = 0,
    this.moves = 0,
    this.recycles = 0,
    this.wasteFanStart = 0,
  }) : stock = List.unmodifiable(stock),
       waste = List.unmodifiable(waste),
       foundations = List.unmodifiable(
         foundations.map((f) => List<PlayingCard>.unmodifiable(f)),
       ),
       tableau = List.unmodifiable(
         tableau.map((t) => List<TableauCard>.unmodifiable(t)),
       ) {
    assert(this.foundations.length == 4);
    assert(this.tableau.length == 7);
  }

  final GameConfig config;
  final List<PlayingCard> stock;
  final List<PlayingCard> waste;
  final List<List<PlayingCard>> foundations;
  final List<List<TableauCard>> tableau;

  /// Classic base score (see docs/GAME_RULES.md). Never negative.
  final int score;

  /// Number of player moves applied (draws and recycles included).
  final int moves;

  /// Number of times the waste was turned back into the stock.
  final int recycles;

  /// Draw-3 presentation only: index in [waste] of the first card of the
  /// most recent draw, so the renderer fans the last batch. Has no effect on
  /// rules.
  final int wasteFanStart;

  bool get isWon => foundations.every((f) => f.length == 13);

  int get foundationCount => foundations.fold(0, (a, f) => a + f.length);

  bool get canRecycle =>
      stock.isEmpty &&
      waste.isNotEmpty &&
      (config.maxRecycles == null || recycles < config.maxRecycles!);

  bool get allTableauFaceUp => tableau.every((c) => c.every((t) => t.faceUp));

  PlayingCard? get wasteTop => waste.isEmpty ? null : waste.last;

  PlayingCard? foundationTop(int i) =>
      foundations[i].isEmpty ? null : foundations[i].last;

  /// Number of cards in a pile.
  int pileLength(PileRef p) => switch (p.kind) {
    PileKind.stock => stock.length,
    PileKind.waste => waste.length,
    PileKind.foundation => foundations[p.index].length,
    PileKind.tableau => tableau[p.index].length,
  };

  /// Every card on the board with its pile, used by invariant checks and the
  /// renderer.
  Iterable<PlayingCard> get allCards sync* {
    yield* stock;
    yield* waste;
    for (final f in foundations) {
      yield* f;
    }
    for (final c in tableau) {
      for (final t in c) {
        yield t.card;
      }
    }
  }

  GameState copyWith({
    List<PlayingCard>? stock,
    List<PlayingCard>? waste,
    List<List<PlayingCard>>? foundations,
    List<List<TableauCard>>? tableau,
    int? score,
    int? moves,
    int? recycles,
    int? wasteFanStart,
  }) => GameState(
    config: config,
    stock: stock ?? this.stock,
    waste: waste ?? this.waste,
    foundations: foundations ?? this.foundations,
    tableau: tableau ?? this.tableau,
    score: score ?? this.score,
    moves: moves ?? this.moves,
    recycles: recycles ?? this.recycles,
    wasteFanStart: wasteFanStart ?? this.wasteFanStart,
  );

  // ---------------------------------------------------------------- JSON --

  Map<String, Object?> toJson() => {
    'config': config.toJson(),
    'stock': [for (final c in stock) c.id],
    'waste': [for (final c in waste) c.id],
    'foundations': [
      for (final f in foundations) [for (final c in f) c.id],
    ],
    // Tableau cards encoded as id (face up) or -(id+1) (face down).
    'tableau': [
      for (final col in tableau)
        [for (final t in col) t.faceUp ? t.card.id : -(t.card.id + 1)],
    ],
    'score': score,
    'moves': moves,
    'recycles': recycles,
    'wasteFanStart': wasteFanStart,
  };

  factory GameState.fromJson(Map<String, Object?> json) {
    List<int> ints(Object? o) => [for (final e in o as List) e as int];
    final state = GameState(
      config: GameConfig.fromJson(
        (json['config'] as Map).cast<String, Object?>(),
      ),
      stock: [for (final i in ints(json['stock'])) PlayingCard.fromId(i)],
      waste: [for (final i in ints(json['waste'])) PlayingCard.fromId(i)],
      foundations: [
        for (final f in json['foundations'] as List)
          [for (final i in ints(f)) PlayingCard.fromId(i)],
      ],
      tableau: [
        for (final col in json['tableau'] as List)
          [
            for (final v in ints(col))
              v >= 0
                  ? TableauCard(PlayingCard.fromId(v), faceUp: true)
                  : TableauCard(PlayingCard.fromId(-v - 1), faceUp: false),
          ],
      ],
      score: json['score'] as int? ?? 0,
      moves: json['moves'] as int? ?? 0,
      recycles: json['recycles'] as int? ?? 0,
      wasteFanStart: json['wasteFanStart'] as int? ?? 0,
    );
    return state;
  }

  @override
  bool operator ==(Object other) {
    if (other is! GameState) return false;
    bool listEq<T>(List<T> a, List<T> b) {
      if (a.length != b.length) return false;
      for (var i = 0; i < a.length; i++) {
        if (a[i] != b[i]) return false;
      }
      return true;
    }

    if (other.config != config ||
        other.score != score ||
        other.moves != moves ||
        other.recycles != recycles ||
        other.wasteFanStart != wasteFanStart ||
        !listEq(other.stock, stock) ||
        !listEq(other.waste, waste)) {
      return false;
    }
    for (var i = 0; i < 4; i++) {
      if (!listEq(other.foundations[i], foundations[i])) return false;
    }
    for (var i = 0; i < 7; i++) {
      if (!listEq(other.tableau[i], tableau[i])) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(
    score,
    moves,
    recycles,
    Object.hashAll(stock),
    Object.hashAll(waste),
    Object.hashAll(tableau.map(Object.hashAll)),
  );

  @override
  String toString() {
    final b = StringBuffer()
      ..writeln('Stock(${stock.length}) Waste: ${waste.join(' ')}')
      ..writeln(
        'Foundations: ${foundations.map((f) => f.isEmpty ? '--' : f.last).join(' ')}',
      );
    for (var i = 0; i < 7; i++) {
      b.writeln('T$i: ${tableau[i].join(' ')}');
    }
    return b.toString();
  }
}
