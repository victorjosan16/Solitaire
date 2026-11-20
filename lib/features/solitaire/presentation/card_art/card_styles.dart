import 'dart:ui';

/// Visual definition of a card pack (face + back). Purely cosmetic.
class CardStyle {
  const CardStyle({
    required this.id,
    required this.face,
    required this.faceEdge,
    required this.red,
    required this.black,
    required this.backBase,
    required this.backAccent,
    required this.backOrnament,
    this.faceGradientEnd,
    this.innerBorder,
    this.glow = false,
  });

  final String id;
  final Color face;
  final Color? faceGradientEnd;
  final Color faceEdge;
  final Color red;
  final Color black;
  final Color? innerBorder;
  final Color backBase;
  final Color backAccent;
  final Color backOrnament;
  final bool glow;

  static const classic = CardStyle(
    id: 'cards.classic',
    face: Color(0xFFFBF9F3),
    faceGradientEnd: Color(0xFFF0EBDD),
    faceEdge: Color(0xFFCFC6B0),
    red: Color(0xFFC0282D),
    black: Color(0xFF17191C),
    backBase: Color(0xFF0F4A3F),
    backAccent: Color(0xFF0A3029),
    backOrnament: Color(0xFFD6B574),
  );

  static const elegant = CardStyle(
    id: 'cards.elegant',
    face: Color(0xFFFFFBF0),
    faceGradientEnd: Color(0xFFF6EBD3),
    faceEdge: Color(0xFFC9B27C),
    red: Color(0xFFB0202A),
    black: Color(0xFF1B1D2A),
    innerBorder: Color(0xFFC9A55A),
    backBase: Color(0xFF15233A),
    backAccent: Color(0xFF0B1424),
    backOrnament: Color(0xFFE2C27F),
  );

  static const vintage = CardStyle(
    id: 'cards.vintage',
    face: Color(0xFFF1E6CC),
    faceGradientEnd: Color(0xFFE2D2AE),
    faceEdge: Color(0xFFA48C62),
    red: Color(0xFF9A2424),
    black: Color(0xFF2E2620),
    innerBorder: Color(0xFF8C7450),
    backBase: Color(0xFF6B2A22),
    backAccent: Color(0xFF451812),
    backOrnament: Color(0xFFE6CFA0),
  );

  static const modern = CardStyle(
    id: 'cards.modern',
    face: Color(0xFFFFFFFF),
    faceEdge: Color(0xFFD5D9DE),
    red: Color(0xFFE23A3A),
    black: Color(0xFF1F2933),
    backBase: Color(0xFF2B3A55),
    backAccent: Color(0xFF1C2639),
    backOrnament: Color(0xFF8FB3FF),
  );

  static const neon = CardStyle(
    id: 'cards.neon',
    face: Color(0xFF1C1633),
    faceGradientEnd: Color(0xFF120E24),
    faceEdge: Color(0xFF8A6BFF),
    red: Color(0xFFFF5C9A),
    black: Color(0xFF63E6FF),
    backBase: Color(0xFF3A1C70),
    backAccent: Color(0xFF1D0E3D),
    backOrnament: Color(0xFFB98CFF),
    glow: true,
  );

  static const gold = CardStyle(
    id: 'cards.gold',
    face: Color(0xFFF8E7B5),
    faceGradientEnd: Color(0xFFE5C77C),
    faceEdge: Color(0xFFA9853E),
    red: Color(0xFFA3161D),
    black: Color(0xFF2A2013),
    innerBorder: Color(0xFFA9853E),
    backBase: Color(0xFFC9A251),
    backAccent: Color(0xFF8E6B28),
    backOrnament: Color(0xFF173F37),
  );

  static const all = [classic, elegant, vintage, modern, neon, gold];

  static CardStyle byId(String id) =>
      all.firstWhere((s) => s.id == id, orElse: () => classic);
}

/// Gameplay table surface. Purely cosmetic.
class TableStyle {
  const TableStyle({
    required this.id,
    required this.center,
    required this.edge,
    required this.slot,
    this.pattern = true,
  });

  final String id;
  final Color center;
  final Color edge;
  final Color slot;
  final bool pattern;

  static const emerald = TableStyle(
    id: 'table.emerald',
    center: Color(0xFF17574B),
    edge: Color(0xFF0A2A25),
    slot: Color(0xFF0B3530),
  );
  static const navy = TableStyle(
    id: 'table.navy',
    center: Color(0xFF1E3550),
    edge: Color(0xFF0A1420),
    slot: Color(0xFF0E1D2E),
  );
  static const burgundy = TableStyle(
    id: 'table.burgundy',
    center: Color(0xFF5E1F2A),
    edge: Color(0xFF250A10),
    slot: Color(0xFF3A1118),
  );
  static const walnut = TableStyle(
    id: 'table.walnut',
    center: Color(0xFF5A3D27),
    edge: Color(0xFF23160C),
    slot: Color(0xFF3A271A),
  );
  static const slate = TableStyle(
    id: 'table.slate',
    center: Color(0xFF3C4650),
    edge: Color(0xFF151A1F),
    slot: Color(0xFF262E36),
  );

  /// Accessibility option: flat, very dark table for maximum contrast.
  static const contrast = TableStyle(
    id: 'table.contrast',
    center: Color(0xFF0B0F12),
    edge: Color(0xFF000000),
    slot: Color(0xFF20262B),
    pattern: false,
  );

  static const all = [emerald, navy, burgundy, walnut, slate, contrast];

  static TableStyle byId(String id) =>
      all.firstWhere((s) => s.id == id, orElse: () => emerald);
}
