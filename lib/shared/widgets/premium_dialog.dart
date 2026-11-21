import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../app/theme/tokens.dart';
import '../../features/solitaire/domain/models/card.dart';
import '../../features/solitaire/presentation/card_art/suit_paths.dart';
import 'nova_widgets.dart';

/// Ornate modal frame from the brand reference: gold-rimmed emerald card,
/// spade medallion on top, red ribbon title, diamond finial below.
/// Content (texts, buttons) stays fully localized Flutter widgets.
class PremiumDialog extends StatelessWidget {
  const PremiumDialog({
    super.key,
    required this.title,
    required this.actions,
    this.hero,
    this.body,
    this.info,
  });

  final String title;
  final Widget? hero;
  final String? body;
  final Widget? info;

  /// Laid out vertically (each full width) unless a single [Row] is passed.
  final List<Widget> actions;

  static const _medal = 58.0;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final compact = media.size.height < 720;
    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 440,
          maxHeight: media.size.height - media.padding.vertical - 48,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: _medal / 2, bottom: 10),
              child: _Frame(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    NovaSpace.lg,
                    _medal / 2 + (compact ? 0 : NovaSpace.sm),
                    NovaSpace.lg,
                    compact ? NovaSpace.lg : NovaSpace.xl,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (hero != null) ...[
                        compact
                            ? SizedBox(
                                height: 66,
                                child: FittedBox(child: hero),
                              )
                            : hero!,
                        SizedBox(height: compact ? 0 : NovaSpace.xs),
                      ],
                      Ribbon(text: title),
                      if (body != null) ...[
                        const SizedBox(height: NovaSpace.md),
                        Text(
                          body!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: compact ? 15 : 16.5,
                            height: 1.3,
                            color: NovaColors.ivory,
                          ),
                        ),
                      ],
                      if (info != null) ...[
                        SizedBox(height: compact ? NovaSpace.md : NovaSpace.lg),
                        info!,
                      ],
                      SizedBox(height: compact ? NovaSpace.md : NovaSpace.lg),
                      for (var i = 0; i < actions.length; i++) ...[
                        if (i > 0) const SizedBox(height: NovaSpace.md),
                        actions[i],
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(top: 0, child: _Medallion(size: _medal)),
            Positioned(
              bottom: 0,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: NovaColors.goldGradient,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: NovaShadows.soft,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Frame extends StatelessWidget {
  const _Frame({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      boxShadow: [
        const BoxShadow(
          color: Color(0x99000000),
          blurRadius: 30,
          offset: Offset(0, 12),
        ),
        ...NovaShadows.goldGlow(0.28),
      ],
    ),
    child: GoldRim(
      radius: 28,
      width: 3,
      shadow: false,
      fill: const RadialGradient(
        center: Alignment(0, -0.35),
        radius: 1.1,
        colors: [Color(0xFF1A6B4C), Color(0xFF0D3F2C), Color(0xFF082A1E)],
        stops: [0, 0.6, 1],
      ),
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: NovaColors.gold.withValues(alpha: 0.45)),
        ),
        child: child,
      ),
    ),
  );
}

class _Medallion extends StatelessWidget {
  const _Medallion({required this.size});
  final double size;
  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: GoldRim(
      radius: size / 2,
      width: 3,
      fill: const RadialGradient(
        colors: [Color(0xFF1C7050), Color(0xFF0A3324)],
      ),
      child: Center(
        child: CustomPaint(
          size: Size.square(size * 0.48),
          painter: const _SuitPainter(Suit.spades),
        ),
      ),
    ),
  );
}

class _SuitPainter extends CustomPainter {
  const _SuitPainter(this.suit);
  final Suit suit;
  @override
  void paint(Canvas canvas, Size size) {
    final r = Offset.zero & size;
    canvas.drawPath(
      SuitPaths.path(suit, r),
      Paint()..shader = NovaColors.goldGradient.createShader(r),
    );
  }

  @override
  bool shouldRepaint(covariant _SuitPainter old) => old.suit != suit;
}

/// Red satin ribbon with a gold edge carrying a localized title.
class Ribbon extends StatelessWidget {
  const Ribbon({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: CustomPaint(
      painter: const _RibbonPainter(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(44, 10, 44, 16),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: NovaFonts.display,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFF4D6),
              shadows: [Shadow(color: Color(0x99000000), offset: Offset(0, 2))],
            ),
          ),
        ),
      ),
    ),
  );
}

