import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/app/router/app_router.dart';
import 'package:solitaire_nova/features/daily_challenge/presentation/daily_screen.dart';
import 'package:solitaire_nova/features/home/presentation/home_screen.dart';
import 'package:solitaire_nova/features/settings/presentation/settings_screen.dart';
import 'package:solitaire_nova/features/shop/presentation/shop_screen.dart';
import 'package:solitaire_nova/features/solitaire/application/game_controller.dart';
import 'package:solitaire_nova/features/solitaire/presentation/game_screen.dart';
import 'package:solitaire_nova/features/statistics/application/profile_controller.dart';
import 'package:solitaire_nova/features/profile/presentation/profile_screen.dart';
import 'package:solitaire_nova/shared/models/profile.dart';

import '../helpers/app_harness.dart';

void main() {
  testWidgets('splash goes to home without network', (tester) async {
    await pumpApp(tester);
    await settle(tester, const Duration(seconds: 2));
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('home navigates to every screen and back', (tester) async {
    await pumpApp(tester, route: Routes.home);
    Future<void> visit(String label, Type screen) async {
      await tester.tap(find.text(label).first);
      await settle(tester);
      expect(find.byType(screen), findsOneWidget, reason: label);
      await tester.tap(find.byTooltip('Back').first);
      await settle(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
    }

    await visit('Daily Challenge', DailyScreen);
    await visit('Profile', ProfileScreen);
    await visit('Shop', ShopScreen);
    await visit('Settings', SettingsScreen);
    // Home is intentionally minimal: no draw-mode / deal-type toggles.
    expect(find.text('Draw 3'), findsNothing);
    expect(find.text('Winning deal'), findsNothing);
  });

  testWidgets('first launch shows the privacy prompt once', (tester) async {
    final h = await pumpApp(tester, prefs: const {}, route: Routes.home);
    await settle(tester);
    expect(find.text('Your privacy'), findsOneWidget);
    await tester.tap(find.text('Essential only'));
    await settle(tester);
    expect(find.text('Your privacy'), findsNothing);
    h.router.go(Routes.stats);
    await settle(tester);
    h.router.go(Routes.home);
    await settle(tester);
    expect(find.text('Your privacy'), findsNothing);
  });

  testWidgets('play classic opens the board; pause dialog; restart confirm', (
    tester,
  ) async {
    final h = await pumpApp(tester, route: Routes.home);
    await tester.tap(find.text('Play'));
    await settle(tester, const Duration(seconds: 3));
    expect(find.byType(GameScreen), findsOneWidget);
    final c = h.container.read(gameControllerProvider.notifier);
    // Undo and Auto disabled at the start.
    expect(h.container.read(gameControllerProvider).snapshot!.history, isEmpty);
    await c.tapStock();
    await settle(tester);
    expect(find.text('1'), findsWidgets); // moves counter
    await tester.tap(find.byTooltip('Pause'));
    await settle(tester);
    expect(find.text('Paused'), findsOneWidget);
    await tester.tap(find.text('Restart deal'));
    await settle(tester);
    expect(find.text('Restart this deal?'), findsOneWidget);
    await tester.tap(find.text('Confirm'));
    await settle(tester);
    expect(h.container.read(gameControllerProvider).snapshot!.history, isEmpty);
  });

  testWidgets('new game from home with progress asks for confirmation', (
    tester,
  ) async {
    final h = await pumpApp(tester, route: Routes.home);
    final c = h.container.read(gameControllerProvider.notifier);
    await c.startNewGame();
    await c.tapStock();
    await settle(tester);
    expect(find.text('Play'), findsOneWidget);
    await tester.tap(find.text('New game'));
    await settle(tester);
    expect(find.text('Start a new game?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await settle(tester);
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('shop: insufficient coins dialog, then a purchase', (
    tester,
  ) async {
    final h = await pumpApp(
      tester,
      route: Routes.shop,
      profile: const ProfileData(coins: 100),
    );
    await tester.tap(find.text('Elegant'));
    await settle(tester);
    expect(find.text('Not enough coins'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await settle(tester);
    h.container.read(profileProvider.notifier).state = const ProfileData(
      coins: 600,
    );
    await settle(tester);
    await tester.tap(find.text('Elegant'));
    await settle(tester);
    expect(find.text('Buy Elegant?'), findsOneWidget);
    await tester.tap(find.text('Buy'));
    await settle(tester);
    final p = h.container.read(profileProvider);
    expect(p.owns('cards.elegant'), isTrue);
    expect(p.coins, 100);
  });

  testWidgets('settings: delete data (privacy sheet) requires confirmation', (
    tester,
  ) async {
    final h = await pumpApp(
      tester,
      route: Routes.settings,
      profile: const ProfileData(coins: 999),
    );
    // Settings are minimal: removed options are gone.
    expect(find.text('Left-handed mode'), findsNothing);
    expect(find.text('Cloud backup'), findsNothing);
    await tester.tap(find.text('Privacy'));
    await settle(tester);
    await tester.tap(find.text('Delete local data'));
    await settle(tester);
    await tester.tap(find.text('Cancel'));
    await settle(tester);
    expect(h.container.read(profileProvider).coins, 999);
    await tester.tap(find.text('Delete local data'));
    await settle(tester);
    await tester.tap(find.text('Delete'));
    await settle(tester);
    expect(h.container.read(profileProvider).coins, ProfileData.startingCoins);
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('stats empty state', (tester) async {
    await pumpApp(tester, route: Routes.profile);
    expect(
      find.text('Play your first game to see your statistics here.'),
      findsOneWidget,
    );
  });
}
