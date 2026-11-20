import 'dart:typed_data';
import 'dart:ui';

import '../../domain/models/card.dart';

/// Original vector suit symbols, drawn in a unit box and scaled.
abstract final class SuitPaths {
  static final Map<Suit, Path> _unit = {
    Suit.hearts: _heart(),
    Suit.diamonds: _diamond(),
    Suit.spades: _spade(),
    Suit.clubs: _club(),
  };

  /// Path for [suit] fitted into [rect] (keeps aspect ratio, centred).
  static Path path(Suit suit, Rect rect) {
    final s = rect.shortestSide;
    final dx = rect.left + (rect.width - s) / 2;
    final dy = rect.top + (rect.height - s) / 2;
    final m = Float64List.fromList([
      s, 0, 0, 0, //
      0, s, 0, 0, //
      0, 0, 1, 0, //
      dx, dy, 0, 1, //
    ]);
    return _unit[suit]!.transform(m);
  }

  static Path _heart() => Path()
    ..moveTo(0.5, 0.95)
    ..cubicTo(0.38, 0.82, 0.04, 0.6, 0.04, 0.33)
    ..cubicTo(0.04, 0.15, 0.17, 0.05, 0.3, 0.05)
    ..cubicTo(0.4, 0.05, 0.47, 0.11, 0.5, 0.2)
    ..cubicTo(0.53, 0.11, 0.6, 0.05, 0.7, 0.05)
    ..cubicTo(0.83, 0.05, 0.96, 0.15, 0.96, 0.33)
    ..cubicTo(0.96, 0.6, 0.62, 0.82, 0.5, 0.95)
    ..close();

  static Path _diamond() => Path()
    ..moveTo(0.5, 0.02)
    ..quadraticBezierTo(0.68, 0.3, 0.88, 0.5)
    ..quadraticBezierTo(0.68, 0.7, 0.5, 0.98)
    ..quadraticBezierTo(0.32, 0.7, 0.12, 0.5)
    ..quadraticBezierTo(0.32, 0.3, 0.5, 0.02)
    ..close();

  static Path _spade() {
    final p = Path()
      ..moveTo(0.5, 0.03)
      ..cubicTo(0.62, 0.2, 0.95, 0.38, 0.95, 0.6)
      ..cubicTo(0.95, 0.75, 0.83, 0.83, 0.71, 0.83)
      ..cubicTo(0.62, 0.83, 0.55, 0.78, 0.52, 0.72)
      ..quadraticBezierTo(0.55, 0.88, 0.68, 0.97)
      ..lineTo(0.32, 0.97)
      ..quadraticBezierTo(0.45, 0.88, 0.48, 0.72)
      ..cubicTo(0.45, 0.78, 0.38, 0.83, 0.29, 0.83)
      ..cubicTo(0.17, 0.83, 0.05, 0.75, 0.05, 0.6)
      ..cubicTo(0.05, 0.38, 0.38, 0.2, 0.5, 0.03)
      ..close();
    return p;
  }

  static Path _club() {
    final p = Path()
      ..addOval(Rect.fromCircle(center: const Offset(0.5, 0.27), radius: 0.2))
      ..addOval(Rect.fromCircle(center: const Offset(0.27, 0.56), radius: 0.2))
      ..addOval(Rect.fromCircle(center: const Offset(0.73, 0.56), radius: 0.2))
      ..addRect(const Rect.fromLTWH(0.4, 0.4, 0.2, 0.2));
    final stem = Path()
      ..moveTo(0.47, 0.55)
      ..quadraticBezierTo(0.46, 0.85, 0.32, 0.97)
      ..lineTo(0.68, 0.97)
      ..quadraticBezierTo(0.54, 0.85, 0.53, 0.55)
      ..close();
    return Path.combine(PathOperation.union, p, stem);
  }
}
