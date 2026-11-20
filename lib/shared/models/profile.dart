import '../../core/errors/app_error.dart';
import '../../features/achievements/domain/achievements.dart';
import '../../features/customization/domain/cosmetics.dart';
import '../../features/daily_challenge/domain/daily_challenge.dart';
import '../../features/statistics/domain/player_stats.dart';

/// Result of recording a finished game.
class RecordOutcome {
  const RecordOutcome({
    this.coinsEarned = 0,
    this.xpEarned = 0,
    this.newAchievements = const [],
    this.achievementCoins = 0,
    this.newBestScore = false,
    this.newFastest = false,
    this.dailyRewarded = false,
    this.alreadyRecorded = false,
    this.speedBonus = 0,
  });

  /// Part of [coinsEarned] that came from the speed bonus.
  final int speedBonus;

  final int coinsEarned;
  final int xpEarned;
  final List<String> newAchievements;
  final int achievementCoins;
  final bool newBestScore;
  final bool newFastest;
  final bool dailyRewarded;
  final bool alreadyRecorded;
}

/// The player's local profile: virtual economy, progression, statistics,
/// achievements, daily results and cosmetics.
///
/// Stored as ONE document so that every economic change and the matching
/// idempotency-ledger entry commit atomically. All transitions are pure and
/// idempotent: replaying the same grant key never pays twice.
class ProfileData {
  const ProfileData({
    this.coins = startingCoins,
    this.xp = 0,
    this.hintTokens = startingHints,
    this.ledger = const {},
    this.stats = const PlayerStats(),
    this.achievements = const {},
    this.daily = const {},
    this.owned = const {},
    this.equipped = const EquippedCosmetics(),
    this.updatedAt,
  });

  static const int schemaVersion = 1;
  static const int startingCoins = 250;
  static const int startingHints = 5;
  static const int hintPackSize = 3;
  static const int hintPackPrice = 60;
  static const int rewardedHintCount = 3;
  static const int shufflePrice = 50;

  /// Non-redeemable virtual currency. Never negative.
  final int coins;
  final int xp;
  final int hintTokens;

  /// Idempotency keys of every grant/spend already applied.
  final Set<String> ledger;
  final PlayerStats stats;

  /// Achievement id → unlock time (UTC).
  final Map<String, DateTime> achievements;

  /// Daily date key → result.
  final Map<String, DailyEntry> daily;

  /// Purchased cosmetic ids (free items are implicitly owned).
  final Set<String> owned;
  final EquippedCosmetics equipped;
  final DateTime? updatedAt;

  // ------------------------------------------------------------- progress

  static int xpForLevel(int level) => 75 * (level - 1) * level;

  int get level {
    var l = 1;
    while (xp >= xpForLevel(l + 1)) {
      l++;
    }
    return l;
  }

  /// 0..1 progress towards the next level.
  double get levelProgress {
    final lo = xpForLevel(level), hi = xpForLevel(level + 1);
    return ((xp - lo) / (hi - lo)).clamp(0.0, 1.0);
  }

  int get ownedPurchased => owned.length;

  bool owns(String itemId) {
    final item = cosmeticById(itemId);
    return item != null && (item.isFree || owned.contains(itemId));
  }

  // ------------------------------------------------------------ transitions

