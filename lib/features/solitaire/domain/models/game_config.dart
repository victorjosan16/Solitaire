/// Rule options for a Klondike game. Changing these never changes the
/// fundamental Klondike rules, only the classic variants players expect.
class GameConfig {
  const GameConfig({
    this.drawCount = 1,
    this.maxRecycles,
    this.allowFoundationToTableau = true,
  }) : assert(drawCount == 1 || drawCount == 3);

  /// Cards turned from stock to waste per draw: 1 or 3.
  final int drawCount;

  /// How many times the waste may be turned back into the stock.
  /// `null` means unlimited (the default classic behaviour).
  final int? maxRecycles;

  /// Whether a foundation top card may be moved back onto the tableau.
  final bool allowFoundationToTableau;

  static const draw1 = GameConfig();
  static const draw3 = GameConfig(drawCount: 3);

  GameConfig copyWith({
    int? drawCount,
    int? Function()? maxRecycles,
    bool? allowFoundationToTableau,
  }) => GameConfig(
    drawCount: drawCount ?? this.drawCount,
    maxRecycles: maxRecycles != null ? maxRecycles() : this.maxRecycles,
    allowFoundationToTableau:
        allowFoundationToTableau ?? this.allowFoundationToTableau,
  );

  /// Stable key used to segment statistics / leaderboards by rule set.
  String get rulesKey =>
      'd$drawCount-r${maxRecycles ?? 'u'}-f${allowFoundationToTableau ? 1 : 0}';

  Map<String, Object?> toJson() => {
    'drawCount': drawCount,
    'maxRecycles': maxRecycles,
    'allowFoundationToTableau': allowFoundationToTableau,
  };

  factory GameConfig.fromJson(Map<String, Object?> json) => GameConfig(
    drawCount: (json['drawCount'] as int?) == 3 ? 3 : 1,
    maxRecycles: json['maxRecycles'] as int?,
    allowFoundationToTableau: json['allowFoundationToTableau'] as bool? ?? true,
  );

  @override
  bool operator ==(Object other) =>
      other is GameConfig &&
      other.drawCount == drawCount &&
      other.maxRecycles == maxRecycles &&
      other.allowFoundationToTableau == allowFoundationToTableau;

  @override
  int get hashCode =>
      Object.hash(drawCount, maxRecycles, allowFoundationToTableau);
}
