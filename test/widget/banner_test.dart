import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/app/router/app_router.dart';
import 'package:solitaire_nova/core/ads/ad_service.dart';
import 'package:solitaire_nova/features/solitaire/application/game_controller.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_mode.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/app_harness.dart';

void main() {
  for (final size in const [Size(320, 640), Size(390, 844)]) {
    testWidgets('banner appears at the top only after 10 moves ($size)', (
      tester,
    ) async {
      final ads = FakeAdService()..banners = true;
      final h = await pumpApp(tester, size: size, route: Routes.home, ads: ads);
      final c = h.container.read(gameControllerProvider.notifier);
      await c.startNewGame(mode: GameMode.winning, drawCount: 1);
      h.router.push(Routes.game);
      await settle(tester, const Duration(seconds: 2));
      for (var i = 0; i < 9; i++) {
        await c.tapStock();
      }
      await settle(tester);
      expect(find.text('Test banner'), findsNothing);
      expect(ads.bannersLoaded, 0);

      await c.tapStock(); // 10th move
      await settle(tester);
      expect(find.text('Test banner'), findsOneWidget);
      expect(ads.bannersLoaded, 1);
      // Banner is above the HUD (top of the screen).
      final bannerY = tester.getCenter(find.text('Test banner')).dy;
      final pauseY = tester.getCenter(find.byTooltip('Pause')).dy;
      expect(bannerY, lessThan(pauseY));

      // Undo below 10 moves does not hide it (no flicker), nor reload it.
      await c.undo();
      await c.undo();
      await settle(tester);
      expect(find.text('Test banner'), findsOneWidget);
      expect(ads.bannersLoaded, 1);

      // A new game starts ad-free again.
      await c.startNewGame();
      await settle(tester);
      expect(find.text('Test banner'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('no banner when ads are disabled', (tester) async {
    final h = await pumpApp(tester, route: Routes.home);
    final c = h.container.read(gameControllerProvider.notifier);
    await c.startNewGame();
    h.router.push(Routes.game);
    await settle(tester);
    for (var i = 0; i < 12; i++) {
      await c.tapStock();
    }
    await settle(tester);
    expect(find.text('Test banner'), findsNothing);
  });
}
