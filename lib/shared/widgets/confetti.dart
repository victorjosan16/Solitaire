import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

/// Subtle, cheap confetti: a fixed set of particles animated by one
/// controller (no per-particle widgets, bounded overdraw). Disabled when
/// [enabled] is false (reduced motion).
class Confetti extends StatefulWidget {
  const Confetti({super.key, this.enabled = true, this.count = 70});
  final bool enabled;
  final int count;
  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );
  late final List<_P> _ps;

  @override
  void initState() {
    super.initState();
    final r = math.Random(7);
    const colors = [
      Color(0xFFF1DDA6),
      Color(0xFFD6B574),
      Color(0xFF3FAE62),
      Color(0xFFC0282D),
      Color(0xFFF7F4EC),
    ];
    _ps = List.generate(
      widget.count,
      (i) => _P(
        x: r.nextDouble(),
        delay: r.nextDouble() * 0.45,
        speed: 0.6 + r.nextDouble() * 0.6,
        drift: (r.nextDouble() - 0.5) * 0.25,
        spin: r.nextDouble() * 8,
        size: 4 + r.nextDouble() * 5,
        color: colors[i % colors.length],
      ),
    );
    if (widget.enabled) _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return const SizedBox.shrink();
    return IgnorePointer(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _c,
          builder: (_, _) => CustomPaint(
            painter: _ConfettiPainter(_ps, _c.value),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}

class _P {
  _P({
    required this.x,
    required this.delay,
    required this.speed,
    required this.drift,
    required this.spin,
    required this.size,
    required this.color,
  });
  final double x, delay, speed, drift, spin, size;
  final Color color;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.ps, this.t);
  final List<_P> ps;
  final double t;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final p in ps) {
      final local = ((t - p.delay) / (1 - p.delay)).clamp(0.0, 1.0);
      if (local <= 0 || local >= 1) continue;
      final y = -20 + local * p.speed * size.height * 1.2;
      final x =
          (p.x + p.drift * local + 0.02 * math.sin(local * 12 + p.spin)) *
          size.width;
      paint.color = p.color.withValues(alpha: (1 - local).clamp(0, 1));
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.spin * local * 3);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: p.size,
          height: p.size * 0.5,
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.t != t;
}