  ProfileData copyWith({
    int? coins,
    int? xp,
    int? hintTokens,
    Set<String>? ledger,
    PlayerStats? stats,
    Map<String, DateTime>? achievements,
    Map<String, DailyEntry>? daily,
    Set<String>? owned,
    EquippedCosmetics? equipped,
    DateTime? updatedAt,
  }) => ProfileData(
    coins: coins ?? this.coins,
    xp: xp ?? this.xp,
    hintTokens: hintTokens ?? this.hintTokens,
    ledger: ledger ?? this.ledger,
    stats: stats ?? this.stats,
    achievements: achievements ?? this.achievements,
    daily: daily ?? this.daily,
    owned: owned ?? this.owned,
    equipped: equipped ?? this.equipped,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  /// Grants [amount] coins once for [key]. Returns `this` if already granted.
  ProfileData grantCoins(String key, int amount) {
    if (ledger.contains(key) || amount <= 0) return this;
    return copyWith(coins: coins + amount, ledger: {...ledger, key});
  }

  bool hasGrant(String key) => ledger.contains(key);

  /// Coin reward for a win (documented in GAME_RULES.md#economy).
  static int winCoins(GameResult r) {
    var c = r.drawCount == 3 ? 75 : 50;
    if (r.hintsUsed == 0 && r.undosUsed == 0 && r.shufflesUsed == 0) c += 25;
    return c;
  }

  /// Speed bonus tiers (games are designed to last up to 10 minutes of
  /// active play). Paid only on a first attempt; once per deal is enforced
  /// by the ledger key `speed:<draw>:<seed>` in [recordGame].
  static const speedTiers = <(Duration, int)>[
    (Duration(minutes: 3), 40),
    (Duration(minutes: 5), 25),
    (Duration(minutes: 7), 15),
    (Duration(minutes: 10), 5),
  ];

  static int speedBonusFor(GameResult r) {
    if (!r.won || !r.firstAttempt) return 0;
    for (final (limit, coins) in speedTiers) {
      if (r.elapsedMs < limit.inMilliseconds) return coins;
    }
    return 0;
  }

  static int winXp(GameResult r) => 100 + r.score ~/ 100;

  /// Records a game result once (key `game:<id>`): stats, XP, coins, daily
  /// completion and achievement unlocks.
  (ProfileData, RecordOutcome) recordGame(GameResult r, DateTime now) {
    final key = 'game:${r.gameId}';
    if (ledger.contains(key)) {
      return (this, const RecordOutcome(alreadyRecorded: true));
    }
    final before = stats;
    var p = copyWith(
      stats: stats.record(r),
      ledger: {...ledger, key},
      xp: xp + (r.won ? winXp(r) : 10),
      updatedAt: now.toUtc(),
    );
    var coinsEarned = 0;
    var speedBonus = 0;
    var dailyRewarded = false;
    if (r.won) {
      final c = winCoins(r);
      p = p.grantCoins('win:${r.gameId}', c);
      coinsEarned += c;
      final bonus = speedBonusFor(r);
      final speedKey = 'speed:${r.drawCount}:${r.seed ?? r.gameId}';
      if (bonus > 0 && !p.ledger.contains(speedKey)) {
        p = p.grantCoins(speedKey, bonus);
        coinsEarned += bonus;
        speedBonus = bonus;
      }
      final date = r.dailyDate;
      if (date != null && !p.daily.containsKey(date)) {
        final isToday = date == DailyChallenge.keyFor(now);
        final rewardKey = 'daily:$date';
        final pay = isToday && !p.ledger.contains(rewardKey);
        if (pay) {
          p = p.grantCoins(rewardKey, DailyChallenge.rewardCoins);
          coinsEarned += DailyChallenge.rewardCoins;
          dailyRewarded = true;
        }
        p = p.copyWith(
          daily: {
            ...p.daily,
            date: DailyEntry(
              score: r.score,
              elapsedMs: r.elapsedMs,
              completedAt: now.toUtc(),
              rewarded: pay,
            ),
          },
        );
      }
    }
    final (withAch, unlocked, achCoins) = p.evaluateAchievements(now);
    return (
      withAch,
      RecordOutcome(
        coinsEarned: coinsEarned,
        xpEarned: withAch.xp - xp,
        newAchievements: unlocked,
        achievementCoins: achCoins,
        newBestScore: r.won && r.score > before.total.bestScore,
        newFastest:
            r.won &&
            (before.total.fastestWinMs == null ||
                r.elapsedMs < before.total.fastestWinMs!),
        dailyRewarded: dailyRewarded,
        speedBonus: speedBonus,
      ),
    );
  }

  /// Unlocks every achievement whose target is met (idempotent).
  (ProfileData, List<String>, int) evaluateAchievements(DateTime now) {
    var p = this;
    final unlocked = <String>[];
    var coinsTotal = 0;
    // Loop because unlocking can grant XP/levels that unlock more.
    var changed = true;
    while (changed) {
      changed = false;
      for (final a in achievementCatalog) {
        if (p.achievements.containsKey(a.id)) continue;
        if (a.progress(p, now) < a.target) continue;
        p = p
            .copyWith(achievements: {...p.achievements, a.id: now.toUtc()})
            .grantCoins('ach:${a.id}', a.reward);
        unlocked.add(a.id);
        coinsTotal += a.reward;
        changed = true;
      }
    }
    return (p, unlocked, coinsTotal);
  }

  /// Opt-in rewarded ad "double coins" for a won game, granted once.
  ProfileData doubleWinCoins(String gameId, int amount) =>
      grantCoins('double:$gameId', amount);

  ProfileData purchase(CosmeticItem item) {
    if (owns(item.id)) throw AlreadyOwnedError(item.id);
    if (coins < item.price) throw InsufficientCoinsError(item.price, coins);
    final p = copyWith(
      coins: coins - item.price,
      owned: {...owned, item.id},
      ledger: {...ledger, 'buy:${item.id}'},
    );
    return p.evaluateAchievements(DateTime.now()).$1;
  }

  ProfileData equip(CosmeticItem item) {
    if (!owns(item.id)) throw NotOwnedError(item.id);
    return copyWith(equipped: equipped.withItem(item));
  }

  ProfileData restoreDefaultCosmetics() =>
      copyWith(equipped: const EquippedCosmetics());

  ProfileData buyHintPack(String purchaseId) {
    final key = 'hintpack:$purchaseId';
    if (ledger.contains(key)) return this;
    if (coins < hintPackPrice) {
      throw InsufficientCoinsError(hintPackPrice, coins);
    }
    return copyWith(
      coins: coins - hintPackPrice,
      hintTokens: hintTokens + hintPackSize,
      ledger: {...ledger, key},
    );
  }

  /// Pays for one shuffle; [key] is unique per game and shuffle number, so
  /// a retried tap never charges twice.
  ProfileData payShuffle(String key) {
    final k = 'shuffle:$key';
    if (ledger.contains(k)) return this;
    if (coins < shufflePrice) {
      throw InsufficientCoinsError(shufflePrice, coins);
    }
    return copyWith(coins: coins - shufflePrice, ledger: {...ledger, k});
  }

  /// Records a completed rewarded ad that unlocks one shuffle. Returns
  /// `this` unchanged when the same reward event is replayed.
  ProfileData redeemAdShuffle(String rewardEventId) {
    final k = 'adshuffle:$rewardEventId';
    if (ledger.contains(k)) return this;
    return copyWith(ledger: {...ledger, k});
  }

  /// Rewarded-ad hint grant; [rewardEventId] is unique per completed ad.
  ProfileData grantRewardedHints(String rewardEventId) {
    final key = 'adhints:$rewardEventId';
    if (ledger.contains(key)) return this;
    return copyWith(
      hintTokens: hintTokens + rewardedHintCount,
      ledger: {...ledger, key},
    );
  }

  ProfileData consumeHint() {
    if (hintTokens <= 0) throw const InsufficientCoinsError(1, 0);
    return copyWith(hintTokens: hintTokens - 1);
  }

  // ------------------------------------------------------------------ JSON

  Map<String, Object?> toJson() => {
    'coins': coins,
    'xp': xp,
    'hintTokens': hintTokens,
    'ledger': ledger.toList()..sort(),
    'stats': stats.toJson(),
    'achievements': {
      for (final e in achievements.entries) e.key: e.value.toIso8601String(),
    },
    'daily': {for (final e in daily.entries) e.key: e.value.toJson()},
    'owned': owned.toList()..sort(),
    'equipped': equipped.toJson(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  factory ProfileData.fromJson(Map<String, Object?> j) {
    int nonNeg(Object? v, int def) => v is int && v >= 0 ? v : def;
    return ProfileData(
      coins: nonNeg(j['coins'], 0),
      xp: nonNeg(j['xp'], 0),
      hintTokens: nonNeg(j['hintTokens'], 0),
      ledger: {for (final e in (j['ledger'] as List? ?? const [])) e as String},
      stats: j['stats'] is Map
          ? PlayerStats.fromJson((j['stats']! as Map).cast<String, Object?>())
          : const PlayerStats(),
      achievements: {
        for (final e in ((j['achievements'] as Map?) ?? const {}).entries)
          e.key as String: DateTime.parse(e.value as String),
      },
      daily: {
        for (final e in ((j['daily'] as Map?) ?? const {}).entries)
          e.key as String: DailyEntry.fromJson(
            (e.value as Map).cast<String, Object?>(),
          ),
      },
      owned: {
        for (final e in (j['owned'] as List? ?? const []))
          if (cosmeticById(e as String) != null) e,
      },
      equipped: j['equipped'] is Map
          ? EquippedCosmetics.fromJson(
              (j['equipped']! as Map).cast<String, Object?>(),
            )
          : const EquippedCosmetics(),
      updatedAt: j['updatedAt'] == null
          ? null
          : DateTime.tryParse(j['updatedAt']! as String),
    );
  }
}
