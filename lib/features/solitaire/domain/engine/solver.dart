import '../models/card.dart';
import '../models/game_config.dart';
import '../models/game_state.dart';
import '../models/move.dart';
import '../models/pile_ref.dart';
import '../rules/klondike_rules.dart';
import 'klondike_engine.dart';

enum SolveStatus { solved, unsolvedWithinLimit }

class SolveResult {
  const SolveResult(this.status, this.solution, this.nodes);
  final SolveStatus status;

  /// Legal move sequence from the initial state to victory (when solved).
  final List<Move>? solution;
  final int nodes;
  bool get solved => status == SolveStatus.solved;
}

/// A depth-first "thoughtful" Klondike solver (it knows face-down cards).
///
/// It is used offline to *find* winning deals; a deal is only ever labelled
/// winnable when the solver returns a concrete solution, which is then
/// replayed through [KlondikeEngine] (see tests). Failure to solve within the
/// node budget says nothing about solvability, so such seeds are discarded.
class KlondikeSolver {
  KlondikeSolver({this.maxNodes = 200000});

  final int maxNodes;
  int _nodes = 0;
  final Set<String> _seen = {};

  SolveResult solveSeed(int seed, GameConfig config) =>
      solve(KlondikeEngine.dealSeed(seed, config));

  SolveResult solve(GameState initial) {
    _nodes = 0;
    _seen.clear();
    final path = <Move>[];
    final ok = _dfs(initial, path);
    return SolveResult(
      ok ? SolveStatus.solved : SolveStatus.unsolvedWithinLimit,
      ok ? List.unmodifiable(path) : null,
      _nodes,
    );
  }

  bool _dfs(GameState s, List<Move> path) {
    // Forced safe foundation moves (cannot hurt solvability).
    final mark = path.length;
    s = _playSafe(s, path);
    if (s.isWon) return true;
    if (++_nodes > maxNodes) {
      path.length = mark;
      return false;
    }
    if (!_seen.add(_key(s))) {
      path.length = mark;
      return false;
    }
    for (final m in _candidateMoves(s)) {
      path.add(m);
      if (_dfs(KlondikeEngine.apply(s, m).state, path)) return true;
      path.removeLast();
      if (_nodes > maxNodes) break;
    }
    path.length = mark;
    return false;
  }

  /// A card is safe to auto-play when nothing could ever need it as a
  /// tableau target: rank <= 2, or both opposite-colour cards one rank lower
  /// are already on foundations.
  static bool _isSafe(GameState s, PlayingCard c) {
    if (c.rank <= 2) return true;
    for (var i = 0; i < 4; i++) {
      final suit = Suit.values[i];
      if (suit.isRed == c.isRed) continue;
      if (s.foundations[i].length < c.rank - 1) return false;
    }
    return true;
  }

  GameState _playSafe(GameState s, List<Move> path) {
    var progress = true;
    while (progress) {
      progress = false;
      for (var c = 0; c < 7; c++) {
        final col = s.tableau[c];
        if (col.isEmpty || !col.last.faceUp) continue;
        final card = col.last.card;
        final f = card.suit.index;
        if (KlondikeRules.canStackOnFoundation(card, f, s.foundations[f]) &&
            _isSafe(s, card)) {
          final m = TransferMove(PileRef.tableau(c), PileRef.foundation(f));
          s = KlondikeEngine.apply(s, m).state;
          path.add(m);
          progress = true;
        }
      }
      final w = s.wasteTop;
      if (w != null &&
          KlondikeRules.canStackOnFoundation(
            w,
            w.suit.index,
            s.foundations[w.suit.index],
          ) &&
          _isSafe(s, w)) {
        final m = TransferMove(PileRef.waste, PileRef.foundation(w.suit.index));
        s = KlondikeEngine.apply(s, m).state;
        path.add(m);
        progress = true;
      }
    }
    return s;
  }

  List<Move> _candidateMoves(GameState s) {
    final out = <Move>[];
    final legal = KlondikeEngine.legalMoves(s);
    // Foundation moves first.
    for (final m in legal) {
      if (m is TransferMove && m.to.isFoundation) out.add(m);
    }
    for (final m in legal) {
      if (m is! TransferMove || !m.to.isTableau) continue;
      if (m.from.isTableau) {
        final col = s.tableau[m.from.index];
        final start = col.length - m.count;
        final first = KlondikeRules.firstFaceUpIndex(col);
        if (start == first) {
          // Whole run: useful if it reveals a card or empties onto a pile.
          if (first > 0 || s.tableau[m.to.index].isNotEmpty) out.add(m);
        } else {
          // Partial run: only if the exposed card can go to a foundation.
          final exposed = col[start - 1].card;
          final f = exposed.suit.index;
          if (KlondikeRules.canStackOnFoundation(
            exposed,
            f,
            s.foundations[f],
          )) {
            out.add(m);
          }
        }
      } else if (m.from.isWaste) {
        out.add(m);
      }
    }
    if (KlondikeEngine.isLegal(s, const DrawMove())) {
      out.add(const DrawMove());
    } else if (KlondikeEngine.isLegal(s, const RecycleMove())) {
      out.add(const RecycleMove());
    }
    return out;
  }

  static String _key(GameState s) {
    final b = StringBuffer();
    for (final f in s.foundations) {
      b.writeCharCode(65 + f.length);
    }
    // Columns sorted so that permutations of identical columns collide.
    final cols = [
      for (final col in s.tableau)
        String.fromCharCodes([
          for (final t in col) t.faceUp ? 48 + t.card.id : 120 + t.card.id,
        ]),
    ]..sort();
    for (final c in cols) {
      b
        ..write(c)
        ..write('|');
    }
    b.write(s.stock.length);
    b.write('/');
    b.write(s.waste.isEmpty ? '-' : s.waste.last.id.toString());
    b.write('/');
    b.write(s.waste.length);
    if (s.config.maxRecycles != null) b.write('r${s.recycles}');
    return b.toString();
  }
}
