import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/core/errors/app_error.dart';
import 'package:solitaire_nova/features/achievements/domain/achievements.dart';
import 'package:solitaire_nova/features/customization/domain/cosmetics.dart';
import 'package:solitaire_nova/features/daily_challenge/domain/daily_challenge.dart';
import 'package:solitaire_nova/features/statistics/domain/player_stats.dart';
import 'package:solitaire_nova/shared/models/profile.dart';

GameResult win(
  String id, {
  int draw = 1,
  int ms = 400000,
  int hints = 0,
  int undos = 0,
  String? daily,
  int score = 3000,
  int moves = 150,
}) => GameResult(
  gameId: id,
  drawCount: draw,
  won: true,
  score: score,
  elapsedMs: ms,
  moves: moves,
  hintsUsed: hints,
  undosUsed: undos,
  dailyDate: daily,
);

void main() {
  final now = DateTime(2026, 11, 20, 12);

  test('catalog has 30+ unique achievements', () {
    expect(achievementCatalog.length, greaterThanOrEqualTo(30));
    expect(
      achievementCatalog.map((a) => a.id).toSet().length,
      achievementCatalog.length,
    );
  });

  test('coin grants are idempotent', () {
    var p = const ProfileData();
    p = p.grantCoins('x', 100);
    final once = p.coins;
    p = p.grantCoins('x', 100).grantCoins('x', 100);
    expect(p.coins, once);
  });

  test('recording the same game twice pays once (restart / retry safe)', () {
    var p = const ProfileData();
    final (a, outA) = p.recordGame(win('g1'), now);
    final (b, outB) = a.recordGame(win('g1'), now);
    expect(outA.coinsEarned, greaterThan(0));
    expect(outB.alreadyRecorded, isTrue);
    expect(b.coins, a.coins);
    expect(b.stats.total.won, 1);
    expect(outA.newAchievements, contains('first_win'));
    p = b;
  });

  test('stats: streaks, best score, fastest, per draw mode', () {
    var p = const ProfileData();
    p = p.recordGame(win('a', ms: 200000, score: 4000), now).$1;
    p = p.recordGame(win('b', draw: 3, ms: 100000, score: 2000), now).$1;
    p = p
        .recordGame(
          const GameResult(
            gameId: 'c',
            drawCount: 1,
            won: false,
            elapsedMs: 5000,
            moves: 3,
          ),
          now,
        )
        .$1;
    expect(p.stats.total.played, 3);
    expect(p.stats.total.won, 2);
    expect(p.stats.draw3.won, 1);
    expect(p.stats.overallStreak, 0);
    expect(p.stats.overallBestStreak, 2);
    expect(p.stats.total.bestScore, 4000);
    expect(p.stats.total.fastestWinMs, 100000);
    expect(p.stats.total.winRate, closeTo(2 / 3, 1e-9));
    expect(p.achievements.containsKey('speed_2'), isTrue);
    expect(p.achievements.containsKey('draw3_first'), isTrue);
  });

  test('achievement unlocks once and grants its reward once', () {
    var p = const ProfileData();
    p = p.recordGame(win('a'), now).$1;
    final coins = p.coins;
    final (again, unlocked, extra) = p.evaluateAchievements(now);
    expect(unlocked, isEmpty);
    expect(extra, 0);
    expect(again.coins, coins);
  });

  test('daily reward only once and only for today', () {
    final today = DailyChallenge.keyFor(now);
    final yesterday = DailyChallenge.keyFor(
      now.subtract(const Duration(days: 1)),
    );
    var p = const ProfileData();
    final (p1, o1) = p.recordGame(win('d1', daily: today), now);
    expect(o1.dailyRewarded, isTrue);
    // A second winning game of the same daily pays no daily reward.
    final (p2, o2) = p1.recordGame(win('d2', daily: today), now);
    expect(o2.dailyRewarded, isFalse);
    expect(
      p2.coins - p1.coins,
      ProfileData.winCoins(win('d2')) + ProfileData.speedBonusFor(win('d2')),
      reason: 'win + speed bonus, but no second daily reward',
    );
    // Past day: completion recorded, no daily coins.
    final (p3, o3) = p2.recordGame(win('d3', daily: yesterday), now);
    expect(o3.dailyRewarded, isFalse);
    expect(p3.daily.keys, containsAll([today, yesterday]));
  });

  test('purchases: insufficient coins, already owned, never negative', () {
    final item = cosmeticById('cards.gold')!;
    const p = ProfileData(coins: 10);
    expect(() => p.purchase(item), throwsA(isA<InsufficientCoinsError>()));
    final rich = const ProfileData(coins: 5000).purchase(item);
    expect(rich.coins, 4000);
    expect(rich.owns(item.id), isTrue);
    expect(() => rich.purchase(item), throwsA(isA<AlreadyOwnedError>()));
    expect(rich.owns('cards.classic'), isTrue, reason: 'free item');
    expect(() => p.equip(item), throwsA(isA<NotOwnedError>()));
    expect(rich.equip(item).equipped.cards, 'cards.gold');
  });

  test('hint tokens: pack purchase and rewarded grant are idempotent', () {
    var p = const ProfileData(coins: 100, hintTokens: 0);
    expect(() => p.consumeHint(), throwsA(isA<InsufficientCoinsError>()));
    p = p.buyHintPack('p1').buyHintPack('p1');
    expect(p.hintTokens, ProfileData.hintPackSize);
    expect(p.coins, 100 - ProfileData.hintPackPrice);
    p = p.grantRewardedHints('ad1').grantRewardedHints('ad1');
    expect(
      p.hintTokens,
      ProfileData.hintPackSize + ProfileData.rewardedHintCount,
    );
  });

  test('double coins only once per game', () {
    var p = const ProfileData();
    p = p.doubleWinCoins('g', 50).doubleWinCoins('g', 50);
    expect(p.coins, ProfileData.startingCoins + 50);
  });

  test('levels', () {
    expect(const ProfileData(xp: 0).level, 1);
    expect(const ProfileData(xp: 150).level, 2);
    expect(const ProfileData(xp: 449).level, 2);
    expect(const ProfileData(xp: 450).level, 3);
    expect(const ProfileData(xp: 300).levelProgress, closeTo(0.5, 1e-9));
  });

  test('JSON round trip and hostile values are sanitized', () {
    var p = const ProfileData();
    p = p.recordGame(win('a', daily: DailyChallenge.keyFor(now)), now).$1;
    final back = ProfileData.fromJson(p.toJson());
    expect(back.coins, p.coins);
    expect(back.ledger, p.ledger);
    expect(back.achievements.keys, p.achievements.keys);
    expect(back.daily.keys, p.daily.keys);
    expect(back.stats.total.won, 1);
    final bad = ProfileData.fromJson({
      'coins': -500,
      'owned': ['cards.gold', 'hacked.item'],
      'equipped': {'cards': 'nope'},
    });
    expect(bad.coins, 0);
    expect(bad.owned, {'cards.gold'});
    expect(bad.equipped.cards, EquippedCosmetics.defaultCards);
  });

  group('Daily challenge', () {
    test('deterministic, date-specific, verified seeds', () {
      final a = DailyChallenge.seedFor(DateTime(2026, 3, 1));
      expect(DailyChallenge.seedFor(DateTime(2026, 3, 1, 23, 59)), a);
      expect(DailyChallenge.seedFor(DateTime(2026, 3, 2)), isNot(a));
    });

    test('playable window: no future days, current + previous month', () {
      final t = DateTime(2026, 11, 20);
      expect(DailyChallenge.isPlayable(DateTime(2026, 11, 21), t), isFalse);
      expect(DailyChallenge.isPlayable(DateTime(2026, 11, 20), t), isTrue);
      expect(DailyChallenge.isPlayable(DateTime(2026, 10, 1), t), isTrue);
      expect(DailyChallenge.isPlayable(DateTime(2026, 9, 30), t), isFalse);
    });

    test('streaks', () {
      final keys = ['2026-11-18', '2026-11-19', '2026-11-20', '2026-11-10'];
      expect(DailyChallenge.currentStreak(keys, DateTime(2026, 11, 20)), 3);
      expect(DailyChallenge.currentStreak(keys, DateTime(2026, 11, 21)), 3);
      expect(DailyChallenge.currentStreak(keys, DateTime(2026, 11, 22)), 0);
      expect(DailyChallenge.bestStreak(keys), 3);
      expect(DailyChallenge.bestStreak(['2026-12-31', '2027-01-01']), 2);
    });
  });
}
