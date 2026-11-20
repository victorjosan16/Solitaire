import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:material_ui/material_ui.dart';

import '../../features/solitaire/domain/engine/deck.dart';

/// Original procedurally painted landscapes used as menu backgrounds
/// (no photographs or third-party artwork).
class SceneBackground extends StatelessWidget {
  const SceneBackground({super.key, required this.sceneId, this.dim = 0.35});

  /// Cosmetic id, e.g. `bg.lake`.
  final String sceneId;

  /// 0..1 darkening overlay at the bottom for text legibility.
  final double dim;

  @override
  Widget build(BuildContext context) => RepaintBoundary(
    child: CustomPaint(
      painter: ScenePainter(sceneId, dim: dim),
      child: const SizedBox.expand(),
    ),
  );
}

class _Palette {
  const _Palette({
    required this.sky,
    required this.glow,
    required this.far,
    required this.near,
    required this.ground,
    this.water,
    this.stars = false,
    this.aurora = false,
    this.snow = false,
    this.palms = false,
    this.lavender = false,
    this.autumn = false,
  });
  final List<Color> sky;
  final Color glow;
  final Color far;
  final Color near;
  final Color ground;
  final Color? water;
  final bool stars, aurora, snow, palms, lavender, autumn;
}

const _palettes = {
  'bg.lake': _Palette(
    sky: [Color(0xFF0E1B33), Color(0xFF2B4A6B), Color(0xFFE9A35A)],
    glow: Color(0xFFFFD08A),
    far: Color(0xFF2E3F5C),
    near: Color(0xFF15253A),
    ground: Color(0xFF0A1522),
    water: Color(0xFF1B3550),
  ),
  'bg.autumn': _Palette(
    sky: [Color(0xFF3B2A3F), Color(0xFFB0603A), Color(0xFFF2B266)],
    glow: Color(0xFFFFD99A),
    far: Color(0xFF6B3B2A),
    near: Color(0xFF3A1F16),
    ground: Color(0xFF24140E),
    autumn: true,
  ),
  'bg.tropic': _Palette(
    sky: [Color(0xFF1C5D8C), Color(0xFF55B6C9), Color(0xFFF7C98B)],
    glow: Color(0xFFFFF0B0),
    far: Color(0xFF2C7A84),
    near: Color(0xFF1C3B3A),
    ground: Color(0xFFD9C08E),
    water: Color(0xFF1E8EA6),
    palms: true,
  ),
  'bg.alpine': _Palette(
    sky: [Color(0xFF0F2342), Color(0xFF3E6E9C), Color(0xFFBFD8EA)],
    glow: Color(0xFFE8F4FF),
    far: Color(0xFF6E8DAE),
    near: Color(0xFF29425E),
    ground: Color(0xFF13233A),
    snow: true,
    water: Color(0xFF244D73),
  ),
  'bg.aurora': _Palette(
    sky: [Color(0xFF020814), Color(0xFF07243A), Color(0xFF0E3B4F)],
    glow: Color(0xFF6DFFC8),
    far: Color(0xFF102536),
    near: Color(0xFF07131D),
    ground: Color(0xFF040B12),
    water: Color(0xFF0B2638),
    stars: true,
    aurora: true,
  ),
  'bg.lavender': _Palette(
    sky: [Color(0xFF2A1847), Color(0xFF8A4F9E), Color(0xFFF0A97A)],
    glow: Color(0xFFFFD3A0),
    far: Color(0xFF5B3A78),
    near: Color(0xFF3A2152),
    ground: Color(0xFF4B2A6E),
    lavender: true,
  ),
};

class ScenePainter extends CustomPainter {
  ScenePainter(this.sceneId, {this.dim = 0.35});
  final String sceneId;
  final double dim;

