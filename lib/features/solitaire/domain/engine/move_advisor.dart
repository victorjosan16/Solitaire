import '../models/card.dart';
import '../models/game_state.dart';
import '../models/move.dart';
import '../models/pile_ref.dart';
import '../rules/klondike_rules.dart';
import 'klondike_engine.dart';

/// Hints, tap-to-move resolution and auto-finish planning.
///
/// Everything here only ever proposes moves that [KlondikeRules.validate]
/// accepts.
class MoveAdvisor {
  const MoveAdvisor._();

  // ------------------------------------------------------------ tap-to-move

  /// Best destination when the player taps the card(s) at the top of [from].
  ///
  /// Priority (deterministic):
  /// 1. Foundation, when a single card can go there and [preferFoundation].
  /// 2. A non-empty tableau column (scanning left to right).
  /// 3. An empty tableau column (Kings only), unless that would be pointless
  ///    (the run already sits at the bottom of its own column).
  /// 4. Foundation as a last resort when [preferFoundation] is false.
  static TransferMove? tapMove(
    GameState s,
    PileRef from,
    int count, {
    bool preferFoundation = true,
  }) {
    TransferMove? foundationMove;
    if (count == 1 && !from.isFoundation) {
      final card = _topCard(s, from);
      if (card != null) {
        final m = TransferMove(from, PileRef.foundation(card.suit.index));
        if (KlondikeEngine.isLegal(s, m)) foundationMove = m;
      }
    }
    if (preferFoundation && foundationMove != null) return foundationMove;

    TransferMove? emptyTarget;
    for (var c = 0; c < 7; c++) {
      final to = PileRef.tableau(c);
      final m = TransferMove(from, to, count);
      if (!KlondikeEngine.isLegal(s, m)) continue;
      if (s.tableau[c].isNotEmpty) return m;
      final pointless = from.isTableau && s.tableau[from.index].length == count;
      if (!pointless) emptyTarget ??= m;
    }
    return emptyTarget ?? foundationMove;
  }

  static PlayingCard? _topCard(GameState s, PileRef p) => switch (p.kind) {
    PileKind.waste => s.wasteTop,
    PileKind.foundation => s.foundationTop(p.index),
    PileKind.tableau =>
      s.tableau[p.index].isEmpty ? null : s.tableau[p.index].last.card,
    PileKind.stock => null,
  };

  // ------------------------------------------------------------------ hints

  /// A useful legal move, or null when there is nothing productive to do
  /// ("no currently available moves"). Never declares the game lost: the
  /// caller only offers options to the player.
  static Move? hint(GameState s) {
    if (s.isWon) return null;
    final legal = KlondikeEngine.legalMoves(s);
    final transfers = legal.whereType<TransferMove>().toList();

    // 1. Anything to a foundation (tableau first: it may reveal a card).
    for (final m in transfers) {
      if (m.to.isFoundation && m.from.isTableau) return m;
    }
    for (final m in transfers) {
      if (m.to.isFoundation && m.from.isWaste) return m;
    }

    // 2. Tableau → tableau moves of a whole face-up run that reveal a card or
    //    clear a column for a King.
    for (final m in transfers) {
      if (!(m.from.isTableau && m.to.isTableau)) continue;
      final col = s.tableau[m.from.index];
      final start = col.length - m.count;
      final first = KlondikeRules.firstFaceUpIndex(col);
      if (start != first) continue;
      if (first > 0) return m; // reveals a face-down card
      if (s.tableau[m.to.index].isNotEmpty) return m; // empties a column
    }

    // 3. Partial-run moves that expose a card playable to a foundation.
    for (final m in transfers) {
      if (!(m.from.isTableau && m.to.isTableau)) continue;
      final col = s.tableau[m.from.index];
      final start = col.length - m.count;
      if (start == KlondikeRules.firstFaceUpIndex(col)) continue;
      final exposed = col[start - 1].card;
      if (KlondikeRules.canStackOnFoundation(
        exposed,
        exposed.suit.index,
        s.foundations[exposed.suit.index],
      )) {
        return m;
      }
    }

    // 4. Waste → tableau.
    for (final m in transfers) {
      if (m.from.isWaste && m.to.isTableau) return m;
    }

    // 5. Stock, but only if cycling would actually surface a playable card.
    if (_stockCycleHasPlay(s)) {
      if (s.stock.isNotEmpty) return const DrawMove();
      if (s.canRecycle) return const RecycleMove();
    }
    return null;
  }

  /// Simulates drawing through the stock (and recycling where allowed)
  /// without other moves, checking whether any waste top becomes playable.
  static bool _stockCycleHasPlay(GameState s) {
    if (s.stock.isEmpty && !s.canRecycle) return false;
    var cur = s;
    final limit = s.stock.length + s.waste.length + 2;
    for (var i = 0; i < limit; i++) {
      final Move step;
      if (cur.stock.isNotEmpty) {
        step = const DrawMove();
      } else if (cur.canRecycle) {
        step = const RecycleMove();
      } else {
        return false;
      }
      cur = KlondikeEngine.apply(cur, step).state;
      final top = cur.wasteTop;
      if (top != null && _wasteCardPlayable(cur, top)) return true;
    }
    return false;
  }

  static bool _wasteCardPlayable(GameState s, PlayingCard top) {
    if (KlondikeRules.canStackOnFoundation(
      top,
      top.suit.index,
      s.foundations[top.suit.index],
    )) {
      return true;
    }
    for (final col in s.tableau) {
      if (KlondikeRules.canStackOnTableau(top, col)) return true;
    }
    return false;
  }

  /// True when no productive move exists.
  static bool isStuck(GameState s) => !s.isWon && hint(s) == null;

  // ------------------------------------------------------------ auto finish

  /// Auto Finish is offered only once every tableau card is face up and a
  /// greedy foundation-only plan provably reaches victory.
  static bool canAutoFinish(GameState s) =>
      !s.isWon && s.allTableauFaceUp && autoFinishPlan(s) != null;

  /// A list of legal moves that wins the game using only foundation moves,
  /// draws and recycles, or null if such a plan does not exist.
  static List<Move>? autoFinishPlan(GameState s) {
    var cur = s;
    final plan = <Move>[];
    var sinceProgress = 0;
    while (!cur.isWon) {
      final m = _lowestFoundationMove(cur);
      if (m != null) {
        cur = KlondikeEngine.apply(cur, m).state;
        plan.add(m);
        sinceProgress = 0;
        continue;
      }
      final Move step;
      if (cur.stock.isNotEmpty) {
        step = const DrawMove();
      } else if (cur.canRecycle) {
        step = const RecycleMove();
      } else {
        return null;
      }
      if (++sinceProgress > cur.stock.length + cur.waste.length + 2) {
        return null;
      }
      cur = KlondikeEngine.apply(cur, step).state;
      plan.add(step);
    }
    return plan;
  }

  static TransferMove? _lowestFoundationMove(GameState s) {
    TransferMove? best;
    var bestRank = 99;
    void consider(PileRef from, PlayingCard card) {
      final f = card.suit.index;
      if (card.rank < bestRank &&
          KlondikeRules.canStackOnFoundation(card, f, s.foundations[f])) {
        best = TransferMove(from, PileRef.foundation(f));
        bestRank = card.rank;
      }
    }

    for (var c = 0; c < 7; c++) {
      final col = s.tableau[c];
      if (col.isNotEmpty && col.last.faceUp) {
        consider(PileRef.tableau(c), col.last.card);
      }
    }
    final w = s.wasteTop;
    if (w != null) consider(PileRef.waste, w);
    return best;
  }
}
