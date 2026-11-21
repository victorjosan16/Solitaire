import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../app/theme/tokens.dart';

/// Brand wordmark: crown + "SOLITAIRE" + "NOVA". The brand name is the same
/// in every locale, so it uses the Latin-only Cinzel face.
class NovaLogo extends StatelessWidget {
  const NovaLogo({super.key, this.width = 300});
  final double width;

  /// Illustrated brand crest (aspect ratio of the cropped artwork).
  static const asset = 'assets/images/logo.png';
  static const aspect = 443 / 408;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Solitaire Nova',
    header: true,
    excludeSemantics: true,
    child: SizedBox(
      width: width,
      height: width / aspect,
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.medium,
        errorBuilder: (_, _, _) => NovaWordmark(width: width),
      ),
    ),
  );
}

/// Vector wordmark: crown + "SOLITAIRE" + "NOVA". Fallback for the crest.
/// The brand name is the same in every locale, so it uses Latin-only Cinzel.
class NovaWordmark extends StatelessWidget {
  const NovaWordmark({super.key, this.width = 300});
  final double width;

  @override
  Widget build(BuildContext context) {
    final big = width * 0.15;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              size: Size(width * 0.22, width * 0.15),
              painter: CrownPainter(),
            ),
            SizedBox(height: width * 0.01),
            _GoldText('SOLITAIRE', size: big),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Flourish(width: width * 0.16, flip: false),
                SizedBox(width: width * 0.03),
                _GoldText('NOVA', size: big * 0.78, spacing: big * 0.12),
                SizedBox(width: width * 0.03),
                _Flourish(width: width * 0.16, flip: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GoldText extends StatelessWidget {
  const _GoldText(this.text, {required this.size, this.spacing = 0});
  final String text;
  final double size;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: NovaFonts.brand,
      fontWeight: FontWeight.w700,
      fontSize: size,
      letterSpacing: spacing,
      height: 1.1,
    );
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = size * 0.06
              ..color = const Color(0xFF3A2A10),
          ),
        ),
        ShaderMask(
          shaderCallback: (r) => NovaColors.goldGradient.createShader(r),
          child: Text(text, style: style.copyWith(color: Colors.white)),
        ),
      ],
    );
  }
}

class _Flourish extends StatelessWidget {
  const _Flourish({required this.width, required this.flip});
  final double width;
  final bool flip;
  @override
  Widget build(BuildContext context) => Transform.scale(
    scaleX: flip ? -1 : 1,
    child: CustomPaint(
      size: Size(width, width * 0.3),
      painter: _FlourishPainter(),
    ),
  );
}

class _FlourishPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()
      ..color = NovaColors.gold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;
    final y = s.height / 2;
    canvas.drawLine(Offset(0, y), Offset(s.width * 0.7, y), p);
    canvas.drawPath(
      Path()
        ..moveTo(s.width * 0.7, y)
        ..cubicTo(
          s.width * 0.85,
          y - s.height * 0.6,
          s.width,
          y,
          s.width * 0.85,
          y + s.height * 0.3,
        ),
      p,
    );
    canvas.drawCircle(
      Offset(s.width * 0.12, y),
      2,
      p..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Original crown emblem.
class CrownPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    final path = Path()
      ..moveTo(w * 0.08, h * 0.9)
      ..lineTo(0, h * 0.28)
      ..lineTo(w * 0.28, h * 0.55)
      ..lineTo(w * 0.5, h * 0.05)
      ..lineTo(w * 0.72, h * 0.55)
      ..lineTo(w, h * 0.28)
      ..lineTo(w * 0.92, h * 0.9)
      ..close();
    canvas.drawPath(
      path,
      Paint()..shader = NovaColors.goldGradient.createShader(Offset.zero & s),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = const Color(0xFF6E5122),
    );
    final jewel = Paint()..color = const Color(0xFFFFF3C8);
    for (final x in [0.0, 0.5, 1.0]) {
      final y = x == 0.5 ? h * 0.05 : h * 0.28;
      canvas.drawCircle(Offset(w * x, y), w * 0.05, jewel);
    }
    canvas.drawRect(
      Rect.fromLTWH(w * 0.08, h * 0.82, w * 0.84, h * 0.14),
      Paint()..color = const Color(0xFFB48C45),
    );
    for (var i = 0; i < 3; i++) {
      canvas.drawCircle(
        Offset(w * (0.3 + i * 0.2), h * 0.89),
        w * 0.025,
        Paint()
          ..color = i == 1 ? const Color(0xFF2FA37F) : const Color(0xFFB3262B),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Decorative laurel used on the victory screen.
class LaurelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()..color = NovaColors.gold;
    for (final side in [-1.0, 1.0]) {
      for (var i = 0; i < 8; i++) {
        final t = i / 8;
        final a = math.pi * (0.55 + t * 0.75);
        final cx = s.width / 2 + side * math.cos(a) * s.width * 0.45;
        final cy = s.height * 0.55 - math.sin(a) * s.height * 0.45;
        canvas.save();
        canvas.translate(cx, cy);
        canvas.rotate(side * (a - math.pi / 2));
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset.zero,
            width: s.width * 0.05,
            height: s.width * 0.12,
          ),
          p,
        );
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
