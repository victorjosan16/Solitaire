import '../models/game_config.dart';
import '../models/pile_ref.dart';

/// Scoring version 1 — "Classic Standard" (documented in GAME_RULES.md).
///
/// Base points are tracked in the board state so undo restores them exactly.
/// Hints and undos never change the base score; they are recorded as
/// "assists" by the session and segment leaderboards instead.
class Scoring {
  const Scoring._();

  static const int version = 1;

  static const int wasteToTableau = 5;
  static const int wasteToFoundation = 10;
  static const int tableauToFoundation = 10;
  static const int revealTableauCard = 5;
  static const int foundationToTableau = -15;
  static const int recycleDraw1 = -100;
  static const int recycleDraw3 = -20;

  static int transferPoints(PileRef from, PileRef to) {
    if (from.isWaste && to.isTableau) return wasteToTableau;
    if (from.isWaste && to.isFoundation) return wasteToFoundation;
    if (from.isTableau && to.isFoundation) return tableauToFoundation;
    if (from.isFoundation && to.isTableau) return foundationToTableau;
    return 0;
  }

  static int recyclePoints(GameConfig config) =>
      config.drawCount == 1 ? recycleDraw1 : recycleDraw3;

  /// Time bonus awarded once on victory: 700000 / seconds for games of at
  /// least 30 seconds (the traditional formula), capped to keep it sane.
  static int timeBonus(Duration elapsed) {
    final seconds = elapsed.inSeconds;
    if (seconds < 30) return 0;
    return (700000 ~/ seconds).clamp(0, 23333);
  }

  /// Final score shown on the victory screen.
  static int finalScore({required int baseScore, required Duration elapsed}) =>
      baseScore + timeBonus(elapsed);
}
