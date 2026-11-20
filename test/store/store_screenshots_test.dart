@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:solitaire_nova/app/router/app_router.dart';
import 'package:solitaire_nova/features/solitaire/application/game_controller.dart';
import 'package:solitaire_nova/features/solitaire/domain/engine/move_advisor.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_mode.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/move.dart';

import '../golden/screens_golden_test.dart' show sampleProfile;
import '../helpers/app_harness.dart';

/// Google Play phone screenshots: 1080×1920 (9:16). Regenerate with
/// `flutter test test/store --update-goldens`.
void main() {
  final now = DateTime(2026, 11, 20, 10);
  DateTime clock() => now;
  const size = Size(360, 640);
  const dpr = 3.0;
  String out(String n) => '../../distribution/screenshots/$n.png';

  for (final (i, route) in [
    Routes.home,
    Routes.daily,
    Routes.themes,
    Routes.achievements,
  ].indexed) {
    testWidgets('store $route', (tester) async {
      await pumpApp(
        tester,
        size: size,
        dpr: dpr,
        route: route,
        profile: sampleProfile(now),
        clock: clock,
      );
      await settle(tester);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile(out('0${i + 2}_${route.substring(1)}')),
      );
    });
  }

  testWidgets('store game', (tester) async {
    final h = await pumpApp(
      tester,
      size: size,
      dpr: dpr,
      route: Routes.home,
      profile: sampleProfile(now),
      clock: clock,
    );
    final c = h.container.read(gameControllerProvider.notifier);
    await c.startNewGame(mode: GameMode.winning, drawCount: 1);
    h.router.push(Routes.game);
    await settle(tester, const Duration(seconds: 3));
    for (var i = 0; i < 9; i++) {
      final m = MoveAdvisor.hint(
        h.container.read(gameControllerProvider).board!,
      );
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
      matchesGoldenFile(out('01_game')),
    );
  });
}
