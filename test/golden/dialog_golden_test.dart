@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:solitaire_nova/app/router/app_router.dart';
import 'package:solitaire_nova/features/solitaire/application/game_controller.dart';

import '../helpers/app_harness.dart';

void main() {
  for (final (name, size, locale) in [
    ('phone_ro', const Size(390, 844), 'ro'),
    ('small_de', const Size(320, 640), 'de'),
  ]) {
    testWidgets('shuffle dialog $name', (tester) async {
      final h = await pumpApp(
        tester,
        size: size,
        route: Routes.home,
        prefs: {'settings.consentAnswered': true, 'settings.locale': locale},
      );
      await h.container.read(gameControllerProvider.notifier).startNewGame();
      h.router.push(Routes.game);
      await settle(tester, const Duration(seconds: 2));
      await tester.tap(find.byIcon(Icons.shuffle_rounded).first);
      await settle(tester);
      expect(tester.takeException(), isNull);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/${name}_shuffle_dialog.png'),
      );
    });
  }
}
