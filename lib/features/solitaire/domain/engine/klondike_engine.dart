import '../models/card.dart';
import '../models/game_config.dart';
import '../models/game_state.dart';
import '../models/move.dart';
import '../models/pile_ref.dart';
import '../rules/klondike_rules.dart';
import '../scoring/scoring.dart';
import 'deck.dart';

class IllegalMoveException implements Exception {
  IllegalMoveException(this.move, this.error);
  final Move move;
  final MoveError error;
  @override
  String toString() => 'IllegalMoveException($move: $error)';
}

class MoveResult {
  const MoveResult(this.state, this.record);
  final GameState state;
  final MoveRecord record;
}

/// Applies and reverses moves. Stateless and pure: every call returns a new
/// [GameState]; inputs are never mutated.
class KlondikeEngine {
  const KlondikeEngine._();

  /// Deals a new game from [deck] (index 0 is dealt first).
  ///
  /// Row by row: row r places one card in each column c >= r; the card in
  /// column r is face up. The remaining 24 cards form the stock with the next
  /// undealt card on top.
  static GameState deal(List<PlayingCard> deck, GameConfig config) {
    if (!Deck.isCompleteDeck(deck)) {
      throw ArgumentError('deck must contain 52 unique cards');
    }
    final tableau = List.generate(7, (_) => <TableauCard>[]);
    var k = 0;
    for (var row = 0; row < 7; row++) {
      for (var col = row; col < 7; col++) {
        tableau[col].add(TableauCard(deck[k++], faceUp: col == row));
      }
    }
    final stock = deck.sublist(k).reversed.toList();
    return GameState(
      config: config,
      stock: stock,
      waste: const [],
      foundations: List.generate(4, (_) => const <PlayingCard>[]),
      tableau: tableau,
    );
  }

  static GameState dealSeed(int seed, GameConfig config) =>
      deal(Deck.shuffled(seed), config);

  static bool isLegal(GameState s, Move m) =>
      KlondikeRules.validate(s, m) == null;

  static MoveResult apply(GameState s, Move move) {
    final error = KlondikeRules.validate(s, move);
    if (error != null) throw IllegalMoveException(move, error);
    return switch (move) {
      DrawMove() => _draw(s, move),
      RecycleMove() => _recycle(s, move),
      TransferMove() => _transfer(s, move),
    };
  }

  static int _clampScore(int score, int delta) =>
      (score + delta) < 0 ? -score : delta;

  static MoveResult _draw(GameState s, DrawMove move) {
    final n = s.stock.length < s.config.drawCount
        ? s.stock.length
        : s.config.drawCount;
    final stock = List.of(s.stock);
    final waste = List.of(s.waste);
    for (var i = 0; i < n; i++) {
      waste.add(stock.removeLast());
    }
    return MoveResult(
      s.copyWith(
        stock: stock,
        waste: waste,
        moves: s.moves + 1,
        wasteFanStart: waste.length - n,
      ),
      MoveRecord(
        move: move,
        scoreDelta: 0,
        drawnCount: n,
        previousWasteFanStart: s.wasteFanStart,
      ),
    );
  }

  static MoveResult _recycle(GameState s, RecycleMove move) {
    final delta = _clampScore(s.score, Scoring.recyclePoints(s.config));
    return MoveResult(
      s.copyWith(
        stock: s.waste.reversed.toList(),
        waste: const [],
        score: s.score + delta,
        moves: s.moves + 1,
        recycles: s.recycles + 1,
        wasteFanStart: 0,
      ),
      MoveRecord(
        move: move,
        scoreDelta: delta,
        previousWasteFanStart: s.wasteFanStart,
      ),
    );
  }

  static MoveResult _transfer(GameState s, TransferMove move) {
    final waste = List.of(s.waste);
    final foundations = [for (final f in s.foundations) List.of(f)];
    final tableau = [for (final c in s.tableau) List.of(c)];

    // Remove from source.
    final List<PlayingCard> moving;
    var flipped = false;
    switch (move.from.kind) {
      case PileKind.waste:
        moving = [waste.removeLast()];
      case PileKind.foundation:
        moving = [foundations[move.from.index].removeLast()];
      case PileKind.tableau:
        final col = tableau[move.from.index];
        final start = col.length - move.count;
        moving = [for (final t in col.sublist(start)) t.card];
        col.removeRange(start, col.length);
        if (col.isNotEmpty && !col.last.faceUp) {
          col[col.length - 1] = col.last.flipped();
          flipped = true;
        }
      case PileKind.stock:
        throw StateError('unreachable');
    }

    // Add to destination.
    switch (move.to.kind) {
      case PileKind.foundation:
        foundations[move.to.index].addAll(moving);
      case PileKind.tableau:
        tableau[move.to.index].addAll(
          moving.map((c) => TableauCard(c, faceUp: true)),
        );
      case PileKind.stock:
      case PileKind.waste:
        throw StateError('unreachable');
    }

    var raw = Scoring.transferPoints(move.from, move.to);
    if (flipped) raw += Scoring.revealTableauCard;
    final delta = _clampScore(s.score, raw);

    // Keep the draw-3 fan sensible after taking from the waste.
    final fan = move.from.isWaste && s.wasteFanStart > waste.length
        ? waste.length
        : s.wasteFanStart;

    return MoveResult(
      s.copyWith(
        waste: waste,
        foundations: foundations,
        tableau: tableau,
        score: s.score + delta,
        moves: s.moves + 1,
        wasteFanStart: fan,
      ),
      MoveRecord(
        move: move,
        scoreDelta: delta,
        flippedSourceCard: flipped,
        previousWasteFanStart: s.wasteFanStart,
      ),
    );
  }

