import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:solitaire_nova/app/router/app_router.dart';
import 'package:solitaire_nova/features/solitaire/application/game_controller.dart';
import 'package:solitaire_nova/features/statistics/application/profile_controller.dart';
import 'package:solitaire_nova/shared/models/profile.dart';

import '../helpers/app_harness.dart';

void main() {
  testWidgets('Shuffle button → confirm → pay 50 coins', (tester) async {
    final h = await pumpApp(
      tester,
      size: const Size(320, 640),
      route: Routes.home,
    );
    final c = h.container.read(gameControllerProvider.notifier);
    await c.startNewGame();
    h.router.push(Routes.game);
    await settle(tester, const Duration(seconds: 2));
    final coins = h.container.read(profileProvider).coins;

    await tester.tap(find.text('Shuffle'));
    await settle(tester);
    expect(find.text('Shuffle the cards?'), findsOneWidget);
    await tester.tap(find.text('Pay 50 coins'));
    await settle(tester);

    expect(h.container.read(gameControllerProvider).snapshot!.shufflesUsed, 1);
    expect(
      h.container.read(profileProvider).coins,
      coins - ProfileData.shufflePrice,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('not enough coins shows the insufficient-coins dialog', (
    tester,
  ) async {
    final h = await pumpApp(
      tester,
      size: const Size(320, 640),
      route: Routes.home,
      profile: const ProfileData(coins: 10),
    );
    final c = h.container.read(gameControllerProvider.notifier);
    await c.startNewGame();
    h.router.push(Routes.game);
    await settle(tester, const Duration(seconds: 2));
    await tester.tap(find.text('Shuffle'));
    await settle(tester);
    await tester.tap(find.text('Pay 50 coins'));
    await settle(tester);
    expect(find.text('Not enough coins'), findsOneWidget);
    expect(h.container.read(gameControllerProvider).snapshot!.shufflesUsed, 0);
  });
}
