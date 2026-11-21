import 'package:material_ui/material_ui.dart';

/// Midnight Emerald / Midnight Gold design tokens.
abstract final class NovaColors {
  static const navy = Color(0xFF101C29);
  static const navyDeep = Color(0xFF0A121B);
  static const emerald = Color(0xFF10443B);
  static const emeraldDeep = Color(0xFF092B27);
  static const emeraldLight = Color(0xFF1B5A50);
  static const gold = Color(0xFFD5B776);
  static const goldLight = Color(0xFFF1DDA6);
  static const goldDark = Color(0xFF9C7B3E);
  static const ivory = Color(0xFFF6F1E7);
  static const sage = Color(0xFF77958C);
  static const success = Color(0xFF3AA66F);
  static const danger = Color(0xFFC0392B);
  static const cardRed = Color(0xFFC0282D);
  static const cardBlack = Color(0xFF17191C);

  /// Text on dark surfaces.
  static const textPrimary = ivory;
  static const textSecondary = Color(0xFFB6C6BE);
  static const textMuted = Color(0xFF7F948D);

  static const goldGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFF1B8),
      Color(0xFFF6CF55),
      Color(0xFFE2A92C),
      Color(0xFFB27A16),
    ],
    stops: [0, 0.42, 0.78, 1],
  );

  /// Metallic rim used around emerald controls (thick gold frame).
  static const rimGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF0B0),
      Color(0xFFE8B83E),
      Color(0xFF9C6A12),
      Color(0xFFF4D67A),
      Color(0xFFB8841F),
    ],
    stops: [0, 0.3, 0.55, 0.8, 1],
  );

  static const panelGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF14523F), Color(0xFF0A3326)],
  );

  static const screenGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF10443B), Color(0xFF092B27), Color(0xFF0A1D1F)],
    stops: [0, 0.6, 1],
  );
}

abstract final class NovaSpace {
  static const double xs = 4, sm = 8, md = 12, lg = 16, xl = 24, xxl = 32;
}

abstract final class NovaRadius {
  static const double sm = 8, md = 14, lg = 20, pill = 999;
  static const card = 0.08; // fraction of card width
}

abstract final class NovaShadows {
  static const soft = [
    BoxShadow(color: Color(0x66000000), blurRadius: 12, offset: Offset(0, 4)),
  ];
  static const raised = [
    BoxShadow(color: Color(0x80000000), blurRadius: 18, offset: Offset(0, 8)),
  ];
  static List<BoxShadow> goldGlow([double a = 0.35]) => [
    BoxShadow(
      color: NovaColors.gold.withValues(alpha: a),
      blurRadius: 16,
      spreadRadius: 0.5,
    ),
  ];
}

abstract final class NovaDurations {
  static const fast = Duration(milliseconds: 140);
  static const medium = Duration(milliseconds: 220);
  static const slow = Duration(milliseconds: 420);
}

abstract final class NovaIconSize {
  static const double sm = 18, md = 24, lg = 32, xl = 44;
}

/// Font families bundled in assets/fonts (OFL).
abstract final class NovaFonts {
  /// Brand wordmark only (Latin): "SOLITAIRE NOVA".
  static const brand = 'Cinzel';

  /// Display headings, full Latin + Cyrillic coverage.
  static const display = 'Cormorant';
}
