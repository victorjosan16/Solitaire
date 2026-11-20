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
  bool _winningDeal = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeAskConsent());
  }

  /// App-owned privacy prompt on first launch (never blocks play). If ads
  /// are accepted the platform UMP flow runs where legally required.
  Future<void> _maybeAskConsent() async {
    if (!mounted || ref.read(settingsProvider).consentAnswered) return;
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
    // Platform consent (GDPR/UMP) + ad SDK init happen in the background.
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
    final settings = ref.watch(settingsProvider);
    final game = ref.watch(gameControllerProvider);
    final snap = game.snapshot;
    final canContinue = snap != null && !snap.finished;
    final todayKey = DailyChallenge.keyFor(ref.read(clockProvider)());
    final dailyPending = !profile.daily.containsKey(todayKey);
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: NovaColors.navy,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SceneBackground(sceneId: profile.equipped.background, dim: 0.5),
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
                      _LevelBadge(
                        level: profile.level,
                        progress: profile.levelProgress,
                      ),
                      const Spacer(),
                      CoinBadge(
                        coins: profile.coins,
                        label: l.coinsBalance(profile.coins),
                        onAdd: () => context.push(Routes.shop),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: NovaSpace.xl,
                    ),
                    child: MaxWidth(
                      maxWidth: 460,
                      child: Column(
                        children: [
                          const SizedBox(height: NovaSpace.lg),
                          NovaLogo(width: math.min(width * 0.72, 340)),
                          const SizedBox(height: NovaSpace.xl),
                          if (canContinue) ...[
                            GoldButton(
                              label: l.continueGame,
                              icon: Icons.play_arrow_rounded,
                              onPressed: () => context.push(Routes.game),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 6,
                                bottom: NovaSpace.md,
                              ),
                              child: Text(
                                l.continueSubtitle(
                                  '${modeLabel(l, snap.mode)} · ${snap.config.drawCount == 3 ? l.drawThree : l.drawOne}',
                                  snap.state.moves,
                                  formatClock(snap.elapsedMs),
                                ),
                                style: const TextStyle(
                                  color: NovaColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                          (canContinue
                              ? PanelButton(
                                  label: l.playClassic,
                                  icon: Icons.style_rounded,
                                  onPressed: () => _play(
                                    _winningDeal
                                        ? GameMode.winning
                                        : GameMode.random,
                                  ),
                                )
                              : GoldButton(
                                  label: l.playClassic,
                                  icon: Icons.play_arrow_rounded,
                                  onPressed: () => _play(
                                    _winningDeal
                                        ? GameMode.winning
                                        : GameMode.random,
                                  ),
                                )),
                          const SizedBox(height: NovaSpace.md),
                          NovaTabs(
                            labels: [l.drawOne, l.drawThree],
                            selected: settings.defaultDrawCount == 3 ? 1 : 0,
                            onChanged: (i) => ref
                                .read(settingsProvider.notifier)
                                .update(
                                  (s) => s.copyWith(
                                    defaultDrawCount: i == 1 ? 3 : 1,
                                  ),
                                ),
                          ),
                          const SizedBox(height: NovaSpace.sm),
                          Row(
                            children: [
                              Expanded(
                                child: NovaTabs(
                                  labels: [l.dealRandom, l.dealWinning],
                                  selected: _winningDeal ? 1 : 0,
                                  onChanged: (i) =>
                                      setState(() => _winningDeal = i == 1),
                                ),
                              ),
                              IconButton(
                                tooltip: l.dealWinning,
                                onPressed: () => showInfoDialog(
                                  context,
                                  title: l.dealWinning,
                                  body: l.dealWinningInfo,
                                  icon: Icons.verified_outlined,
                                ),
                                icon: const Icon(Icons.info_outline_rounded),
                              ),
                            ],
                          ),
                          const SizedBox(height: NovaSpace.lg),
                          PanelButton(
                            label: l.dailyChallenge,
                            icon: Icons.calendar_month_rounded,
                            badge: dailyPending ? const RedDot() : null,
                            onPressed: () => context.push(Routes.daily),
                          ),
                          const SizedBox(height: NovaSpace.md),
                          PanelButton(
                            label: l.achievements,
                            icon: Icons.emoji_events_rounded,
                            onPressed: () => context.push(Routes.achievements),
                          ),
                          const SizedBox(height: NovaSpace.md),
                          PanelButton(
                            label: l.themes,
                            icon: Icons.palette_rounded,
                            onPressed: () => context.push(Routes.themes),
                          ),
                          const SizedBox(height: NovaSpace.xl),
                        ],
                      ),
                    ),
                  ),
                ),
                _BottomNav(
                  items: [
                    (Icons.home_rounded, l.navHome, null),
                    (Icons.bar_chart_rounded, l.navStats, Routes.stats),
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
              color: const Color(0xFF0E2C28),
              border: Border.all(color: NovaColors.gold, width: 1.5),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: NovaColors.ivory,
              size: 30,
            ),
          ),
          const SizedBox(width: NovaSpace.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.levelLabel(level),
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
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.items});
  final List<(IconData, String, String?)> items;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(
      NovaSpace.md,
      0,
      NovaSpace.md,
      NovaSpace.sm,
    ),
    padding: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      gradient: NovaColors.panelGradient,
      borderRadius: BorderRadius.circular(NovaRadius.lg),
      border: Border.all(color: NovaColors.gold.withValues(alpha: 0.5)),
      boxShadow: NovaShadows.raised,
    ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
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
  );
}
