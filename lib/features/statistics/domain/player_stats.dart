/// Outcome of a finished (won) or abandoned game, fed to the profile.
class GameResult {
  const GameResult({
    required this.gameId,
    required this.drawCount,
    required this.won,
    required this.elapsedMs,
    required this.moves,
    this.score = 0,
    this.hintsUsed = 0,
    this.undosUsed = 0,
    this.maxCombo = 0,
    this.usedAutoFinish = false,
    this.winningDeal = false,
    this.dailyDate,
    this.seed,
    this.firstAttempt = true,
  });

  final String gameId;

  /// Deal seed; the speed bonus is paid at most once per deal.
  final int? seed;

  /// False after "Restart deal" (the player has already seen the cards).
  final bool firstAttempt;
  final int drawCount;
  final bool won;
  final int score;
  final int elapsedMs;
  final int moves;
  final int hintsUsed;
  final int undosUsed;
  final int maxCombo;
  final bool usedAutoFinish;
  final bool winningDeal;
  final String? dailyDate;
}

/// Per draw-mode statistics.
class ModeStats {
  const ModeStats({
    this.played = 0,
    this.won = 0,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.bestScore = 0,
    this.fastestWinMs,
    this.fewestMovesWin,
    this.totalPlayMs = 0,
  });

  final int played;
  final int won;
  final int currentStreak;
  final int bestStreak;
  final int bestScore;
  final int? fastestWinMs;
  final int? fewestMovesWin;
  final int totalPlayMs;

  double get winRate => played == 0 ? 0 : won / played;

  ModeStats record(GameResult r) {
    final streak = r.won ? currentStreak + 1 : 0;
    return ModeStats(
      played: played + 1,
      won: won + (r.won ? 1 : 0),
      currentStreak: streak,
      bestStreak: streak > bestStreak ? streak : bestStreak,
      bestScore: r.won && r.score > bestScore ? r.score : bestScore,
      fastestWinMs:
          r.won && (fastestWinMs == null || r.elapsedMs < fastestWinMs!)
          ? r.elapsedMs
          : fastestWinMs,
      fewestMovesWin:
          r.won && (fewestMovesWin == null || r.moves < fewestMovesWin!)
          ? r.moves
          : fewestMovesWin,
      totalPlayMs: totalPlayMs + r.elapsedMs,
    );
  }

  /// Combines two modes for the "Total" view (streaks: best of either;
  /// the overall current streak is tracked separately in [PlayerStats]).
  ModeStats operator +(ModeStats o) => ModeStats(
    played: played + o.played,
    won: won + o.won,
    currentStreak: currentStreak > o.currentStreak
        ? currentStreak
        : o.currentStreak,
    bestStreak: bestStreak > o.bestStreak ? bestStreak : o.bestStreak,
    bestScore: bestScore > o.bestScore ? bestScore : o.bestScore,
    fastestWinMs: _minN(fastestWinMs, o.fastestWinMs),
    fewestMovesWin: _minN(fewestMovesWin, o.fewestMovesWin),
    totalPlayMs: totalPlayMs + o.totalPlayMs,
  );

  static int? _minN(int? a, int? b) =>
      a == null ? b : (b == null ? a : (a < b ? a : b));

  Map<String, Object?> toJson() => {
    'played': played,
    'won': won,
    'currentStreak': currentStreak,
    'bestStreak': bestStreak,
    'bestScore': bestScore,
    'fastestWinMs': fastestWinMs,
    'fewestMovesWin': fewestMovesWin,
    'totalPlayMs': totalPlayMs,
  };

  factory ModeStats.fromJson(Map<String, Object?> j) => ModeStats(
    played: j['played'] as int? ?? 0,
    won: j['won'] as int? ?? 0,
    currentStreak: j['currentStreak'] as int? ?? 0,
    bestStreak: j['bestStreak'] as int? ?? 0,
    bestScore: j['bestScore'] as int? ?? 0,
    fastestWinMs: j['fastestWinMs'] as int?,
    fewestMovesWin: j['fewestMovesWin'] as int?,
    totalPlayMs: j['totalPlayMs'] as int? ?? 0,
  );
}

class PlayerStats {
  const PlayerStats({
    this.draw1 = const ModeStats(),
    this.draw3 = const ModeStats(),
    this.overallStreak = 0,
    this.overallBestStreak = 0,
    this.maxCombo = 0,
    this.winsNoHints = 0,
    this.winsNoUndo = 0,
    this.winsPure = 0,
    this.winningDealWins = 0,
    this.autoFinishWins = 0,
  });

  final ModeStats draw1;
  final ModeStats draw3;
  final int overallStreak;
  final int overallBestStreak;
  final int maxCombo;
  final int winsNoHints;
  final int winsNoUndo;

  /// Wins with neither hints nor undo.
  final int winsPure;
  final int winningDealWins;
  final int autoFinishWins;

  ModeStats get total => draw1 + draw3;

  PlayerStats record(GameResult r) {
    final streak = r.won ? overallStreak + 1 : 0;
    final pure = r.won && r.hintsUsed == 0 && r.undosUsed == 0;
    return PlayerStats(
      draw1: r.drawCount == 1 ? draw1.record(r) : draw1,
      draw3: r.drawCount == 3 ? draw3.record(r) : draw3,
      overallStreak: streak,
      overallBestStreak: streak > overallBestStreak
          ? streak
          : overallBestStreak,
      maxCombo: r.maxCombo > maxCombo ? r.maxCombo : maxCombo,
      winsNoHints: winsNoHints + (r.won && r.hintsUsed == 0 ? 1 : 0),
      winsNoUndo: winsNoUndo + (r.won && r.undosUsed == 0 ? 1 : 0),
      winsPure: winsPure + (pure ? 1 : 0),
      winningDealWins: winningDealWins + (r.won && r.winningDeal ? 1 : 0),
      autoFinishWins: autoFinishWins + (r.won && r.usedAutoFinish ? 1 : 0),
    );
  }

  Map<String, Object?> toJson() => {
    'draw1': draw1.toJson(),
    'draw3': draw3.toJson(),
    'overallStreak': overallStreak,
    'overallBestStreak': overallBestStreak,
    'maxCombo': maxCombo,
    'winsNoHints': winsNoHints,
    'winsNoUndo': winsNoUndo,
    'winsPure': winsPure,
    'winningDealWins': winningDealWins,
    'autoFinishWins': autoFinishWins,
  };

  factory PlayerStats.fromJson(Map<String, Object?> j) {
    ModeStats m(Object? o) => o is Map
        ? ModeStats.fromJson(o.cast<String, Object?>())
        : const ModeStats();
    return PlayerStats(
      draw1: m(j['draw1']),
      draw3: m(j['draw3']),
      overallStreak: j['overallStreak'] as int? ?? 0,
      overallBestStreak: j['overallBestStreak'] as int? ?? 0,
      maxCombo: j['maxCombo'] as int? ?? 0,
      winsNoHints: j['winsNoHints'] as int? ?? 0,
      winsNoUndo: j['winsNoUndo'] as int? ?? 0,
      winsPure: j['winsPure'] as int? ?? 0,
      winningDealWins: j['winningDealWins'] as int? ?? 0,
      autoFinishWins: j['autoFinishWins'] as int? ?? 0,
    );
  }
}