  /// Exactly reverses [record], which must be the last move applied to [s].
  static GameState undo(GameState s, MoveRecord record) {
    final move = record.move;
    switch (move) {
      case DrawMove():
        final stock = List.of(s.stock);
        final waste = List.of(s.waste);
        for (var i = 0; i < record.drawnCount; i++) {
          stock.add(waste.removeLast());
        }
        return s.copyWith(
          stock: stock,
          waste: waste,
          moves: s.moves - 1,
          wasteFanStart: record.previousWasteFanStart,
        );
      case RecycleMove():
        return s.copyWith(
          waste: s.stock.reversed.toList(),
          stock: const [],
          score: s.score - record.scoreDelta,
          moves: s.moves - 1,
          recycles: s.recycles - 1,
          wasteFanStart: record.previousWasteFanStart,
        );
      case TransferMove(:final from, :final to, :final count):
        final waste = List.of(s.waste);
        final foundations = [for (final f in s.foundations) List.of(f)];
        final tableau = [for (final c in s.tableau) List.of(c)];

        final List<PlayingCard> moving;
        switch (to.kind) {
          case PileKind.foundation:
            moving = [foundations[to.index].removeLast()];
          case PileKind.tableau:
            final col = tableau[to.index];
            moving = [for (final t in col.sublist(col.length - count)) t.card];
            col.removeRange(col.length - count, col.length);
          default:
            throw StateError('corrupt record');
        }
        switch (from.kind) {
          case PileKind.waste:
            waste.addAll(moving);
          case PileKind.foundation:
            foundations[from.index].addAll(moving);
          case PileKind.tableau:
            final col = tableau[from.index];
            if (record.flippedSourceCard) {
              col[col.length - 1] = col.last.flipped();
            }
            col.addAll(moving.map((c) => TableauCard(c, faceUp: true)));
          default:
            throw StateError('corrupt record');
        }
        return s.copyWith(
          waste: waste,
          foundations: foundations,
          tableau: tableau,
          score: s.score - record.scoreDelta,
          moves: s.moves - 1,
          wasteFanStart: record.previousWasteFanStart,
        );
    }
  }

  /// Paid "shuffle" assist: every card that is NOT on a foundation (tableau,
  /// stock, waste) is shuffled with [seed] and dealt again in the opening
  /// shape — row by row into columns 1..7, only each column's top card face
  /// up — and whatever does not fit becomes the stock. Foundations, score and
  /// the stock-pass counter are kept. Deterministic for a given input + seed.
  static GameState reshuffle(GameState s, int seed) {
    final cards = <PlayingCard>[
      for (final col in s.tableau)
        for (final t in col) t.card,
      ...s.stock,
      ...s.waste,
    ]..sort((a, b) => a.id.compareTo(b.id));
    final rng = SeededRandom(seed);
    for (var i = cards.length - 1; i > 0; i--) {
      final j = rng.nextInt(i + 1);
      final tmp = cards[i];
      cards[i] = cards[j];
      cards[j] = tmp;
    }
    final cols = List.generate(7, (_) => <PlayingCard>[]);
    var k = 0;
    for (var row = 0; row < 7 && k < cards.length; row++) {
      for (var col = row; col < 7 && k < cards.length; col++) {
        cols[col].add(cards[k++]);
      }
    }
    final tableau = [
      for (final col in cols)
        [
          for (var i = 0; i < col.length; i++)
            TableauCard(col[i], faceUp: i == col.length - 1),
        ],
    ];
    return s.copyWith(
      tableau: tableau,
      stock: cards.sublist(k).reversed.toList(),
      waste: const [],
      wasteFanStart: 0,
      moves: s.moves + 1,
    );
  }

  /// Cards a [reshuffle] would move (anything not on a foundation).
  static int shufflableCount(GameState s) => 52 - s.foundationCount;

  /// All legal moves in [s] (unordered, unfiltered). Used by the hint
  /// system, the solver and tests.
  static List<Move> legalMoves(GameState s) {
    if (s.isWon) return const [];
    final moves = <Move>[];
    final targets = [
      for (var i = 0; i < 4; i++) PileRef.foundation(i),
      for (var i = 0; i < 7; i++) PileRef.tableau(i),
    ];
    void tryAdd(Move m) {
      if (isLegal(s, m)) moves.add(m);
    }

    if (s.waste.isNotEmpty) {
      for (final t in targets) {
        tryAdd(TransferMove(PileRef.waste, t));
      }
    }
    for (var c = 0; c < 7; c++) {
      final col = s.tableau[c];
      if (col.isEmpty) continue;
      final first = KlondikeRules.firstFaceUpIndex(col);
      for (var start = first; start < col.length; start++) {
        final count = col.length - start;
        for (final t in targets) {
          if (t.isFoundation && count != 1) continue;
          tryAdd(TransferMove(PileRef.tableau(c), t, count));
        }
      }
    }
    if (s.config.allowFoundationToTableau) {
      for (var f = 0; f < 4; f++) {
        if (s.foundations[f].isEmpty) continue;
        for (var c = 0; c < 7; c++) {
          tryAdd(TransferMove(PileRef.foundation(f), PileRef.tableau(c)));
        }
      }
    }
    tryAdd(const DrawMove());
    tryAdd(const RecycleMove());
    return moves;
  }
}