  @override
  void paint(Canvas canvas, Size size) {
    final p = _palettes[sceneId] ?? _palettes['bg.lake']!;
    final w = size.width, h = size.height;
    final rng = _Rng(Deck.fnv1a(sceneId));
    final rect = Offset.zero & size;
    final horizon = h * 0.55;

    // Sky.
    canvas.drawRect(
      rect,
      Paint()
        ..shader = ui.Gradient.linear(Offset.zero, Offset(0, horizon), p.sky, [
          0,
          0.6,
          1,
        ]),
    );
    // Sun / moon glow.
    final sun = Offset(w * 0.55, horizon - h * 0.08);
    canvas.drawCircle(
      sun,
      w * 0.5,
      Paint()
        ..shader = ui.Gradient.radial(sun, w * 0.5, [
          p.glow.withValues(alpha: p.aurora ? 0.0 : 0.55),
          p.glow.withValues(alpha: 0),
        ]),
    );
    if (!p.aurora) {
      canvas.drawCircle(sun, w * 0.05, Paint()..color = p.glow);
    }
    if (p.stars) {
      final sp = Paint()..color = Colors.white;
      for (var i = 0; i < 140; i++) {
        sp.color = Colors.white.withValues(alpha: 0.3 + rng.next() * 0.7);
        canvas.drawCircle(
          Offset(rng.next() * w, rng.next() * horizon * 0.9),
          rng.next() * 1.3 + 0.3,
          sp,
        );
      }
    }
    if (p.aurora) {
      for (var band = 0; band < 3; band++) {
        final path = Path();
        final y0 = h * (0.12 + band * 0.07);
        path.moveTo(0, y0);
        for (var x = 0.0; x <= w; x += w / 20) {
          path.lineTo(
            x,
            y0 + math.sin(x / w * math.pi * 2.2 + band) * h * 0.05,
          );
        }
        canvas.drawPath(
          path,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = h * 0.06
            ..color = (band == 1 ? const Color(0xFF7CF5FF) : p.glow).withValues(
              alpha: 0.28,
            )
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, h * 0.03),
        );
      }
    }

    // Mountains.
    _ridge(
      canvas,
      size,
      horizon,
      h * 0.22,
      p.far,
      rng,
      sharp: p.snow,
      peaks: 5,
    );
    if (p.snow) _snowCaps(canvas, size, horizon, h * 0.22, rng);
    _ridge(canvas, size, horizon + h * 0.02, h * 0.12, p.near, rng, peaks: 7);