class _RibbonPainter extends CustomPainter {
  const _RibbonPainter();
  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    final tail = Paint()..color = const Color(0xFF7A1010);
    final fold = Paint()..color = const Color(0xFF4E0A0A);
    for (final side in [-1.0, 1.0]) {
      final x0 = side < 0 ? 0.0 : w;
      final inX = x0 - side * 34;
      // Swallow-tail end.
      canvas.drawPath(
        Path()
          ..moveTo(inX, h * 0.28)
          ..lineTo(x0 + side * 4, h * 0.28)
          ..lineTo(x0 - side * 10, h * 0.62)
          ..lineTo(x0 + side * 4, h * 0.98)
          ..lineTo(inX, h * 0.98)
          ..close(),
        tail,
      );
      canvas.drawPath(
        Path()
          ..moveTo(inX, h * 0.82)
          ..lineTo(inX + side * 12, h * 0.98)
          ..lineTo(inX, h * 0.98)
          ..close(),
        fold,
      );
    }
    final body = Path()
      ..moveTo(18, h * 0.14)
      ..quadraticBezierTo(w / 2, -h * 0.12, w - 18, h * 0.14)
      ..lineTo(w - 18, h * 0.84)
      ..quadraticBezierTo(w / 2, h * 0.58, 18, h * 0.84)
      ..close();
    canvas.drawPath(
      body,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE04436), Color(0xFFB0221B), Color(0xFF7E1410)],
          stops: [0, 0.55, 1],
        ).createShader(Offset.zero & s),
    );
    canvas.drawPath(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..shader = NovaColors.rimGradient.createShader(Offset.zero & s),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Gold-rimmed info strip: icon, localized label, highlighted value.
class InfoPill extends StatelessWidget {
  const InfoPill({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => MergeSemantics(
    child: GoldRim(
      radius: NovaRadius.pill,
      width: 1.6,
      shadow: false,
      fill: const LinearGradient(
        colors: [Color(0xFF0A3526), Color(0xFF0C3F2D)],
      ),
      padding: const EdgeInsets.fromLTRB(14, 4, 4, 4),
      child: Row(
        children: [
          Icon(icon, color: NovaColors.gold, size: 26),
          const SizedBox(width: NovaSpace.sm),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.2,
                color: NovaColors.ivory,
              ),
            ),
          ),
          const SizedBox(width: NovaSpace.sm),
          Container(
            constraints: const BoxConstraints(minWidth: 40),
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF06231A),
              borderRadius: BorderRadius.circular(NovaRadius.pill),
              border: Border.all(color: NovaColors.gold, width: 1.4),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: NovaColors.goldLight,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Shuffle hero: gold-framed shuffle glyph between two tilted aces.
class ShuffleHero extends StatelessWidget {
  const ShuffleHero({super.key});
  @override
  Widget build(BuildContext context) {
    Widget card(Suit suit, double angle) => Transform.rotate(
      angle: angle,
      child: _MiniCard(suit: suit),
    );
    return ExcludeSemantics(
      child: SizedBox(
        height: 92,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            card(Suit.spades, -0.28),
            const SizedBox(width: 6),
            SizedBox.square(
              dimension: 76,
              child: GoldRim(
                radius: 16,
                width: 2.6,
                fill: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF3B2A12), Color(0xFF1A1208)],
                ),
                child: ShaderMask(
                  shaderCallback: (r) =>
                      NovaColors.goldGradient.createShader(r),
                  child: const Icon(
                    Icons.shuffle_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            card(Suit.hearts, 0.28),
          ],
        ),
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({required this.suit});
  final Suit suit;
  @override
  Widget build(BuildContext context) {
    final red = suit == Suit.hearts || suit == Suit.diamonds;
    final color = red ? const Color(0xFFC0282D) : const Color(0xFF17191C);
    return Container(
      width: 50,
      height: 70,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFDF7), Color(0xFFEDE6D4)],
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: NovaShadows.soft,
      ),
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          Text(
            'A',
            style: TextStyle(
              fontSize: 16,
              height: 1,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CustomPaint(
                size: const Size.square(26),
                painter: _PlainSuitPainter(suit, color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlainSuitPainter extends CustomPainter {
  const _PlainSuitPainter(this.suit, this.color);
  final Suit suit;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) => canvas.drawPath(
    SuitPaths.path(suit, Offset.zero & size),
    Paint()..color = color,
  );
  @override
  bool shouldRepaint(covariant _PlainSuitPainter old) =>
      old.suit != suit || old.color != color;
}

/// Gold glyph in a gold-rimmed tile, used as the hero of simple dialogs.
class IconHero extends StatelessWidget {
  const IconHero({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Padding(
      padding: const EdgeInsets.only(bottom: NovaSpace.xs),
      child: SizedBox.square(
        dimension: 68,
        child: GoldRim(
          radius: 16,
          width: 2.4,
          fill: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3B2A12), Color(0xFF1A1208)],
          ),
          child: ShaderMask(
            shaderCallback: (r) => NovaColors.goldGradient.createShader(r),
            child: Icon(icon, size: 40, color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

/// Two dialog buttons side by side; stacked full-width when space is tight
/// (long translations, small phones, large text).
class DialogButtonPair extends StatelessWidget {
  const DialogButtonPair({
    super.key,
    required this.secondary,
    required this.primary,
  });
  final Widget secondary;
  final Widget primary;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final scale = MediaQuery.textScalerOf(context).scale(1);
      if (box.maxWidth < 290 || scale > 1.15) {
        return Column(
          children: [
            primary,
            const SizedBox(height: NovaSpace.md),
            secondary,
          ],
        );
      }
      return Row(
        children: [
          Expanded(flex: 4, child: secondary),
          const SizedBox(width: NovaSpace.md),
          Expanded(flex: 5, child: primary),
        ],
      );
    },
  );
}
