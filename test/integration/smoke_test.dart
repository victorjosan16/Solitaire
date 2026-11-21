import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:solitaire_nova/app/router/app_router.dart';
import 'package:solitaire_nova/core/ads/ad_service.dart';
import 'package:solitaire_nova/features/home/presentation/home_screen.dart';
import 'package:solitaire_nova/features/solitaire/application/game_controller.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/solver.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_mode.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/move.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/pile_ref.dart';
import 'package:solitaire_nova/features/solitaire/flame/board_layout.dart';
import 'package:solitaire_nova/features/solitaire/data/game_repository.dart';
import 'package:solitaire_nova/core/database/json_document_store.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_snapshot.dart';
import 'package:solitaire_nova/features/statistics/application/profile_controller.dart';

import 'dart:io';

import 'package:solitaire_nova/features/victory/presentation/victory_screen.dart';

import '../helpers/app_harness.dart';

/// End-to-end smoke flow through the real widgets and the Flame board.
/// Runs headless with `flutter test`; the same file can be moved under
/// integration_test/ to run on a device.
void main() {
  testWidgets(
    'play → tap stock on the board → background → restart → resume → win → claim once',
    (tester) async {
      final ads = FakeAdService(nextOutcome: const RewardEarned('smoke-1'));
      var h = await pumpApp(tester, route: Routes.home, ads: ads);
      await tester.tap(find.text('Play'));
      await settle(tester, const Duration(seconds: 3));

      // Tap the stock through the Flame board (real gesture path).
      final gameBox = tester.getRect(
        find.byWidgetPredicate((w) => w is GameWidget).first,
      );
      final board = h.container.read(gameControllerProvider).board!;
      final layout = BoardLayout.compute(
        Size(gameBox.width, gameBox.height),
        board,
      );
      final stock = layout.slots[PileRef.stock]!.center;
      await tester.tapAt(gameBox.topLeft + stock);
      await settle(tester);
      final afterTap = h.container.read(gameControllerProvider).board!;
      expect(afterTap.waste, hasLength(1), reason: 'stock tap drew a card');
      final gameId = h.container.read(gameControllerProvider).snapshot!.gameId;

      // App goes to background → saved; then the process "dies".
      await h.container.read(gameControllerProvider.notifier).pauseAndSave();
      final dir = h.dir;
      await tester.pumpWidget(const SizedBox());
      h = await pumpApp(
        tester,
        route: Routes.home,
        dir: dir,
        ads: ads,
        game: await _reload(dir),
      );
      expect(find.text('New game'), findsOneWidget); // game in progress
      expect(h.container.read(gameControllerProvider).snapshot!.gameId, gameId);
      expect(h.container.read(gameControllerProvider).board, afterTap);

      // Win a verified deal and claim the doubled coins exactly once.
      final c = h.container.read(gameControllerProvider.notifier);
      await c.startNewGame(mode: GameMode.winning);
      final s = h.container.read(gameControllerProvider).snapshot!;
      h.router.push(Routes.game);
      await settle(tester);
      for (final m in KlondikeSolver(
        maxNodes: 60000,
      ).solveSeed(s.seed, s.config).solution!) {
        switch (m) {
          case DrawMove():
          case RecycleMove():
            await c.tapStock();
          case TransferMove(:final from, :final to, :final count):
            await c.drop(from, count, to);
        }
      }
      await settle(tester, const Duration(seconds: 2));
      expect(find.byType(VictoryScreen), findsOneWidget);
      final before = h.container.read(profileProvider).coins;
      await tester.ensureVisible(find.text('Double coins · watch ad'));
      await settle(tester);
      await tester.tap(find.text('Double coins · watch ad'));
      await settle(tester);
      final after = h.container.read(profileProvider).coins;
      expect(after, greaterThan(before));
      expect(
        find.text('Double coins · watch ad'),
        findsNothing,
        reason: 'offer disappears after claiming',
      );
      await settle(tester, const Duration(seconds: 5)); // snackbar expires
      await tester.ensureVisible(find.text('Main menu'));
      await settle(tester);
      await tester.tap(find.text('Main menu'));
      await settle(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(h.container.read(profileProvider).coins, after);
    },
  );

  testWidgets('daily challenge works offline and pays once', (tester) async {
    final h = await pumpApp(tester, route: Routes.daily);
    await tester.tap(find.text('Play'));
    await settle(tester, const Duration(seconds: 2));
    final c = h.container.read(gameControllerProvider.notifier);
    final s = h.container.read(gameControllerProvider).snapshot!;
    expect(s.mode, GameMode.daily);
    for (final m in KlondikeSolver(
      maxNodes: 60000,
    ).solveSeed(s.seed, s.config).solution!) {
      switch (m) {
        case DrawMove():
        case RecycleMove():
          await c.tapStock();
        case TransferMove(:final from, :final to, :final count):
          await c.drop(from, count, to);
      }
    }
    await settle(tester, const Duration(seconds: 2));
    final v = h.container.read(gameControllerProvider).victory!;
    expect(v.dailyRewarded, isTrue);
    final p = h.container.read(profileProvider);
    expect(p.daily, hasLength(1));
    // Replaying today's challenge does not pay the daily reward again.
    await c.startNewGame(mode: GameMode.daily);
    final s2 = h.container.read(gameControllerProvider).snapshot!;
    for (final m in KlondikeSolver(
      maxNodes: 60000,
    ).solveSeed(s2.seed, s2.config).solution!) {
      switch (m) {
        case DrawMove():
        case RecycleMove():
          await c.tapStock();
        case TransferMove(:final from, :final to, :final count):
          await c.drop(from, count, to);
      }
    }
    await settle(tester, const Duration(seconds: 2));
    expect(
      h.container.read(gameControllerProvider).victory!.dailyRewarded,
      isFalse,
    );
  });
}

Future<GameSnapshot?> _reload(Directory dir) =>
    GameRepository(JsonDocumentStore(dir)).loadCurrent();
