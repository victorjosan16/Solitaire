import '../models/card.dart';
import '../models/game_state.dart';
import '../models/move.dart';
import '../models/pile_ref.dart';

/// Why a move was rejected. Typed so the UI can explain (or just shake).
enum MoveError {
  samePile,
  emptySource,
  invalidCount,
  faceDownCard,
  notASequence,
  illegalTarget,
  foundationToTableauDisabled,
  stockEmpty,
  stockNotEmpty,
  noRecyclesLeft,
  wasteEmpty,
  gameOver,
}

/// Pure rule predicates for classic Klondike.
class KlondikeRules {
  const KlondikeRules._();

  /// Tableau building: descending rank, alternating colour; only Kings on
  /// empty columns.
  static bool canStackOnTableau(PlayingCard moving, List<TableauCard> column) {
    if (column.isEmpty) return moving.isKing;
    final top = column.last;
    return top.faceUp &&
        top.card.isRed != moving.isRed &&
        top.card.rank == moving.rank + 1;
  }

  /// Foundation `i` accepts only `Suit.values[i]`, ascending from Ace.
  static bool canStackOnFoundation(
    PlayingCard card,
    int foundationIndex,
    List<PlayingCard> foundation,
  ) => card.suit.index == foundationIndex && card.rank == foundation.length + 1;

  /// Whether the tableau cards from [start] to the top form a movable run
  /// (all face up, alternating colours, consecutive descending ranks).
  static bool isMovableRun(List<TableauCard> column, int start) {
    if (start < 0 || start >= column.length) return false;
    for (var i = start; i < column.length; i++) {
      if (!column[i].faceUp) return false;
      if (i > start) {
        final below = column[i - 1].card;
        final above = column[i].card;
        if (below.isRed == above.isRed || below.rank != above.rank + 1) {
          return false;
        }
      }
    }
    return true;
  }

  /// Index of the first face-up card in a column, or `column.length`.
  static int firstFaceUpIndex(List<TableauCard> column) {
    for (var i = 0; i < column.length; i++) {
      if (column[i].faceUp) return i;
    }
    return column.length;
  }

  /// Returns null when [move] is legal in [s], otherwise the reason.
  static MoveError? validate(GameState s, Move move) {
    if (s.isWon) return MoveError.gameOver;
    switch (move) {
      case DrawMove():
        return s.stock.isEmpty ? MoveError.stockEmpty : null;
      case RecycleMove():
        if (s.stock.isNotEmpty) return MoveError.stockNotEmpty;
        if (s.waste.isEmpty) return MoveError.wasteEmpty;
        if (!s.canRecycle) return MoveError.noRecyclesLeft;
        return null;
      case TransferMove(:final from, :final to, :final count):
        return _validateTransfer(s, from, to, count);
    }
  }

  static MoveError? _validateTransfer(
    GameState s,
    PileRef from,
    PileRef to,
    int count,
  ) {
    if (from == to) return MoveError.samePile;
    if (count < 1) return MoveError.invalidCount;
    if (to.isStock || to.isWaste || from.isStock) {
      return MoveError.illegalTarget;
    }
    if (s.pileLength(from) < count) {
      return s.pileLength(from) == 0
          ? MoveError.emptySource
          : MoveError.invalidCount;
    }

    final PlayingCard lead;
    switch (from.kind) {
      case PileKind.waste:
        if (count != 1) return MoveError.invalidCount;
        lead = s.waste.last;
      case PileKind.foundation:
        if (count != 1) return MoveError.invalidCount;
        if (!to.isTableau) return MoveError.illegalTarget;
        if (!s.config.allowFoundationToTableau) {
          return MoveError.foundationToTableauDisabled;
        }
        lead = s.foundations[from.index].last;
      case PileKind.tableau:
        final col = s.tableau[from.index];
        final start = col.length - count;
        if (!col[start].faceUp) return MoveError.faceDownCard;
        if (!isMovableRun(col, start)) return MoveError.notASequence;
        if (to.isFoundation && count != 1) return MoveError.invalidCount;
        lead = col[start].card;
      case PileKind.stock:
        return MoveError.illegalTarget;
    }

    final ok = switch (to.kind) {
      PileKind.tableau => canStackOnTableau(lead, s.tableau[to.index]),
      PileKind.foundation => canStackOnFoundation(
        lead,
        to.index,
        s.foundations[to.index],
      ),
      _ => false,
    };
    return ok ? null : MoveError.illegalTarget;
  }
}
