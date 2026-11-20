import '../../../shared/models/profile.dart';
import '../../daily_challenge/domain/daily_challenge.dart';

enum AchievementIcon {
  crown,
  trophy,
  flame,
  bolt,
  timer,
  calendar,
  star,
  cards,
  palette,
  brain,
  target,
  infinity,
}

/// A milestone. Titles/descriptions are localized in presentation by [id].
class AchievementDef {
  const AchievementDef({
    required this.id,
    required this.icon,
    required this.target,
    required this.reward,
    required this.progress,
  });

  final String id;
  final AchievementIcon icon;
  final int target;

  /// Virtual coins granted once on unlock.
  final int reward;

  /// Current progress, compared against [target].
  final int Function(ProfileData p, DateTime now) progress;
}

int _bool(bool b) => b ? 1 : 0;

/// 36 achievements. Order = display order.
final List<AchievementDef> achievementCatalog = [
  AchievementDef(
    id: 'first_win',
    icon: AchievementIcon.star,
    target: 1,
    reward: 50,
    progress: (p, _) => p.stats.total.won,
  ),
  AchievementDef(
    id: 'wins_10',
    icon: AchievementIcon.trophy,
    target: 10,
    reward: 100,
    progress: (p, _) => p.stats.total.won,
  ),
  AchievementDef(
    id: 'wins_50',
    icon: AchievementIcon.trophy,
    target: 50,
    reward: 250,
    progress: (p, _) => p.stats.total.won,
  ),
  AchievementDef(
    id: 'wins_100',
    icon: AchievementIcon.crown,
    target: 100,
    reward: 500,
    progress: (p, _) => p.stats.total.won,
  ),
  AchievementDef(
    id: 'wins_250',
    icon: AchievementIcon.crown,
    target: 250,
    reward: 750,
    progress: (p, _) => p.stats.total.won,
  ),
  AchievementDef(
    id: 'wins_500',
    icon: AchievementIcon.crown,
    target: 500,
    reward: 1000,
    progress: (p, _) => p.stats.total.won,
  ),
  AchievementDef(
    id: 'played_10',
    icon: AchievementIcon.cards,
    target: 10,
    reward: 50,
    progress: (p, _) => p.stats.total.played,
  ),
  AchievementDef(
    id: 'played_100',
    icon: AchievementIcon.cards,
    target: 100,
    reward: 200,
    progress: (p, _) => p.stats.total.played,
  ),
  AchievementDef(
    id: 'played_500',
    icon: AchievementIcon.cards,
    target: 500,
    reward: 500,
    progress: (p, _) => p.stats.total.played,
  ),
  AchievementDef(
    id: 'streak_3',
    icon: AchievementIcon.flame,
    target: 3,
    reward: 75,
    progress: (p, _) => p.stats.overallBestStreak,
  ),
  AchievementDef(
    id: 'streak_5',
    icon: AchievementIcon.flame,
    target: 5,
    reward: 150,
    progress: (p, _) => p.stats.overallBestStreak,
  ),
  AchievementDef(
    id: 'streak_10',
    icon: AchievementIcon.flame,
    target: 10,
    reward: 400,
    progress: (p, _) => p.stats.overallBestStreak,
  ),
  AchievementDef(
    id: 'draw3_first',
    icon: AchievementIcon.cards,
    target: 1,
    reward: 75,
    progress: (p, _) => p.stats.draw3.won,
  ),
  AchievementDef(
    id: 'draw3_25',
    icon: AchievementIcon.cards,
    target: 25,
    reward: 300,
    progress: (p, _) => p.stats.draw3.won,
  ),
  AchievementDef(
    id: 'no_hints',
    icon: AchievementIcon.brain,
    target: 1,
    reward: 75,
    progress: (p, _) => p.stats.winsNoHints,
  ),
  AchievementDef(
    id: 'no_undo',
    icon: AchievementIcon.brain,
    target: 1,
    reward: 75,
    progress: (p, _) => p.stats.winsNoUndo,
  ),
  AchievementDef(
    id: 'purist_10',
    icon: AchievementIcon.brain,
    target: 10,
    reward: 300,
    progress: (p, _) => p.stats.winsPure,
  ),
  AchievementDef(
    id: 'speed_5',
    icon: AchievementIcon.timer,
    target: 1,
    reward: 75,
    progress: (p, _) =>
        _bool((p.stats.total.fastestWinMs ?? 1 << 40) <= 5 * 60000),
  ),
  AchievementDef(
    id: 'speed_3',
    icon: AchievementIcon.timer,
    target: 1,
    reward: 150,
    progress: (p, _) =>
        _bool((p.stats.total.fastestWinMs ?? 1 << 40) <= 3 * 60000),
  ),
  AchievementDef(
    id: 'speed_2',
    icon: AchievementIcon.bolt,
    target: 1,
    reward: 300,
    progress: (p, _) =>
        _bool((p.stats.total.fastestWinMs ?? 1 << 40) <= 2 * 60000),
  ),
  AchievementDef(
    id: 'moves_120',
    icon: AchievementIcon.target,
    target: 1,
    reward: 100,
    progress: (p, _) => _bool((p.stats.total.fewestMovesWin ?? 1 << 30) <= 120),
  ),
  AchievementDef(
    id: 'moves_100',
    icon: AchievementIcon.target,
    target: 1,
    reward: 200,
    progress: (p, _) => _bool((p.stats.total.fewestMovesWin ?? 1 << 30) <= 100),
  ),
  AchievementDef(
    id: 'score_4000',
    icon: AchievementIcon.star,
    target: 1,
    reward: 100,
    progress: (p, _) => _bool(p.stats.total.bestScore >= 4000),
  ),
  AchievementDef(
    id: 'score_6000',
    icon: AchievementIcon.star,
    target: 1,
    reward: 250,
    progress: (p, _) => _bool(p.stats.total.bestScore >= 6000),
  ),
  AchievementDef(
    id: 'combo_5',
    icon: AchievementIcon.bolt,
    target: 5,
    reward: 75,
    progress: (p, _) => p.stats.maxCombo,
  ),
  AchievementDef(
    id: 'combo_10',
    icon: AchievementIcon.bolt,
    target: 10,
    reward: 200,
    progress: (p, _) => p.stats.maxCombo,
  ),
  AchievementDef(
    id: 'daily_first',
    icon: AchievementIcon.calendar,
    target: 1,
    reward: 50,
    progress: (p, _) => p.daily.length,
  ),
  AchievementDef(
    id: 'daily_total_10',
    icon: AchievementIcon.calendar,
    target: 10,
    reward: 150,
    progress: (p, _) => p.daily.length,
  ),
  AchievementDef(
    id: 'daily_total_30',
    icon: AchievementIcon.calendar,
    target: 30,
    reward: 400,
    progress: (p, _) => p.daily.length,
  ),
  AchievementDef(
    id: 'daily_streak_7',
    icon: AchievementIcon.calendar,
    target: 7,
    reward: 300,
    progress: (p, _) => DailyChallenge.bestStreak(p.daily.keys),
  ),
  AchievementDef(
    id: 'winning_10',
    icon: AchievementIcon.trophy,
    target: 10,
    reward: 150,
    progress: (p, _) => p.stats.winningDealWins,
  ),
  AchievementDef(
    id: 'auto_finish',
    icon: AchievementIcon.infinity,
    target: 1,
    reward: 50,
    progress: (p, _) => p.stats.autoFinishWins,
  ),
  AchievementDef(
    id: 'marathon',
    icon: AchievementIcon.timer,
    target: 600,
    reward: 300,
    progress: (p, _) => p.stats.total.totalPlayMs ~/ 60000,
  ),
  AchievementDef(
    id: 'collector_5',
    icon: AchievementIcon.palette,
    target: 5,
    reward: 200,
    progress: (p, _) => p.ownedPurchased,
  ),
  AchievementDef(
    id: 'stylist',
    icon: AchievementIcon.palette,
    target: 1,
    reward: 50,
    progress: (p, _) => _bool(!p.equipped.isDefault),
  ),
  AchievementDef(
    id: 'level_10',
    icon: AchievementIcon.crown,
    target: 10,
    reward: 250,
    progress: (p, _) => p.level,
  ),
];

AchievementDef? achievementById(String id) {
  for (final a in achievementCatalog) {
    if (a.id == id) return a;
  }
  return null;
}
