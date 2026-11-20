@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:solitaire_nova/app/router/app_router.dart';
import 'package:solitaire_nova/core/ads/ad_service.dart';
import 'package:solitaire_nova/features/solitaire/application/game_controller.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/move_advisor.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/solver.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_mode.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/move.dart';
import 'package:solitaire_nova/features/statistics/domain/player_stats.dart';
import 'package:solitaire_nova/shared/models/profile.dart';

import '../helpers/app_harness.dart';

/// A plausible mid-progress profile for screenshots (built through the real
/// transitions, not hand-written numbers).
ProfileData sampleProfile(DateTime now) {
  var p = const ProfileData(coins: 3250);
  for (var i = 0; i < 14; i++) {
    final won = i % 5 != 4;
    p = p
        .recordGame(
          GameResult(
            gameId: 'g$i',
            drawCount: i % 3 == 0 ? 3 : 1,
            won: won,
            score: 2800 + i * 120,
            elapsedMs: 170000 + i * 9000,
            moves: 110 + i * 3,
            hintsUsed: i % 2,
            maxCombo: 3 + i % 6,
            dailyDate: won && i < 6
                ? '2026-11-${(13 + i).toString().padLeft(2, '0')}'
                : null,
          ),
          now,
        )
        .$1;
  }
  return p.copyWith(coins: 3250);
}

void main() {
  final now = DateTime(2026, 11, 20, 10);
  DateTime clock() => now;

  for (final (name, size) in [
    ('phone', const Size(390, 844)),
    ('small', const Size(320, 640)),
    ('tablet', const Size(1180, 820)),
  ]) {
    group(name, () {
      for (final route in [
        Routes.home,
        Routes.daily,
        Routes.themes,
        Routes.stats,
        Routes.achievements,
        Routes.shop,
        Routes.settings,
      ]) {
        testWidgets('screen $route', (tester) async {
          await pumpApp(
            tester,
            size: size,
            route: route,
            profile: sampleProfile(now),
            clock: clock,
          );
          await settle(tester);
          await expectLater(
            find.byType(MaterialApp),
            matchesGoldenFile('goldens/$name${route.replaceAll('/', '_')}.png'),
          );
        });
      }

      testWidgets('screen splash', (tester) async {
        await pumpApp(
          tester,
          size: size,
          profile: sampleProfile(now),
          clock: clock,
        );
        await tester.pump(const Duration(milliseconds: 900));
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/${name}_splash.png'),
        );
        await settle(tester, const Duration(seconds: 2));
      });

      testWidgets('screen game + victory', (tester) async {
        final h = await pumpApp(
          tester,
          size: size,
          route: Routes.home,
          profile: sampleProfile(now),
          clock: clock,
        );
        await h.container
            .read(gameControllerProvider.notifier)
            .startNewGame(mode: GameMode.winning, drawCount: 1);
        h.router.push(Routes.game);
        await settle(tester, const Duration(seconds: 3));
        // Play a few advisor moves so the board is mid-game.
        final c = h.container.read(gameControllerProvider.notifier);
        for (var i = 0; i < 14; i++) {
          final b = h.container.read(gameControllerProvider).board!;
          final m = MoveAdvisor.hint(b);
          if (m == null) break;
          switch (m) {
            case DrawMove():
            case RecycleMove():
              await c.tapStock();
            case TransferMove(:final from, :final to, :final count):
              await c.drop(from, count, to);
          }
          await tester.pump(const Duration(milliseconds: 300));
        }
        await settle(tester);
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/${name}_game.png'),
        );
      });
    });
  }

  Future<void> winGame(Harness h) async {
    final c = h.container.read(gameControllerProvider.notifier);
    await c.startNewGame(mode: GameMode.winning, drawCount: 1);
    final snap = h.container.read(gameControllerProvider).snapshot!;
    final sol = KlondikeSolver(maxNodes: 60000)
        .solveSeed(snap.seed, snap.config)
        .solution!;
    for (final m in sol) {
      switch (m) {
        case DrawMove():
        case RecycleMove():
          await c.tapStock();
        case TransferMove(:final from, :final to, :final count):
          await c.drop(from, count, to);
      }
    }
  }

  for (final (name, size) in [
    ('phone', const Size(390, 844)),
    ('small', const Size(320, 640)),
  ]) {
    testWidgets('$name screen victory', (tester) async {
      final h = await pumpApp(
        tester,
        size: size,
        route: Routes.home,
        profile: sampleProfile(now),
        clock: clock,
      );
      await winGame(h);
      h.router.go(Routes.victory);
      await settle(tester, const Duration(seconds: 2));
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/${name}_victory.png'),
      );
    });
  }

  for (final code in ['ru', 'uk']) {
    testWidgets('$code localized screens', (tester) async {
      final h = await pumpApp(
        tester,
        size: const Size(360, 760),
        prefs: {'settings.consentAnswered': true, 'settings.locale': code},
        route: Routes.home,
        profile: sampleProfile(now),
        clock: clock,
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/${code}_home.png'),
      );
      h.router.go(Routes.achievements);
      await settle(tester);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/${code}_achievements.png'),
      );
      await winGame(h);
      h.router.go(Routes.victory);
      await settle(tester, const Duration(seconds: 2));
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/${code}_victory.png'),
      );
    });
  }

  testWidgets('small game with top banner', (tester) async {
    final ads = FakeAdService()..banners = true;
    final h = await pumpApp(
      tester,
      size: const Size(320, 640),
      route: Routes.home,
      profile: sampleProfile(now),
      clock: clock,
      ads: ads,
    );
    final c = h.container.read(gameControllerProvider.notifier);
    await c.startNewGame(mode: GameMode.winning, drawCount: 1);
    h.router.push(Routes.game);
    await settle(tester, const Duration(seconds: 3));
    for (var i = 0; i < 14; i++) {
      final b = h.container.read(gameControllerProvider).board!;
      final m = MoveAdvisor.hint(b);
      if (m == null) break;
      switch (m) {
        case DrawMove():
        case RecycleMove():
          await c.tapStock();
        case TransferMove(:final from, :final to, :final count):
          await c.drop(from, count, to);
      }
      await tester.pump(const Duration(milliseconds: 300));
    }
    await settle(tester);
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/small_game_banner.png'),
    );
  });
}
