import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/widgets/card_view.dart';
import '../../../shared/widgets/nova_logo.dart';
import '../../../shared/widgets/nova_widgets.dart';
import '../../../shared/widgets/scene_painter.dart';
import '../../settings/application/settings_controller.dart';
import '../../solitaire/domain/models/card.dart';
import '../../solitaire/presentation/card_art/card_styles.dart';
import '../../statistics/application/profile_controller.dart';

/// Brand splash. Everything it waits for is local (settings + saved data
/// are loaded before the first frame); it never waits for the network.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    final reduce = ref.read(settingsProvider).reducedMotion;
    _c =
        AnimationController(
            vsync: this,
            duration: Duration(milliseconds: reduce ? 350 : 1500),
          )
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed && mounted)
              context.go(Routes.home);
          })
          ..forward();
    ref.read(settingsProvider.notifier).applyAll();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final profile = ref.watch(profileProvider);
    final style = CardStyle.byId(profile.equipped.cards);
    final w = MediaQuery.sizeOf(context).width;
    final cardW = math.min(w * 0.2, 110.0);
    return Scaffold(
      backgroundColor: NovaColors.navy,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SceneBackground(sceneId: profile.equipped.background, dim: 0.45),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                NovaLogo(width: math.min(w * 0.8, 420)),
                const Spacer(),
                SizedBox(
                  height: cardW * 1.9,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      for (final (i, c) in [
                        PlayingCard(Suit.clubs, 1),
                        PlayingCard(Suit.hearts, 13),
                        PlayingCard(Suit.spades, 12),
                        PlayingCard(Suit.hearts, 11),
                      ].indexed)
                        Transform.translate(
                          offset: Offset(
                            (i - 1.5) * cardW * 0.62,
                            (i - 1.5).abs() * cardW * 0.12,
                          ),
                          child: Transform.rotate(
                            angle: (i - 1.5) * 0.16,
                            child: CardView(
                              card: c,
                              style: style,
                              width: cardW,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
                AnimatedBuilder(
                  animation: _c,
                  builder: (context, _) {
                    final pct = (Curves.easeInOut.transform(_c.value) * 100)
                        .round();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Semantics(
                        liveRegion: true,
                        label: l.splashLoading(pct),
                        child: Column(
                          children: [
                            ExcludeSemantics(
                              child: Text(
                                l.splashLoading(pct),
                                style: const TextStyle(
                                  color: NovaColors.ivory,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: NovaSpace.sm),
                            SizedBox(
                              width: 260,
                              child: NovaProgressBar(
                                value: pct / 100,
                                height: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: NovaSpace.xxl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
