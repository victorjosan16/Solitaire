import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/core/ads/ad_service.dart';
import 'package:solitaire_nova/features/daily_challenge/domain/daily_challenge.dart';
import 'package:solitaire_nova/features/settings/application/settings_controller.dart';
import 'package:solitaire_nova/features/solitaire/application/game_controller.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/deck.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/klondike_engine.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/move_advisor.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/solver.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/verified_seeds.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_config.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_mode.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/move.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/pile_ref.dart';
import 'package:solitaire_nova/features/statistics/application/profile_controller.dart';
import 'package:solitaire_nova/shared/models/profile.dart';

import '../../helpers/container.dart';

GameController ctrl(ProviderContainer c) =>
    c.read(gameControllerProvider.notifier);
GameViewState st(ProviderContainer c) => c.read(gameControllerProvider);

/// Plays a verified solution through the controller's public intents.
Future<void> playSolution(ProviderContainer c, List<Move> solution) async {
  for (final m in solution) {
    switch (m) {
      case DrawMove():
      case RecycleMove():
        await ctrl(c).tapStock();
      case TransferMove(:final from, :final to, :final count):
        final ok = await ctrl(c).drop(from, count, to);
        expect(ok, isTrue, reason: '$m');
    }
  }
}

void main() {
  late Directory dir;
  late FakeClock clock;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('nova_ctrl');
    clock = FakeClock();
  });
  tearDown(() => dir.deleteSync(recursive: true));

  test('new game: winning deals come from the verified list', () async {
    final c = await makeContainer(dir, clock: clock);
    await ctrl(c).startNewGame(mode: GameMode.winning, drawCount: 3);
    final s = st(c).snapshot!;
    expect(verifiedDraw3Seeds, contains(s.seed));
    expect(s.config.drawCount, 3);
    expect(s.state, KlondikeEngine.deal(Deck.shuffled(s.seed), s.config));
  });

  test('daily challenge uses the date seed and draw 1', () async {
    final c = await makeContainer(dir, clock: clock);
    await ctrl(c)
        .startNewGame(mode: GameMode.daily, dailyDate: clock.now, drawCount: 3);
    final s = st(c).snapshot!;
    expect(s.seed, DailyChallenge.seedFor(clock.now));
    expect(s.config, GameConfig.draw1);
    expect(s.dailyDate, DailyChallenge.keyFor(clock.now));
  });

  test('settings rule options apply to new games', () async {
    final c = await makeContainer(dir, clock: clock);
    await c
        .read(settingsProvider.notifier)
        .update(
          (s) => s.copyWith(
            unlimitedRecycles: false,
            allowFoundationToTableau: false,
          ),
        );
    await ctrl(c).startNewGame(drawCount: 1);
    expect(st(c).snapshot!.config.maxRecycles, 2);
    expect(st(c).snapshot!.config.allowFoundationToTableau, isFalse);
  });

  test('draw, undo, illegal drop, persistence after every action', () async {
    final c = await makeContainer(dir, clock: clock);
    await ctrl(c).startNewGame();
    final initial = st(c).board!;
    await ctrl(c).tapStock();
    expect(st(c).board!.waste, hasLength(1));
    await ctrl(c).undo();
    expect(st(c).board!, initial.copyWith(), reason: 'undo restores board');
    expect(st(c).snapshot!.undosUsed, 1);

    // Illegal: king-less move to an empty foundation of the wrong rank.
    final before = st(c).board!;
    final ok = await ctrl(c).drop(PileRef.tableau(0), 1, PileRef.tableau(1));
    if (!KlondikeEngine.isLegal(
      before,
      TransferMove(PileRef.tableau(0), PileRef.tableau(1)),
    )) {
      expect(ok, isFalse);
      expect(st(c).invalid, isNotNull);
      expect(st(c).board, before);
    }

    await ctrl(c).tapStock();
    // "Kill" the app and restart on the same storage.
    final c2 = await makeContainer(dir, clock: clock);
    expect(st(c2).snapshot!.gameId, st(c).snapshot!.gameId);
    expect(st(c2).board, st(c).board);
    expect(st(c2).snapshot!.history.length, st(c).snapshot!.history.length);
  });

  test('restart replays the exact initial deal', () async {
    final c = await makeContainer(dir, clock: clock);
    await ctrl(c).startNewGame();
    final initial = st(c).board!;
    final id = st(c).snapshot!.gameId;
    await ctrl(c).tapStock();
    await ctrl(c).tapStock();
    await ctrl(c).restart();
    expect(st(c).board, initial);
    expect(st(c).snapshot!.gameId, id);
    expect(st(c).snapshot!.history, isEmpty);
  });

  test('timer counts only active time and pauses', () async {
    final c = await makeContainer(dir, clock: clock);
    await ctrl(c).startNewGame();
    await ctrl(c).tapStock(); // first move starts the clock
    clock.advance(const Duration(seconds: 30));
    await ctrl(c).pauseAndSave();
    clock.advance(const Duration(minutes: 10)); // backgrounded
    ctrl(c).resumeClock();
    ctrl(c).resumeClock(); // double start must not double count
    clock.advance(const Duration(seconds: 5));
    expect(ctrl(c).elapsedMs, 35000);
    await ctrl(c).pauseAndSave();
    final c2 = await makeContainer(dir, clock: clock);
    expect(ctrl(c2).elapsedMs, 35000);
  });

  test(
    'winning a verified deal records once, coins once, even after restart',
    () async {
      final c = await makeContainer(dir, clock: clock);
      await ctrl(c).startNewGame(mode: GameMode.winning);
      final seed = st(c).snapshot!.seed;
      final sol = KlondikeSolver(maxNodes: 60000)
          .solveSeed(seed, st(c).snapshot!.config);
      expect(sol.solved, isTrue);
      final coinsBefore = c.read(profileProvider).coins;
      clock.advance(const Duration(minutes: 3));
      await playSolution(c, sol.solution!);
      expect(st(c).board!.isWon, isTrue);
      final v = st(c).victory!;
      expect(v.coinsEarned, greaterThan(0));
      final p = c.read(profileProvider);
      expect(p.stats.total.won, 1);
      expect(p.coins, coinsBefore + v.coinsEarned + v.achievementCoins);
      expect(p.achievements.keys, contains('first_win'));

      // Process death after the win: the finished snapshot is re-recorded on
      // startup, but the ledger prevents a second payout.
      final c2 = await makeContainer(dir, clock: clock);
      await Future<void>.delayed(Duration.zero);
      await c2.read(gameControllerProvider.notifier).pauseAndSave();
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(c2.read(profileProvider).coins, p.coins);
      expect(c2.read(profileProvider).stats.total.won, 1);
    },
  );

  test('abandoning a game with progress counts one loss', () async {
    final c = await makeContainer(dir, clock: clock);
    await ctrl(c).startNewGame();
    await ctrl(c).tapStock();
    await ctrl(c).startNewGame();
    await ctrl(c).startNewGame(); // no progress: not counted
    expect(c.read(profileProvider).stats.total.played, 1);
    expect(c.read(profileProvider).stats.total.won, 0);
  });

  test(
    'hints consume tokens; out of tokens and disabled are reported',
    () async {
      final c = await makeContainer(dir, clock: clock);
      await ctrl(c).startNewGame(mode: GameMode.winning);
      final tokens = c.read(profileProvider).hintTokens;
      expect(await ctrl(c).requestHint(), HintResult.shown);
      expect(c.read(profileProvider).hintTokens, tokens - 1);
      expect(st(c).snapshot!.hintsUsed, 1);
      expect(KlondikeEngine.isLegal(st(c).board!, st(c).hint!.value), isTrue);
      for (var i = 1; i < tokens; i++) {
        await ctrl(c).requestHint();
      }
      expect(await ctrl(c).requestHint(), HintResult.noTokens);
      await c
          .read(settingsProvider.notifier)
          .update((s) => s.copyWith(hintsEnabled: false));
      expect(await ctrl(c).requestHint(), HintResult.disabled);
    },
  );

  test('auto finish completes a won position and marks the game', () async {
    final c = await makeContainer(dir, clock: clock);
    await ctrl(c).startNewGame(mode: GameMode.winning);
    final s = st(c).snapshot!;
    final sol = KlondikeSolver(maxNodes: 60000)
        .solveSeed(s.seed, s.config)
        .solution!;
    // Play the solution until auto finish becomes available.
    for (final m in sol) {
      if (st(c).canAutoFinish) break;
      await playSolution(c, [m]);
    }
    expect(st(c).canAutoFinish, isTrue);
    await ctrl(c).autoFinish(stepDelay: Duration.zero);
    expect(st(c).board!.isWon, isTrue);
    expect(st(c).snapshot!.usedAutoFinish, isTrue);
    expect(st(c).autoFinishing, isFalse);
    expect(c.read(profileProvider).stats.autoFinishWins, 1);
  });

  test('cancelling auto finish leaves a consistent board', () async {
    final c = await makeContainer(dir, clock: clock);
    await ctrl(c).startNewGame(mode: GameMode.winning);
    final s = st(c).snapshot!;
    final sol = KlondikeSolver(maxNodes: 60000)
        .solveSeed(s.seed, s.config)
        .solution!;
    for (final m in sol) {
      if (st(c).canAutoFinish) break;
      await playSolution(c, [m]);
    }
    final future = ctrl(c)
        .autoFinish(stepDelay: const Duration(milliseconds: 5));
    await Future<void>.delayed(const Duration(milliseconds: 12));
    ctrl(c).cancelAutoFinish();
    await future;
    final b = st(c).board!;
    expect(Deck.isCompleteDeck(b.allCards), isTrue);
    expect(st(c).autoFinishing, isFalse);
    expect(MoveAdvisor.canAutoFinish(b) || b.isWon, isTrue);
  });

  group('rewarded ads', () {
    Future<ProviderContainer> wonGame(FakeAdService ads) async {
      final c = await makeContainer(dir, clock: clock, ads: ads);
      await ctrl(c).startNewGame(mode: GameMode.winning);
      final s = st(c).snapshot!;
      await playSolution(
        c,
        KlondikeSolver(maxNodes: 60000).solveSeed(s.seed, s.config).solution!,
      );
      return c;
    }

    test('double coins only after a verified reward, once', () async {
      final ads = FakeAdService(nextOutcome: const RewardSkipped());
      final c = await wonGame(ads);
      final base = c.read(profileProvider).coins;
      expect(await ctrl(c).doubleVictoryCoins(), isA<RewardSkipped>());
      expect(c.read(profileProvider).coins, base);
      ads.nextOutcome = const RewardUnavailable(AdUnavailableReason.noFill);
      await ctrl(c).doubleVictoryCoins();
      expect(c.read(profileProvider).coins, base);
      ads.nextOutcome = const RewardEarned('evt-1');
      await ctrl(c).doubleVictoryCoins();
      final doubled = c.read(profileProvider).coins;
      expect(doubled, base + st(c).victory!.coinsEarned);
      // Second attempt (e.g. duplicate callback) is refused and pays nothing.
      expect(await ctrl(c).doubleVictoryCoins(), isA<RewardUnavailable>());
      expect(c.read(profileProvider).coins, doubled);
    });

    test('rewarded hints are idempotent per reward event', () async {
      final ads = FakeAdService(nextOutcome: const RewardEarned('evt-h'));
      final c = await makeContainer(dir, clock: clock, ads: ads);
      final t = c.read(profileProvider).hintTokens;
      await ctrl(c).rewardedHints();
      await ctrl(c).rewardedHints(); // same event id replayed
      expect(
        c.read(profileProvider).hintTokens,
        t + ProfileData.rewardedHintCount,
      );
    });
  });

  test('interstitial policy: never at launch, capped, cooldown', () {
    var now = DateTime(2026);
    final p = InterstitialPolicy(now: () => now);
    p.recordGameFinished();
    p.recordGameFinished();
    expect(p.canShow(), isFalse, reason: 'launch grace');
    now = now.add(const Duration(minutes: 3));
    expect(p.canShow(), isTrue);
    p.recordShown();
    p.recordGameFinished();
    p.recordGameFinished();
    expect(p.canShow(), isFalse, reason: 'cooldown');
    now = now.add(const Duration(minutes: 5));
    expect(p.canShow(), isTrue);
    for (var i = 0; i < 5; i++) {
      p.recordShown();
      p.recordGameFinished();
      p.recordGameFinished();
      now = now.add(const Duration(minutes: 5));
    }
    expect(p.canShow(), isFalse, reason: 'session cap');
    final r = InterstitialPolicy().withRemote(minGames: 0, cooldownSeconds: 1);
    expect(r.minGamesBetween, 2);
    expect(r.cooldown.inSeconds, 120);
  });
}
