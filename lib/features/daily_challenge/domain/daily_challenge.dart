import '../../solitaire/domain/engine/verified_seeds.dart';

/// Daily challenge rules (see docs/GAME_RULES.md#daily-challenge):
///
/// * A challenge is identified by the player's LOCAL calendar date
///   (`yyyy-MM-dd`). Each date maps deterministically to one verified
///   winnable Draw-1 deal, so everyone with the same date gets the same deal
///   and it works fully offline.
/// * Today and any past day of the current and previous month can be played.
///   Future dates are never playable.
/// * The completion reward is granted once per date (idempotency key
///   `daily:<date>`), only for the date that is "today" when completed.
///   Past days earn a check mark and stats, not coins. This makes winding
///   the device clock unprofitable for coins beyond what playing daily gives.
class DailyChallenge {
  const DailyChallenge._();

  static final DateTime epoch = DateTime.utc(2025, 1, 1);
  static const int rewardCoins = 150;

  static String keyFor(DateTime localDate) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${localDate.year.toString().padLeft(4, '0')}-'
        '${two(localDate.month)}-${two(localDate.day)}';
  }

  static DateTime parseKey(String key) {
    final p = key.split('-').map(int.parse).toList();
    return DateTime(p[0], p[1], p[2]);
  }

  static int dayIndex(DateTime localDate) => DateTime.utc(
    localDate.year,
    localDate.month,
    localDate.day,
  ).difference(epoch).inDays;

  /// Deterministic verified-winnable seed for a calendar day.
  static int seedFor(DateTime localDate) {
    final idx = dayIndex(localDate) % verifiedDraw1Seeds.length;
    return verifiedDraw1Seeds[idx < 0 ? idx + verifiedDraw1Seeds.length : idx];
  }

  static bool isPlayable(DateTime day, DateTime today) {
    final d = DateTime(day.year, day.month, day.day);
    final t = DateTime(today.year, today.month, today.day);
    if (d.isAfter(t)) return false;
    final firstAllowed = DateTime(t.year, t.month - 1, 1);
    return !d.isBefore(firstAllowed);
  }

  /// Length of the run of consecutive completed days ending at [today]
  /// (or yesterday, so a streak is not lost before today is played).
  static int currentStreak(Iterable<String> completed, DateTime today) {
    final set = completed.toSet();
    var d = DateTime(today.year, today.month, today.day);
    if (!set.contains(keyFor(d))) d = DateTime(d.year, d.month, d.day - 1);
    var n = 0;
    while (set.contains(keyFor(d))) {
      n++;
      d = DateTime(d.year, d.month, d.day - 1);
    }
    return n;
  }

  static int bestStreak(Iterable<String> completed) {
    final days = completed.map(parseKey).toList()..sort();
    var best = 0, run = 0;
    DateTime? prev;
    for (final d in days) {
      if (prev != null &&
          DateTime(prev.year, prev.month, prev.day + 1) == d) {
        run++;
      } else {
        run = 1;
      }
      if (run > best) best = run;
      prev = d;
    }
    return best;
  }
}

class DailyEntry {
  const DailyEntry({
    required this.score,
    required this.elapsedMs,
    required this.completedAt,
    required this.rewarded,
  });

  final int score;
  final int elapsedMs;
  final DateTime completedAt;
  final bool rewarded;

  Map<String, Object?> toJson() => {
    'score': score,
    'elapsedMs': elapsedMs,
    'completedAt': completedAt.toUtc().toIso8601String(),
    'rewarded': rewarded,
  };

  factory DailyEntry.fromJson(Map<String, Object?> j) => DailyEntry(
    score: j['score'] as int? ?? 0,
    elapsedMs: j['elapsedMs'] as int? ?? 0,
    completedAt: DateTime.parse(j['completedAt']! as String),
    rewarded: j['rewarded'] as bool? ?? false,
  );
}
