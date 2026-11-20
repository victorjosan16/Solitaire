import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';

import '../../domain/models/card.dart';
import 'card_styles.dart';
import 'suit_paths.dart';

/// Paints cards with plain `dart:ui` so the Flame board, Flutter previews
/// and golden tests share exactly the same art. Results are cached as
/// [ui.Picture]s per (style, card, size).
class CardPainter {
  CardPainter._();

  static final Map<String, ui.Picture> _cache = {};

  static void clearCache() {
    for (final p in _cache.values) {
      p.dispose();
    }
    _cache.clear();
  }

  static ui.Picture _cached(String key, Size size, void Function(Canvas) f) {
    final hit = _cache[key];
    if (hit != null) return hit;
    if (_cache.length > 400) clearCache();
    final rec = ui.PictureRecorder();
    final canvas = Canvas(rec, Offset.zero & size);
    f(canvas);
    final pic = rec.endRecording();
    _cache[key] = pic;
    return pic;
  }

  static String _sizeKey(Size s) =>
      '${s.width.toStringAsFixed(1)}x${s.height.toStringAsFixed(1)}';

  /// Draws a card at [origin] (top-left) with [size].
  static void paintCard(
    Canvas canvas,
    Offset origin,
    Size size,
    PlayingCard card, {
    required bool faceUp,
    required CardStyle style,
  }) {
    final key =
        '${style.id}|${faceUp ? card.id : 'back'}|${_sizeKey(size)}';
    final pic = _cached(key, size, (c) {
      if (faceUp) {
        _paintFace(c, size, card, style);
      } else {
        _paintBack(c, size, style);
      }
    });
    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    canvas.drawPicture(pic);
    canvas.restore();
  }

  static RRect _rrect(Size s) => RRect.fromRectAndRadius(
    Offset.zero & s,
    Radius.circular(s.width * 0.09),
  );

  static void _paintFace(Canvas c, Size s, PlayingCard card, CardStyle st) {
    final rr = _rrect(s);
    final rect = Offset.zero & s;
    c.drawRRect(
      rr,
      Paint()
        ..shader = ui.Gradient.linear(
          rect.topCenter,
          rect.bottomCenter,
          [st.face, st.faceGradientEnd ?? st.face],
        ),
    );
    c.drawRRect(
      rr.deflate(0.5),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1, s.width * 0.018)
        ..color = st.faceEdge,
    );
    if (st.innerBorder != null) {
      c.drawRRect(
        rr.deflate(s.width * 0.06),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(0.6, s.width * 0.01)
          ..color = st.innerBorder!.withValues(alpha: 0.7),
      );
    }

    final color = card.isRed ? st.red : st.black;
    final w = s.width, h = s.height;