    // Ground / water.
    final groundTop = horizon + h * 0.02;
    if (p.water != null) {
      canvas.drawRect(
        Rect.fromLTRB(0, groundTop, w, h),
        Paint()
          ..shader = ui.Gradient.linear(Offset(0, groundTop), Offset(0, h), [
            p.water!,
            p.ground,
          ]),
      );
      // Glow reflection streaks.
      final refl = Paint()
        ..color = p.glow.withValues(alpha: 0.16)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, h * 0.004);
      for (var i = 0; i < 5; i++) {
        final y = groundTop + i * h * 0.014 + 3;
        final half = w * (0.1 - i * 0.016);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTRB(sun.dx - half, y, sun.dx + half, y + 2.5),
            const Radius.circular(2),
          ),
          refl,
        );
      }
    } else {
      canvas.drawRect(
        Rect.fromLTRB(0, groundTop, w, h),
        Paint()..color = p.ground,
      );
    }

    if (p.lavender) {
      for (var i = 0; i < 14; i++) {
        final t = i / 14;
        final y = groundTop + (h - groundTop) * t * t + 6;
        canvas.drawLine(
          Offset(w * 0.5 - w * (0.1 + t * 1.2), h),
          Offset(w * 0.5 + (t - 0.5) * w * 0.3, groundTop + 4),
          Paint()
            ..color = const Color(0xFF9B6BD6).withValues(alpha: 0.55)
            ..strokeWidth = 3 + t * 8,
        );
        canvas.drawLine(
          Offset(0, y),
          Offset(w, y),
          Paint()
            ..color = const Color(0xFF6E3FA8).withValues(alpha: 0.25)
            ..strokeWidth = 1.5,
        );
      }
    }

    // Foreground silhouettes.
    if (p.palms) {
      _palm(canvas, Offset(w * 0.86, h * 0.98), h * 0.45, p.near);
      _palm(canvas, Offset(w * 0.08, h * 1.0), h * 0.32, p.near);
    } else if (!p.lavender) {
      final treeColor = p.autumn ? const Color(0xFF5A2414) : p.ground;
      for (var i = 0; i < 26; i++) {
        final x = rng.next() * w;
        final side = x < w * 0.3 || x > w * 0.7;
        if (!side) continue;
        final th = h * (0.08 + rng.next() * 0.14);
        _pine(
          canvas,
          Offset(x, groundTop + h * 0.03),
          th,
          treeColor,
          round: p.autumn,
        );
      }
    }

    // Legibility overlay.
    canvas.drawRect(
      rect,
      Paint()
        ..shader = ui.Gradient.linear(
          Offset.zero,
          Offset(0, h),
          [
            Colors.black.withValues(alpha: dim * 0.3),
            Colors.black.withValues(alpha: dim * 0.15),
            Colors.black.withValues(alpha: dim),
          ],
          [0, 0.45, 1],
        ),
    );
  }

  void _ridge(
    Canvas c,
    Size s,
    double base,
    double height,
    Color color,
    _Rng rng, {
    bool sharp = false,
    int peaks = 6,
  }) {
    final path = Path()..moveTo(0, base);
    final step = s.width / peaks;
    for (var i = 0; i <= peaks; i++) {
      final px = i * step + rng.next() * step * 0.3;
      final py = base - height * (0.45 + rng.next() * 0.55);
      if (sharp) {
        path.lineTo(px, py);
        path.lineTo(px + step * 0.5, base - height * 0.25 * rng.next());
      } else {
        path.quadraticBezierTo(
          px - step * 0.3,
          py,
          px + step * 0.2,
          base - height * 0.2,
        );
      }
    }
    path
      ..lineTo(s.width, base)
      ..lineTo(s.width, base + 4)
      ..lineTo(0, base + 4)
      ..close();
    c.drawPath(path, Paint()..color = color);
  }

  void _snowCaps(Canvas c, Size s, double base, double height, _Rng rng) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.85);
    final r2 = _Rng(Deck.fnv1a(sceneId)); // replay ridge geometry
    final step = s.width / 5;
    for (var i = 0; i <= 5; i++) {
      final px = i * step + r2.next() * step * 0.3;
      final py = base - height * (0.45 + r2.next() * 0.55);
      r2.next();
      final capH = height * 0.18;
      c.drawPath(
        Path()
          ..moveTo(px, py)
          ..lineTo(px + capH * 0.9, py + capH)
          ..lineTo(px + capH * 0.3, py + capH * 0.75)
          ..lineTo(px - capH * 0.2, py + capH * 1.05)
          ..lineTo(px - capH * 0.7, py + capH * 0.8)
          ..close(),
        paint,
      );
    }
  }

  void _pine(
    Canvas c,
    Offset base,
    double h,
    Color color, {
    bool round = false,
  }) {
    final p = Paint()..color = color;
    if (round) {
      c.drawRect(
        Rect.fromLTWH(base.dx - h * 0.03, base.dy - h * 0.4, h * 0.06, h * 0.4),
        p,
      );
      c.drawOval(
        Rect.fromCenter(
          center: base.translate(0, -h * 0.6),
          width: h * 0.55,
          height: h * 0.6,
        ),
        Paint()..color = const Color(0xFFB4532A).withValues(alpha: 0.9),
      );
      return;
    }
    final path = Path()..moveTo(base.dx, base.dy - h);
    for (var i = 1; i <= 3; i++) {
      final y = base.dy - h + h * i / 3;
      final half = h * 0.12 * i;
      path
        ..lineTo(base.dx + half, y)
        ..lineTo(base.dx + half * 0.4, y);
    }
    for (var i = 3; i >= 1; i--) {
      final y = base.dy - h + h * i / 3;
      final half = h * 0.12 * i;
      path
        ..lineTo(base.dx - half * 0.4, y)
        ..lineTo(base.dx - half, y);
    }
    path.close();
    c.drawPath(path, p);
  }

  void _palm(Canvas c, Offset base, double h, Color color) {
    final trunk = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = h * 0.04
      ..strokeCap = StrokeCap.round;
    final top = base.translate(-h * 0.15, -h);
    c.drawPath(
      Path()
        ..moveTo(base.dx, base.dy)
        ..quadraticBezierTo(
          base.dx + h * 0.05,
          base.dy - h * 0.6,
          top.dx,
          top.dy,
        ),
      trunk,
    );
    final leaf = Paint()..color = color;
    for (var i = 0; i < 7; i++) {
      final a = -math.pi + i * math.pi / 6;
      final tip =
          top +
          Offset(math.cos(a) * h * 0.38, math.sin(a) * h * 0.22 + h * 0.08);
      c.drawPath(
        Path()
          ..moveTo(top.dx, top.dy)
          ..quadraticBezierTo(
            (top.dx + tip.dx) / 2,
            top.dy - h * 0.1,
            tip.dx,
            tip.dy,
          )
          ..quadraticBezierTo(
            (top.dx + tip.dx) / 2,
            top.dy - h * 0.02,
            top.dx,
            top.dy + h * 0.02,
          ),
        leaf,
      );
    }
  }

  @override
  bool shouldRepaint(ScenePainter old) =>
      old.sceneId != sceneId || old.dim != dim;
}

class _Rng {
  _Rng(int seed) : _r = SeededRandom(seed);
  final SeededRandom _r;
  double next() => _r.nextUint32() / 4294967296.0;
}
