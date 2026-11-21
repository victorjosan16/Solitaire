import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../../app/theme/tokens.dart';
import '../../../core/providers.dart';
import '../../../shared/widgets/nova_dialogs.dart';
import '../../../shared/widgets/nova_logo.dart';
import '../../../shared/widgets/nova_widgets.dart';
import '../../../shared/widgets/scene_painter.dart';
import '../../daily_challenge/domain/daily_challenge.dart';
import '../../settings/application/settings_controller.dart';
import '../../solitaire/application/game_controller.dart';
import '../../solitaire/domain/models/game_mode.dart';
import '../../statistics/application/profile_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeAskConsent());
  }

  /// App-owned privacy prompt on first launch (never blocks play). If ads
  /// are accepted the platform UMP flow runs where legally required.
  Future<void> _maybeAskConsent() async {
    if (!mounted) return;
    if (ref.read(settingsProvider).consentAnswered) {
      // Every later launch: refresh platform consent, then start the ad SDK.
      _startAds();
      return;
    }
    final l = context.l10n;
    final accepted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (c) => AlertDialog(
        icon: const Icon(
          Icons.privacy_tip_outlined,
          color: NovaColors.goldLight,
          size: 36,
        ),
        title: Text(l.consentTitle),
        content: Text(l.consentBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: Text(l.consentEssential),
          ),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            child: Text(l.consentAccept),
          ),
        ],
      ),
    );
    final yes = accepted ?? false;
    await ref
        .read(settingsProvider.notifier)
        .update(
          (s) => s.copyWith(
            consentAnswered: true,
            analyticsEnabled: yes,
            personalizedAds: yes,
          ),
        );
    _startAds();
  }

  /// Platform consent (GDPR/UMP) + ad SDK init, in the background.
  void _startAds() {
    final consent = ref.read(consentServiceProvider);
    final ads = ref.read(adServiceProvider);
    consent.gather().then((_) => ads.initialize());
  }

  Future<void> _play(GameMode mode) async {
    final game = ref.read(gameControllerProvider);
    final snap = game.snapshot;
    if (snap != null && !snap.finished && snap.hasProgress) {
      final l = context.l10n;
      final ok = await showConfirmDialog(
        context,
        title: l.newGameTitle,
        body: l.newGameBody,
      );
      if (!ok) return;
    }
    await ref.read(gameControllerProvider.notifier).startNewGame(mode: mode);
    if (mounted) context.push(Routes.game);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final profile = ref.watch(profileProvider);
    final game = ref.watch(gameControllerProvider);
    final snap = game.snapshot;
    final canContinue = snap != null && !snap.finished;
    final todayKey = DailyChallenge.keyFor(ref.read(clockProvider)());
    final dailyPending = !profile.daily.containsKey(todayKey);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: NovaColors.emeraldDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          MenuBackground(sceneId: profile.equipped.background, dim: 0.5),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    NovaSpace.lg,
                    NovaSpace.sm,
                    NovaSpace.lg,
                    0,
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: _LevelBadge(
                          level: profile.level,
                          progress: profile.levelProgress,
                        ),
                      ),
                      const SizedBox(width: NovaSpace.sm),
                      CoinBadge(
                        coins: profile.coins,
                        label: l.coinsBalance(profile.coins),
                        onAdd: () => context.push(Routes.shop),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, box) => SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: NovaSpace.xl,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: box.maxHeight),
                        child: Center(
                          child: MaxWidth(
                            maxWidth: 460,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: NovaSpace.sm),
                                NovaLogo(
                                  width: [
                                    size.width * 0.74,
                                    box.maxHeight * 0.36 * NovaLogo.aspect,
                                    340.0,
                                  ].reduce(math.min),
                                ),
                                const SizedBox(height: NovaSpace.xl),
                                // One primary action: continue the game in
                                // progress, or deal a new (always winnable) game.
                                GoldButton(
                                  label: l.play,
                                  icon: Icons.play_arrow_rounded,
                                  height: 64,
                                  onPressed: canContinue
                                      ? () => context.push(Routes.game)
                                      : () => _play(GameMode.winning),
                                ),
                                if (canContinue)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '${snap.state.moves} · ${formatClock(snap.elapsedMs)}',
                                            style: const TextStyle(
                                              color: NovaColors.textSecondary,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              _play(GameMode.winning),
                                          child: Text(l.newGame),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  const SizedBox(height: NovaSpace.lg),
                                PanelButton(
                                  label: l.dailyChallenge,
                                  icon: Icons.calendar_month_rounded,
                                  height: 56,
                                  badge: dailyPending ? const RedDot() : null,
                                  onPressed: () => context.push(Routes.daily),
                                ),
                                const SizedBox(height: NovaSpace.lg),
                                const SuitDivider(),
                                const SizedBox(height: NovaSpace.lg),
                                IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: NovaTile(
                                          icon: Icons.emoji_events_rounded,
                                          label: l.achievements,
                                          onTap: () =>
                                              context.push(Routes.achievements),
                                        ),
                                      ),
                                      const SizedBox(width: NovaSpace.md),
                                      Expanded(
                                        child: NovaTile(
                                          icon: Icons.bar_chart_rounded,
                                          label: l.statistics,
                                          onTap: () =>
                                              context.push(Routes.stats),
                                        ),
                                      ),
                                      const SizedBox(width: NovaSpace.md),
                                      Expanded(
                                        child: NovaTile(
                                          icon: Icons.style_rounded,
                                          label: l.howToPlay,
                                          onTap: () => showHowToPlay(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: NovaSpace.lg),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _BottomNav(
                  items: [
                    (Icons.home_rounded, l.navHome, null),
                    (Icons.person_rounded, l.navProfile, Routes.profile),
                    (Icons.shopping_cart_rounded, l.navShop, Routes.shop),
                    (Icons.settings_rounded, l.navSettings, Routes.settings),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.level, required this.progress});
  final int level;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return MergeSemantics(
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [Color(0xFF1A5A4D), Color(0xFF0A2C27)],
              ),
              border: Border.all(color: NovaColors.gold, width: 1.5),
              boxShadow: NovaShadows.soft,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: NovaColors.ivory,
              size: 30,
            ),
          ),
          const SizedBox(width: NovaSpace.sm),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.levelLabel(level),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: NovaColors.ivory,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 100,
                  child: NovaProgressBar(value: progress, height: 7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.items});
  final List<(IconData, String, String?)> items;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      NovaSpace.md,
      0,
      NovaSpace.md,
      NovaSpace.sm,
    ),
    child: GoldRim(
      radius: NovaRadius.lg + 4,
      width: 2.4,
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          for (final (icon, label, route) in items)
            Expanded(
              child: Semantics(
                button: true,
                selected: route == null,
                child: InkWell(
                  borderRadius: BorderRadius.circular(NovaRadius.md),
                  onTap: route == null ? null : () => context.push(route),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: route == null
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(NovaRadius.md),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                NovaColors.gold.withValues(alpha: 0.38),
                                NovaColors.gold.withValues(alpha: 0.1),
                              ],
                            ),
                            border: Border.all(
                              color: NovaColors.gold,
                              width: 1.4,
                            ),
                          )
                        : null,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          color: route == null
                              ? NovaColors.gold
                              : NovaColors.goldLight.withValues(alpha: 0.85),
                          size: 26,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: route == null
                                ? NovaColors.gold
                                : NovaColors.textSecondary,
                            fontWeight: route == null
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