    // Index: big rank top-left, small suit top-right. Both live in the top
    // ~28% so they stay readable when cards overlap in the tableau.
    final rankStyle = TextStyle(
      color: color,
      fontSize: w * (card.rank == 10 ? 0.36 : 0.40),
      fontWeight: FontWeight.w800,
      height: 1,
      letterSpacing: card.rank == 10 ? -w * 0.03 : 0,
      shadows: st.glow
          ? [Shadow(color: color.withValues(alpha: 0.8), blurRadius: w * 0.08)]
          : null,
    );
    final tp = TextPainter(
      text: TextSpan(text: card.rankLabel, style: rankStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(c, Offset(w * 0.08, h * 0.045));
    tp.dispose();

    final suitPaint = Paint()..color = color;
    final small = Rect.fromLTWH(w * 0.6, h * 0.06, w * 0.3, w * 0.3);
    c.drawPath(SuitPaths.path(card.suit, small), suitPaint);

    // Centre: large pip; court cards get a crown-like accent band.
    final big = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.64),
      width: w * 0.58,
      height: w * 0.58,
    );
    if (st.glow) {
      c.drawPath(
        SuitPaths.path(card.suit, big),
        Paint()
          ..color = color.withValues(alpha: 0.6)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 0.06),
      );
    }
    c.drawPath(SuitPaths.path(card.suit, big), suitPaint);
    if (card.rank > 10) {
      _paintCourtMark(c, Offset(w * 0.5, h * 0.37), w * 0.22, color, card.rank);
    }
  }

  /// Small original ornament distinguishing J / Q / K.
  static void _paintCourtMark(
    Canvas c,
    Offset centre,
    double size,
    Color color,
    int rank,
  ) {
    final p = Paint()
      ..color = color.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size * 0.12
      ..strokeJoin = StrokeJoin.round;
    final half = size / 2;
    final path = Path();
    final points = rank == 13 ? 3 : (rank == 12 ? 2 : 1);
    // A zig-zag crown with 1/2/3 peaks.
    final base = centre.dy + half * 0.4;
    final top = centre.dy - half * 0.5;
    final left = centre.dx - half;
    final step = size / (points * 2);
    path.moveTo(left, base);
    for (var i = 0; i < points; i++) {
      path.lineTo(left + step * (2 * i + 1), top);
      path.lineTo(left + step * (2 * i + 2), base - size * 0.15);
    }
    path.lineTo(left + size, base);
    path.close();
    c.drawPath(path, p);
  }

  static void _paintBack(Canvas c, Size s, CardStyle st) {
    final rr = _rrect(s);
    final rect = Offset.zero & s;
    c.drawRRect(
      rr,
      Paint()
        ..shader = ui.Gradient.radial(
          rect.center,
          s.longestSide * 0.7,
          [st.backBase, st.backAccent],
        ),
    );
    final w = s.width;
    final inner = rr.deflate(w * 0.07);
    final orn = Paint()
      ..color = st.backOrnament.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(0.8, w * 0.02);
    c.drawRRect(inner, orn);

    // Fine lattice clipped to the inner frame.
    c.save();
    c.clipRRect(inner);
    final lattice = Paint()
      ..color = st.backOrnament.withValues(alpha: 0.18)
      ..strokeWidth = math.max(0.5, w * 0.008);
    final step = w * 0.14;
    for (var x = -s.height; x < s.width + s.height; x += step) {
      c.drawLine(Offset(x, 0), Offset(x + s.height, s.height), lattice);
      c.drawLine(Offset(x, s.height), Offset(x + s.height, 0), lattice);
    }
    c.restore();

    // Central medallion: diamond frame with a four-point star.
    final ctr = rect.center;
    final r = w * 0.26;
    final medallion = Path()
      ..moveTo(ctr.dx, ctr.dy - r * 1.3)
      ..lineTo(ctr.dx + r, ctr.dy)
      ..lineTo(ctr.dx, ctr.dy + r * 1.3)
      ..lineTo(ctr.dx - r, ctr.dy)
      ..close();
    c.drawPath(medallion, Paint()..color = st.backAccent);
    c.drawPath(medallion, orn);
    final star = Path();
    for (var i = 0; i < 8; i++) {
      final a = i * math.pi / 4 - math.pi / 2;
      final rad = i.isEven ? r * 0.75 : r * 0.22;
      final pt = Offset(ctr.dx + rad * math.cos(a), ctr.dy + rad * math.sin(a));
      if (i == 0) {
        star.moveTo(pt.dx, pt.dy);
      } else {
        star.lineTo(pt.dx, pt.dy);
      }
    }
    star.close();
    c.drawPath(star, Paint()..color = st.backOrnament);
    if (st.glow) {
      c.drawRRect(
        inner,
        Paint()
          ..color = st.backOrnament.withValues(alpha: 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = w * 0.03
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 0.04),
      );
    }
    c.drawRRect(
      rr.deflate(0.5),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = const Color(0x55000000),
    );
  }

  /// Empty pile placeholder (foundation shows a faint suit).
  static void paintSlot(
    Canvas canvas,
    Rect rect, {
    required TableStyle table,
    Suit? suit,
    bool recycle = false,
    bool highlight = false,
  }) {
    final rr = RRect.fromRectAndRadius(rect, Radius.circular(rect.width * 0.09));
    canvas.drawRRect(rr, Paint()..color = table.slot.withValues(alpha: 0.75));
    canvas.drawRRect(
      rr.deflate(0.5),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = highlight ? 2.5 : 1.2
        ..color = highlight
            ? const Color(0xFFF1DDA6)
            : const Color(0xFFD6B574).withValues(alpha: 0.35),
    );
    final mark = Paint()
      ..color = const Color(0xFFD6B574).withValues(alpha: 0.28);
    if (suit != null) {
      final r = Rect.fromCenter(
        center: rect.center,
        width: rect.width * 0.5,
        height: rect.width * 0.5,
      );
      canvas.drawPath(SuitPaths.path(suit, r), mark);
    } else if (recycle) {
      final p = Paint()
        ..color = const Color(0xFFD6B574).withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = rect.width * 0.06
        ..strokeCap = StrokeCap.round;
      final r = rect.width * 0.22;
      canvas.drawArc(
        Rect.fromCircle(center: rect.center, radius: r),
        -math.pi * 0.35,
        math.pi * 1.6,
        false,
        p,
      );
      final tip = rect.center + Offset(r * math.cos(-math.pi * 0.35),
          r * math.sin(-math.pi * 0.35));
      canvas.drawLine(tip, tip + Offset(-r * 0.5, -r * 0.05), p);
      canvas.drawLine(tip, tip + Offset(r * 0.05, r * 0.5), p);
    }
    if (highlight) {
      canvas.drawRRect(
        rr,
        Paint()
          ..color = const Color(0xFFD6B574).withValues(alpha: 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      );
    }
  }

  /// Felt table background with a soft vignette and subtle damask pattern.
  static void paintTable(Canvas canvas, Size size, TableStyle t) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = ui.Gradient.radial(
          rect.center.translate(0, -size.height * 0.1),
          size.longestSide * 0.75,
          [t.center, t.edge],
        ),
    );
    if (!t.pattern) return;
    final p = Paint()..color = const Color(0x0DFFFFFF);
    final cell = math.max(36.0, size.shortestSide / 9);
    for (var y = 0.0; y < size.height + cell; y += cell) {
      for (var x = ((y / cell).round().isEven ? 0.0 : cell / 2);
          x < size.width + cell;
          x += cell) {
        final d = cell * 0.12;
        canvas.drawPath(
          Path()
            ..moveTo(x, y - d)
            ..lineTo(x + d, y)
            ..lineTo(x, y + d)
            ..lineTo(x - d, y)
            ..close(),
          p,
        );
      }
    }
  }
}
