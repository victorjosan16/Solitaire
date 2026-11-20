import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../../app/theme/tokens.dart';
import '../../../core/ads/ad_service.dart';
import '../../../core/providers.dart';
import '../../../shared/widgets/card_view.dart';
import '../../../shared/widgets/confetti.dart';
import '../../../shared/widgets/nova_dialogs.dart';
import '../../../shared/widgets/nova_logo.dart';
import '../../../shared/widgets/nova_widgets.dart';
import '../../achievements/domain/achievements.dart';
import '../../settings/application/settings_controller.dart';
import '../../solitaire/application/game_controller.dart';
import '../../solitaire/domain/models/card.dart';
import '../../solitaire/domain/models/game_mode.dart';
import '../../solitaire/presentation/card_art/card_styles.dart';
import '../../statistics/application/profile_controller.dart';

class VictoryScreen extends ConsumerStatefulWidget {
  const VictoryScreen({super.key});
  @override
  ConsumerState<VictoryScreen> createState() => _VictoryScreenState();
}

class _VictoryScreenState extends ConsumerState<VictoryScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _count;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    final reduce = ref.read(settingsProvider).reducedMotion;
    _count = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: reduce ? 1 : 1200),
    )..forward();
  }

  @override
  void dispose() {
    _count.dispose();
    super.dispose();
  }

  Future<void> _leave({required bool playAgain}) async {
    if (_busy) return;
    setState(() => _busy = true);
    final v = ref.read(gameControllerProvider).victory;
    // Natural break: an interstitial may show here (capped by policy).
    await ref
        .read(adServiceProvider)
        .maybeShowInterstitial(InterstitialPlacement.afterGameEnd);
    final ctrl = ref.read(gameControllerProvider.notifier);
    ctrl.clearVictory();
    if (!mounted) return;
    if (playAgain) {
      final mode = v == null || v.mode == GameMode.daily
          ? GameMode.random
          : v.mode;
      await ctrl.startNewGame(mode: mode, drawCount: v?.drawCount);
      if (mounted) context.pushReplacement(Routes.game);
    } else {
      context.go(Routes.home);
    }
  }

  Future<void> _double() async {
    final l = context.l10n;
    setState(() => _busy = true);
    final r = await ref
        .read(gameControllerProvider.notifier)
        .doubleVictoryCoins();
    if (!mounted) return;
    setState(() => _busy = false);
    switch (r) {
      case RewardEarned():
        showNovaSnack(context, l.coinsDoubled, icon: Icons.celebration_rounded);
      case RewardSkipped():
        showNovaSnack(context, l.adNotCompleted);
      case RewardUnavailable(:final reason):
        reason == AdUnavailableReason.offline
            ? await showOfflineDialog(context)
            : await showAdUnavailableDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final v = ref.watch(gameControllerProvider).victory;
    final profile = ref.watch(profileProvider);
    final reduce = ref.watch(settingsProvider.select((s) => s.reducedMotion));
    if (v == null) {
      // Opened without a fresh win (e.g. restored after process death).
      return NovaScaffold(
        title: l.victoryTitle,
        onBack: () => context.go(Routes.home),
        body: Center(
          child: GoldButton(
            label: l.mainMenu,
            expand: false,
            onPressed: () => context.go(Routes.home),
          ),
        ),
      );
    }
    final doubled = profile.hasGrant('double:${v.gameId}');
    final canDouble =
        v.coinsEarned > 0 &&
        !doubled &&
        ref.read(adServiceProvider).rewardedAvailable;
    final style = CardStyle.byId(profile.equipped.cards);
    final w = MediaQuery.sizeOf(context).width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _leave(playAgain: false);
      },
      child: NovaScaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: NovaSpace.xl),
              child: MaxWidth(
                maxWidth: 440,
                child: Column(
                  children: [
                    const SizedBox(height: NovaSpace.lg),
                    _Emblem(width: math.min(w * 0.8, 340), style: style),
                    const SizedBox(height: NovaSpace.lg),
                    NovaPanel(
                      child: Column(
                        children: [
                          AnimatedBuilder(
                            animation: _count,
                            builder: (_, _) => StatRow(
                              label: l.finalScore,
                              value:
                                  '${(v.finalScore * Curves.easeOut.transform(_count.value)).round()}',
                            ),
                          ),
                          StatRow(
                            label: l.timeLabel,
                            value: formatClock(v.elapsedMs),
                          ),
                          StatRow(label: l.movesLabel, value: '${v.moves}'),
                          if (v.timeBonus > 0)
                            StatRow(
                              label: l.timeBonus,
                              value: '+${v.timeBonus}',
                            ),
                          StatRow(label: l.maxCombo, value: '${v.maxCombo}x'),
                          StatRow(label: l.bestScore, value: '${v.bestScore}'),
                          if (v.newRecord)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                l.newRecord,
                                style: const TextStyle(
                                  color: NovaColors.goldLight,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          const SizedBox(height: NovaSpace.sm),
                          Semantics(
                            label: l.coinsBalance(
                              doubled ? v.coinsEarned * 2 : v.coinsEarned,
                            ),
                            excludeSemantics: true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CoinIcon(size: 34),
                                const SizedBox(width: NovaSpace.sm),
                                Text(
                                  l.coinsEarned(
                                    doubled ? v.coinsEarned * 2 : v.coinsEarned,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: NovaColors.goldLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (final id in v.newAchievements)
                      Padding(
                        padding: const EdgeInsets.only(top: NovaSpace.sm),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.emoji_events_rounded,
                              color: NovaColors.goldLight,
                            ),
                            const SizedBox(width: NovaSpace.sm),
                            Expanded(
                              child: Text(
                                l.achievementUnlocked(achievementTitle(l, id)),
                                style: const TextStyle(color: NovaColors.ivory),
                              ),
                            ),
                            Text(
                              l.rewardCoins(achievementById(id)?.reward ?? 0),
                              style: const TextStyle(
                                color: NovaColors.goldLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: NovaSpace.xl),
                    if (canDouble) ...[
                      PanelButton(
                        label: l.doubleCoins,
                        icon: Icons.ondemand_video_rounded,
                        onPressed: _busy ? null : _double,
                      ),
                      const SizedBox(height: NovaSpace.md),
                    ],
                    GoldButton(
                      label: l.playAgain,
                      onPressed: _busy ? null : () => _leave(playAgain: true),
                    ),
                    const SizedBox(height: NovaSpace.md),
                    PanelButton(
                      label: l.mainMenu,
                      onPressed: _busy ? null : () => _leave(playAgain: false),
                    ),
                    const SizedBox(height: NovaSpace.xl),
                  ],
                ),
              ),
            ),
            Positioned.fill(child: Confetti(enabled: !reduce)),
          ],
        ),
      ),
    );
  }
}

class _Emblem extends StatelessWidget {
  const _Emblem({required this.width, required this.style});
  final double width;
  final CardStyle style;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final cardW = width * 0.2;
    return SizedBox(
      width: width,
      height: width * 0.78,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: CustomPaint(painter: LaurelPainter())),
          Positioned(
            top: 0,
            child: CustomPaint(
              size: Size(width * 0.22, width * 0.15),
              painter: CrownPainter(),
            ),
          ),
          Positioned(
            top: width * 0.16,
            child: SizedBox(
              width: width * 0.6,
              height: cardW * 1.5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  for (final (i, c) in [
                    PlayingCard(Suit.clubs, 1),
                    PlayingCard(Suit.hearts, 1),
                    PlayingCard(Suit.spades, 1),
                    PlayingCard(Suit.diamonds, 1),
                  ].indexed)
                    Transform.translate(
                      offset: Offset((i - 1.5) * cardW * 0.55, 0),
                      child: Transform.rotate(
                        angle: (i - 1.5) * 0.14,
                        child: CardView(card: c, style: style, width: cardW),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: width * 0.02,
            child: SizedBox(
              width: width * 0.86,
              height: width * 0.2,
              child: CustomPaint(
                painter: _RibbonPainter(),
                child: Center(
                  child: Semantics(
                    header: true,
                    child: Text(
                      l.victoryTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: NovaFonts.display,
                        fontSize: width * 0.1,
                        fontWeight: FontWeight.w700,
                        color: NovaColors.goldLight,
                        shadows: const [
                          Shadow(
                            color: Color(0xAA000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RibbonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    final tail = Paint()..color = const Color(0xFF7E1414);
    for (final side in [-1, 1]) {
      final x0 = side < 0 ? 0.0 : w;
      final dx = side * w * 0.12;
      canvas.drawPath(
        Path()
          ..moveTo(x0 - dx * 0.2, h * 0.3)
          ..lineTo(x0 + dx * 0.6, h * 0.3)
          ..lineTo(x0 + dx * 0.6, h)
          ..lineTo(x0 - dx * 0.2, h)
          ..lineTo(x0 + dx * 0.25, h * 0.65)
          ..close(),
        tail,
      );
    }
    final body = Path()
      ..moveTo(w * 0.08, h * 0.12)
      ..quadraticBezierTo(w * 0.5, -h * 0.12, w * 0.92, h * 0.12)
      ..lineTo(w * 0.92, h * 0.82)
      ..quadraticBezierTo(w * 0.5, h * 0.58, w * 0.08, h * 0.82)
      ..close();
    canvas.drawPath(
      body,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD23A2E), Color(0xFF8E1A15)],
        ).createShader(Offset.zero & s),
    );
    canvas.drawPath(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = NovaColors.gold,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
