import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/core/ads/ad_service.dart';
import 'package:solitaire_nova/features/statistics/domain/player_stats.dart';
import 'package:solitaire_nova/shared/models/profile.dart';

GameResult win(
  String id,
  int seconds, {
  int seed = 7,
  bool first = true,
  int draw = 1,
}) => GameResult(
  gameId: id,
  drawCount: draw,
  won: true,
  elapsedMs: seconds * 1000,
  moves: 120,
  score: 3000,
  seed: seed,
  firstAttempt: first,
);

void main() {
  final now = DateTime(2026, 11, 20, 12);

  test('speed tiers up to 10 minutes', () {
    expect(ProfileData.speedBonusFor(win('a', 150)), 40);
    expect(ProfileData.speedBonusFor(win('a', 179)), 40);
    expect(ProfileData.speedBonusFor(win('a', 180)), 25);
    expect(ProfileData.speedBonusFor(win('a', 299)), 25);
    expect(ProfileData.speedBonusFor(win('a', 400)), 15);
    expect(ProfileData.speedBonusFor(win('a', 599)), 5);
    expect(ProfileData.speedBonusFor(win('a', 600)), 0);
    expect(
      ProfileData.speedBonusFor(
        const GameResult(
          gameId: 'l',
          drawCount: 1,
          won: false,
          elapsedMs: 1000,
          moves: 3,
        ),
      ),
      0,
    );
  });

  test('speed bonus is added to the win coins and reported', () {
    final (p, o) = const ProfileData().recordGame(win('g1', 120, seed: 1), now);
    expect(o.speedBonus, 40);
    expect(o.coinsEarned, ProfileData.winCoins(win('g1', 120)) + 40);
    expect(
      p.coins,
      ProfileData.startingCoins + o.coinsEarned + o.achievementCoins,
    );
  });

  test('no speed bonus after restarting the deal', () {
    final (_, o) = const ProfileData().recordGame(
      win('g1', 60, first: false),
      now,
    );
    expect(o.speedBonus, 0);
  });

  test('replaying the same deal (daily / winning list) pays speed once', () {
    var p = const ProfileData();
    final (p1, o1) = p.recordGame(win('g1', 100, seed: 99), now);
    final (p2, o2) = p1.recordGame(win('g2', 90, seed: 99), now);
    expect(o1.speedBonus, 40);
    expect(o2.speedBonus, 0, reason: 'same seed, new game id');
    // Same seed in the other draw mode is a different deal configuration.
    final (_, o3) = p2.recordGame(win('g3', 90, seed: 99, draw: 3), now);
    expect(o3.speedBonus, 40);
  });

  test('banner policy: grace moves, sticky, hidden when finished', () {
    const b = BannerPolicy();
    expect(
      b.shouldShow(
        movesPlayed: 9,
        alreadyShownThisGame: false,
        gameFinished: false,
      ),
      isFalse,
    );
    expect(
      b.shouldShow(
        movesPlayed: 10,
        alreadyShownThisGame: false,
        gameFinished: false,
      ),
      isTrue,
    );
    expect(
      b.shouldShow(
        movesPlayed: 8,
        alreadyShownThisGame: true,
        gameFinished: false,
      ),
      isTrue,
      reason: 'undo must not flicker',
    );
    expect(
      b.shouldShow(
        movesPlayed: 40,
        alreadyShownThisGame: true,
        gameFinished: true,
      ),
      isFalse,
    );
  });
}
