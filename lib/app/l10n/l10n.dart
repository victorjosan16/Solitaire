import 'package:material_ui/material_ui.dart';

import '../../features/achievements/domain/achievements.dart';
import '../../features/solitaire/domain/models/card.dart';
import '../../features/solitaire/domain/models/game_mode.dart';
import 'gen/app_localizations.dart';

export 'gen/app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

String cosmeticName(AppLocalizations l, String id) => switch (id) {
  'cards.classic' => l.cosmetic_cards_classic,
  'cards.elegant' => l.cosmetic_cards_elegant,
  'cards.vintage' => l.cosmetic_cards_vintage,
  'cards.modern' => l.cosmetic_cards_modern,
  'cards.neon' => l.cosmetic_cards_neon,
  'cards.gold' => l.cosmetic_cards_gold,
  'bg.lake' => l.cosmetic_bg_lake,
  'bg.autumn' => l.cosmetic_bg_autumn,
  'bg.tropic' => l.cosmetic_bg_tropic,
  'bg.alpine' => l.cosmetic_bg_alpine,
  'bg.aurora' => l.cosmetic_bg_aurora,
  'bg.lavender' => l.cosmetic_bg_lavender,
  'table.emerald' => l.cosmetic_table_emerald,
  'table.navy' => l.cosmetic_table_navy,
  'table.burgundy' => l.cosmetic_table_burgundy,
  'table.walnut' => l.cosmetic_table_walnut,
  'table.slate' => l.cosmetic_table_slate,
  'table.contrast' => l.cosmetic_table_contrast,
  _ => id,
};

String achievementTitle(AppLocalizations l, String id) => switch (id) {
  'first_win' => l.achTitle_first_win,
  'wins_10' => l.achTitle_wins_10,
  'wins_50' => l.achTitle_wins_50,
  'wins_100' => l.achTitle_wins_100,
  'wins_250' => l.achTitle_wins_250,
  'wins_500' => l.achTitle_wins_500,
  'played_10' => l.achTitle_played_10,
  'played_100' => l.achTitle_played_100,
  'played_500' => l.achTitle_played_500,
  'streak_3' => l.achTitle_streak_3,
  'streak_5' => l.achTitle_streak_5,
  'streak_10' => l.achTitle_streak_10,
  'draw3_first' => l.achTitle_draw3_first,
  'draw3_25' => l.achTitle_draw3_25,
  'no_hints' => l.achTitle_no_hints,
  'no_undo' => l.achTitle_no_undo,
  'purist_10' => l.achTitle_purist_10,
  'speed_5' => l.achTitle_speed_5,
  'speed_3' => l.achTitle_speed_3,
  'speed_2' => l.achTitle_speed_2,
  'moves_120' => l.achTitle_moves_120,
  'moves_100' => l.achTitle_moves_100,
  'score_4000' => l.achTitle_score_4000,
  'score_6000' => l.achTitle_score_6000,
  'combo_5' => l.achTitle_combo_5,
  'combo_10' => l.achTitle_combo_10,
  'daily_first' => l.achTitle_daily_first,
  'daily_total_10' => l.achTitle_daily_total_10,
  'daily_total_30' => l.achTitle_daily_total_30,
  'daily_streak_7' => l.achTitle_daily_streak_7,
  'winning_10' => l.achTitle_winning_10,
  'auto_finish' => l.achTitle_auto_finish,
  'marathon' => l.achTitle_marathon,
  'collector_5' => l.achTitle_collector_5,
  'stylist' => l.achTitle_stylist,
  'level_10' => l.achTitle_level_10,
  _ => id,
};

String achievementDescription(AppLocalizations l, AchievementDef a) {
  final id = a.id;
  if (id == 'first_win' || id.startsWith('wins_')) {
    return l.achDescWins(a.target);
  }
  if (id.startsWith('played_')) return l.achDescPlayed(a.target);
  if (id.startsWith('streak_')) return l.achDescStreak(a.target);
  if (id.startsWith('draw3_')) return l.achDescDraw3(a.target);
  if (id.startsWith('speed_')) {
    return l.achDescSpeed(int.parse(id.substring(6)));
  }
  if (id.startsWith('moves_')) {
    return l.achDescMoves(int.parse(id.substring(6)));
  }
  if (id.startsWith('score_')) {
    return l.achDescScore(int.parse(id.substring(6)));
  }
  if (id.startsWith('combo_')) return l.achDescCombo(a.target);
  if (id == 'daily_first' || id.startsWith('daily_total_')) {
    return l.achDescDailyTotal(a.target);
  }
  return switch (id) {
    'no_hints' => l.achDescNoHints,
    'no_undo' => l.achDescNoUndo,
    'purist_10' => l.achDescPurist(a.target),
    'daily_streak_7' => l.achDescDailyStreak(a.target),
    'winning_10' => l.achDescWinning(a.target),
    'auto_finish' => l.achDescAutoFinish,
    'marathon' => l.achDescMarathon(a.target ~/ 60),
    'collector_5' => l.achDescCollector(a.target),
    'stylist' => l.achDescStylist,
    'level_10' => l.achDescLevel(a.target),
    _ => '',
  };
}

String suitName(AppLocalizations l, Suit s) => switch (s) {
  Suit.clubs => l.suitClubs,
  Suit.diamonds => l.suitDiamonds,
  Suit.hearts => l.suitHearts,
  Suit.spades => l.suitSpades,
};

String rankName(AppLocalizations l, int rank) => switch (rank) {
  1 => l.rankAce,
  11 => l.rankJack,
  12 => l.rankQueen,
  13 => l.rankKing,
  _ => '$rank',
};

String cardLabel(AppLocalizations l, PlayingCard c) =>
    l.semCard(rankName(l, c.rank), suitName(l, c.suit));

String modeLabel(AppLocalizations l, GameMode m) => switch (m) {
  GameMode.random => l.modeRandom,
  GameMode.winning => l.modeWinning,
  GameMode.daily => l.modeDaily,
};

/// `m:ss` or `h:mm:ss` (digits are universal across our locales).
String formatClock(int ms) {
  final t = Duration(milliseconds: ms);
  String two(int v) => v.toString().padLeft(2, '0');
  final h = t.inHours,
      m = t.inMinutes.remainder(60),
      s = t.inSeconds.remainder(60);
  return h > 0 ? '$h:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
}

/// Locale-aware upper-casing: Dart's toUpperCase is locale-insensitive, which
/// is wrong for Turkish dotted/dotless i (i→İ, ı→I).
String upperFor(BuildContext context, String s) {
  if (Localizations.localeOf(context).languageCode == 'tr') {
    s = s.replaceAll('i', 'İ').replaceAll('ı', 'I');
  }
  return s.toUpperCase();
}
