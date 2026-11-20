import 'card.dart';
import 'game_config.dart';
import 'game_mode.dart';
import 'game_state.dart';
import 'move.dart';

/// Everything needed to restore a game exactly after process death:
/// initial deck (restart), current board, undo log, timer and assists.
class GameSnapshot {
  GameSnapshot({
    required this.gameId,
    required this.seed,
    required this.mode,
    required this.config,
    required this.deckOrder,
    required this.state,
    required this.history,
    required this.elapsedMs,
    required this.startedAt,
    required this.updatedAt,
    this.dailyDate,
    this.hintsUsed = 0,
    this.undosUsed = 0,
    this.combo = 0,
    this.maxCombo = 0,
    this.usedAutoFinish = false,
    this.finished = false,
  });

  static const int schemaVersion = 1;

  /// Immutable unique id: used as the idempotency key for rewards/stats.
  final String gameId;
  final int seed;
  final GameMode mode;
  final GameConfig config;

  /// Card ids in dealing order (allows "Restart" to the exact initial deal
  /// even if the shuffle algorithm ever changes).
  final List<int> deckOrder;
  final GameState state;
  final List<MoveRecord> history;
  final int elapsedMs;
  final DateTime startedAt;
  final DateTime updatedAt;
  final String? dailyDate;
  final int hintsUsed;
  final int undosUsed;
  final int combo;
  final int maxCombo;
  final bool usedAutoFinish;
  final bool finished;

  List<PlayingCard> get deck => [
    for (final i in deckOrder) PlayingCard.fromId(i),
  ];

  bool get hasProgress => history.isNotEmpty;

  GameSnapshot copyWith({
    GameState? state,
    List<MoveRecord>? history,
    int? elapsedMs,
    DateTime? updatedAt,
    int? hintsUsed,
    int? undosUsed,
    int? combo,
    int? maxCombo,
    bool? usedAutoFinish,
    bool? finished,
  }) => GameSnapshot(
    gameId: gameId,
    seed: seed,
    mode: mode,
    config: config,
    deckOrder: deckOrder,
    state: state ?? this.state,
    history: history ?? this.history,
    elapsedMs: elapsedMs ?? this.elapsedMs,
    startedAt: startedAt,
    updatedAt: updatedAt ?? this.updatedAt,
    dailyDate: dailyDate,
    hintsUsed: hintsUsed ?? this.hintsUsed,
    undosUsed: undosUsed ?? this.undosUsed,
    combo: combo ?? this.combo,
    maxCombo: maxCombo ?? this.maxCombo,
    usedAutoFinish: usedAutoFinish ?? this.usedAutoFinish,
    finished: finished ?? this.finished,
  );

  Map<String, Object?> toJson() => {
    'gameId': gameId,
    'seed': seed,
    'mode': mode.name,
    'config': config.toJson(),
    'deckOrder': deckOrder,
    'state': state.toJson(),
    'history': [for (final h in history) h.toJson()],
    'elapsedMs': elapsedMs,
    'startedAt': startedAt.toUtc().toIso8601String(),
    'updatedAt': updatedAt.toUtc().toIso8601String(),
    'dailyDate': dailyDate,
    'hintsUsed': hintsUsed,
    'undosUsed': undosUsed,
    'combo': combo,
    'maxCombo': maxCombo,
    'usedAutoFinish': usedAutoFinish,
    'finished': finished,
  };

  /// Throws [FormatException] on any structural problem so the store can
  /// fall back to a backup instead of resuming a corrupt board.
  factory GameSnapshot.fromJson(Map<String, Object?> json) {
    try {
      final snap = GameSnapshot(
        gameId: json['gameId']! as String,
        seed: json['seed']! as int,
        mode: GameMode.values.byName(json['mode']! as String),
        config: GameConfig.fromJson(
          (json['config']! as Map).cast<String, Object?>(),
        ),
        deckOrder: [for (final e in json['deckOrder']! as List) e as int],
        state: GameState.fromJson(
          (json['state']! as Map).cast<String, Object?>(),
        ),
        history: [
          for (final h in json['history']! as List)
            MoveRecord.fromJson((h as Map).cast<String, Object?>()),
        ],
        elapsedMs: json['elapsedMs']! as int,
        startedAt: DateTime.parse(json['startedAt']! as String),
        updatedAt: DateTime.parse(json['updatedAt']! as String),
        dailyDate: json['dailyDate'] as String?,
        hintsUsed: json['hintsUsed'] as int? ?? 0,
        undosUsed: json['undosUsed'] as int? ?? 0,
        combo: json['combo'] as int? ?? 0,
        maxCombo: json['maxCombo'] as int? ?? 0,
        usedAutoFinish: json['usedAutoFinish'] as bool? ?? false,
        finished: json['finished'] as bool? ?? false,
      );
      snap.validate();
      return snap;
    } on FormatException {
      rethrow;
    } catch (e) {
      throw FormatException('Invalid game snapshot: $e');
    }
  }

  /// Structural validation: complete deck in both deck order and board.
  void validate() {
    final ids = deckOrder.toSet();
    if (deckOrder.length != 52 || ids.length != 52) {
      throw const FormatException('deckOrder is not a full deck');
    }
    final board = state.allCards.map((c) => c.id).toList();
    if (board.length != 52 || board.toSet().length != 52) {
      throw const FormatException('board does not contain 52 unique cards');
    }
    if (elapsedMs < 0) throw const FormatException('negative time');
  }
}
