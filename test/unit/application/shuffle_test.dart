import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/core/ads/ad_service.dart';
import 'package:solitaire_nova/features/solitaire/application/game_controller.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/deck.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_mode.dart';
import 'package:solitaire_nova/features/statistics/application/profile_controller.dart';
import 'package:solitaire_nova/features/statistics/domain/player_stats.dart';
import 'package:solitaire_nova/shared/models/profile.dart';

import '../../helpers/container.dart';

GameController ctrl(ProviderContainer c) =>
    c.read(gameControllerProvider.notifier);
GameViewState st(ProviderContainer c) => c.read(gameControllerProvider);

void main() {
  late Directory dir;
  setUp(() => dir = Directory.systemTemp.createTempSync('nova_shuffle'));
  tearDown(() => dir.deleteSync(recursive: true));

  test(
    'pay with coins: reshuffles, keeps foundations, clears undo, max 3',
    () async {
      final c = await makeContainer(dir, clock: FakeClock());
      await ctrl(c).startNewGame(mode: GameMode.winning);
      for (var i = 0; i < 5; i++) {
        await ctrl(c).tapStock();
      }
      final before = st(c).board!;
      final coins = c.read(profileProvider).coins;
      expect(ctrl(c).shufflesLeft, 3);

      expect(await ctrl(c).shuffleWithCoins(), ShuffleResult.done);
      final after = st(c).board!;
      expect(after, isNot(before));
      expect(after.foundations, before.foundations);
      expect(Deck.isCompleteDeck(after.allCards), isTrue);
      expect(
        st(c).snapshot!.history,
        isEmpty,
        reason: 'cannot undo past a shuffle',
      );
      expect(st(c).snapshot!.shufflesUsed, 1);
      expect(c.read(profileProvider).coins, coins - ProfileData.shufflePrice);

      await ctrl(c).shuffleWithCoins();
      await ctrl(c).shuffleWithCoins();
      expect(ctrl(c).shufflesLeft, 0);
      expect(await ctrl(c).shuffleWithCoins(), ShuffleResult.limitReached);
      expect(
        c.read(profileProvider).coins,
        coins - 3 * ProfileData.shufflePrice,
      );

      // Survives a restart of the app.
      final c2 = await makeContainer(dir, clock: FakeClock());
      expect(st(c2).snapshot!.shufflesUsed, 3);
      expect(st(c2).board, st(c).board);
    },
  );

  test('not enough coins: nothing charged, nothing shuffled', () async {
    final c = await makeContainer(dir, clock: FakeClock());
    c.read(profileProvider.notifier).state = const ProfileData(coins: 49);
    await ctrl(c).startNewGame();
    final before = st(c).board;
    expect(await ctrl(c).shuffleWithCoins(), ShuffleResult.insufficientCoins);
    expect(st(c).board, before);
    expect(c.read(profileProvider).coins, 49);
  });

  test(
    'rewarded ad: shuffle only after earned reward, once per event',
    () async {
      final ads = FakeAdService(nextOutcome: const RewardSkipped());
      final c = await makeContainer(dir, clock: FakeClock(), ads: ads);
      c.read(profileProvider.notifier).state = const ProfileData(coins: 0);
      await ctrl(c).startNewGame();
      final before = st(c).board;

      await ctrl(c).shuffleWithAd();
      expect(st(c).board, before, reason: 'skipped ad gives nothing');
      ads.nextOutcome = const RewardUnavailable(AdUnavailableReason.noFill);
      await ctrl(c).shuffleWithAd();
      expect(st(c).board, before);

      ads.nextOutcome = const RewardEarned('ev-1');
      await ctrl(c).shuffleWithAd();
      expect(st(c).snapshot!.shufflesUsed, 1);
      final once = st(c).board;
      await ctrl(c).shuffleWithAd(); // duplicate callback / replayed event
      expect(st(c).snapshot!.shufflesUsed, 1);
      expect(st(c).board, once);
      expect(c.read(profileProvider).coins, 0);
    },
  );

  test('a shuffled win is an assisted win: no clean bonus, not pure', () {
    const r = GameResult(
      gameId: 'g',
      drawCount: 1,
      won: true,
      elapsedMs: 900000,
      moves: 200,
      shufflesUsed: 1,
    );
    expect(ProfileData.winCoins(r), 50);
    final p = const ProfileData().recordGame(r, DateTime(2026)).$1;
    expect(p.stats.winsPure, 0);
  });
}
