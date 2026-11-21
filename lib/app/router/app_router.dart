import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/achievements/presentation/achievements_screen.dart';
import '../../features/customization/presentation/themes_screen.dart';
import '../../features/daily_challenge/presentation/daily_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/settings/application/settings_controller.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/shop/presentation/shop_screen.dart';
import '../../features/solitaire/presentation/game_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/statistics/presentation/stats_screen.dart';
import '../../features/victory/presentation/victory_screen.dart';

abstract final class Routes {
  static const splash = '/';
  static const home = '/home';
  static const game = '/game';
  static const victory = '/victory';
  static const daily = '/daily';
  static const themes = '/themes';
  static const stats = '/stats';
  static const achievements = '/achievements';
  static const shop = '/shop';
  static const settings = '/settings';
  static const profile = '/profile';
}

final routerProvider = Provider<GoRouter>((ref) {
  Page<void> page(GoRouterState s, Widget child) {
    final reduce = ref.read(settingsProvider).reducedMotion;
    return CustomTransitionPage<void>(
      key: s.pageKey,
      child: child,
      transitionDuration: Duration(milliseconds: reduce ? 0 : 260),
      reverseTransitionDuration: Duration(milliseconds: reduce ? 0 : 200),
      transitionsBuilder: (context, animation, _, child) => FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child,
      ),
    );
  }

  return GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        pageBuilder: (c, s) => page(s, const SplashScreen()),
      ),
      GoRoute(
        path: Routes.home,
        pageBuilder: (c, s) => page(s, const HomeScreen()),
      ),
      GoRoute(
        path: Routes.game,
        pageBuilder: (c, s) => page(s, const GameScreen()),
      ),
      GoRoute(
        path: Routes.victory,
        pageBuilder: (c, s) => page(s, const VictoryScreen()),
      ),
      GoRoute(
        path: Routes.daily,
        pageBuilder: (c, s) => page(s, const DailyScreen()),
      ),
      GoRoute(
        path: Routes.themes,
        pageBuilder: (c, s) => page(s, const ThemesScreen()),
      ),
      GoRoute(
        path: Routes.stats,
        pageBuilder: (c, s) => page(s, const StatsScreen()),
      ),
      GoRoute(
        path: Routes.achievements,
        pageBuilder: (c, s) => page(s, const AchievementsScreen()),
      ),
      GoRoute(
        path: Routes.shop,
        pageBuilder: (c, s) => page(
          s,
          ShopScreen(
            initialTab: int.tryParse(s.uri.queryParameters['tab'] ?? '') ?? 0,
          ),
        ),
      ),
      GoRoute(
        path: Routes.profile,
        pageBuilder: (c, s) => page(
          s,
          ProfileScreen(
            initialTab: int.tryParse(s.uri.queryParameters['tab'] ?? '') ?? 0,
          ),
        ),
      ),
      GoRoute(
        path: Routes.settings,
        pageBuilder: (c, s) => page(s, const SettingsScreen()),
      ),
    ],
  );
});
