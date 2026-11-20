/// Cosmetic catalog. Purely visual; never affects rules or scoring.
enum CosmeticKind { cards, background, table }

class CosmeticItem {
  const CosmeticItem({
    required this.id,
    required this.kind,
    required this.price,
  });

  /// Stable id, e.g. `cards.classic`. Localized names are keyed by id.
  final String id;
  final CosmeticKind kind;

  /// Price in virtual coins. 0 = free / owned by default.
  final int price;

  bool get isFree => price == 0;
}

const List<CosmeticItem> cosmeticCatalog = [
  // Card packs (face style + matching back).
  CosmeticItem(id: 'cards.classic', kind: CosmeticKind.cards, price: 0),
  CosmeticItem(id: 'cards.elegant', kind: CosmeticKind.cards, price: 500),
  CosmeticItem(id: 'cards.vintage', kind: CosmeticKind.cards, price: 700),
  CosmeticItem(id: 'cards.modern', kind: CosmeticKind.cards, price: 700),
  CosmeticItem(id: 'cards.neon', kind: CosmeticKind.cards, price: 900),
  CosmeticItem(id: 'cards.gold', kind: CosmeticKind.cards, price: 1000),
  // Backgrounds (menus, splash): painted original scenes.
  CosmeticItem(id: 'bg.lake', kind: CosmeticKind.background, price: 0),
  CosmeticItem(id: 'bg.autumn', kind: CosmeticKind.background, price: 400),
  CosmeticItem(id: 'bg.tropic', kind: CosmeticKind.background, price: 500),
  CosmeticItem(id: 'bg.alpine', kind: CosmeticKind.background, price: 600),
  CosmeticItem(id: 'bg.aurora', kind: CosmeticKind.background, price: 800),
  CosmeticItem(id: 'bg.lavender', kind: CosmeticKind.background, price: 800),
  // Table surfaces (gameplay).
  CosmeticItem(id: 'table.emerald', kind: CosmeticKind.table, price: 0),
  CosmeticItem(id: 'table.navy', kind: CosmeticKind.table, price: 300),
  CosmeticItem(id: 'table.burgundy', kind: CosmeticKind.table, price: 400),
  CosmeticItem(id: 'table.walnut', kind: CosmeticKind.table, price: 500),
  CosmeticItem(id: 'table.slate', kind: CosmeticKind.table, price: 500),
  CosmeticItem(id: 'table.contrast', kind: CosmeticKind.table, price: 0),
];

CosmeticItem? cosmeticById(String id) {
  for (final c in cosmeticCatalog) {
    if (c.id == id) return c;
  }
  return null;
}

class EquippedCosmetics {
  const EquippedCosmetics({
    this.cards = defaultCards,
    this.background = defaultBackground,
    this.table = defaultTable,
  });

  static const defaultCards = 'cards.classic';
  static const defaultBackground = 'bg.lake';
  static const defaultTable = 'table.emerald';

  final String cards;
  final String background;
  final String table;

  bool get isDefault =>
      cards == defaultCards &&
      background == defaultBackground &&
      table == defaultTable;

  String forKind(CosmeticKind k) => switch (k) {
    CosmeticKind.cards => cards,
    CosmeticKind.background => background,
    CosmeticKind.table => table,
  };

  EquippedCosmetics withItem(CosmeticItem item) => switch (item.kind) {
    CosmeticKind.cards => EquippedCosmetics(
      cards: item.id,
      background: background,
      table: table,
    ),
    CosmeticKind.background => EquippedCosmetics(
      cards: cards,
      background: item.id,
      table: table,
    ),
    CosmeticKind.table => EquippedCosmetics(
      cards: cards,
      background: background,
      table: item.id,
    ),
  };

  Map<String, Object?> toJson() => {
    'cards': cards,
    'background': background,
    'table': table,
  };

  factory EquippedCosmetics.fromJson(Map<String, Object?> j) {
    String pick(String key, String def, CosmeticKind kind) {
      final v = j[key];
      final item = v is String ? cosmeticById(v) : null;
      return item != null && item.kind == kind ? item.id : def;
    }

    return EquippedCosmetics(
      cards: pick('cards', defaultCards, CosmeticKind.cards),
      background: pick(
        'background',
        defaultBackground,
        CosmeticKind.background,
      ),
      table: pick('table', defaultTable, CosmeticKind.table),
    );
  }
}
