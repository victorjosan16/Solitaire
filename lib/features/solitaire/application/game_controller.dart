import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ads/ad_service.dart';
import '../../../shared/models/profile.dart';
import '../../../core/logging/app_logger.dart';
import '../../../core/providers.dart';
import '../../../core/services/audio_service.dart';
import '../../daily_challenge/domain/daily_challenge.dart';
import '../../settings/application/settings_controller.dart';
import '../../settings/domain/app_settings.dart';
import '../../statistics/application/profile_controller.dart';
import '../../statistics/domain/player_stats.dart';
import '../data/game_repository.dart';
import '../domain/engine/deck.dart';
import '../domain/engine/klondike_engine.dart';
import '../domain/engine/move_advisor.dart';
import '../domain/engine/verified_seeds.dart';
import '../domain/models/card.dart';
import '../domain/models/game_config.dart';
import '../domain/models/game_mode.dart';
import '../domain/models/game_snapshot.dart';
import '../domain/models/game_state.dart';
import '../domain/models/move.dart';
import '../domain/models/pile_ref.dart';
import '../domain/rules/klondike_rules.dart';
import '../domain/scoring/scoring.dart';
import 'play_clock.dart';

final gameRepositoryProvider = Provider<GameRepository>(
  (ref) => GameRepository(ref.watch(documentStoreProvider)),
);

/// One-shot UI signals carry a serial so listeners react exactly once.
class Signal<T> {
  const Signal(this.value, this.serial);
  final T value;
  final int serial;
}

class VictoryReport {
  const VictoryReport({
    required this.gameId,
    required this.mode,
    required this.drawCount,
    required this.baseScore,
    required this.timeBonus,
    required this.finalScore,
    required this.elapsedMs,
    required this.moves,
    required this.maxCombo,
    required this.coinsEarned,
    required this.bestScore,
    required this.newRecord,
    required this.newAchievements,
    required this.achievementCoins,
    required this.dailyRewarded,
    this.speedBonus = 0,
  });

  final int speedBonus;

  final String gameId;
  final GameMode mode;
  final int drawCount;
  final int baseScore;
  final int timeBonus;
  final int finalScore;
  final int elapsedMs;
  final int moves;
  final int maxCombo;
  final int coinsEarned;
  final int bestScore;
  final bool newRecord;
  final List<String> newAchievements;
  final int achievementCoins;
  final bool dailyRewarded;
}

enum HintResult { shown, noMoves, noTokens, disabled }

enum ShuffleResult { done, insufficientCoins, limitReached, unavailable }

class GameViewState {
  const GameViewState({
    this.snapshot,
    this.autoFinishing = false,
    this.canAutoFinish = false,
    this.hint,
    this.invalid,
    this.victory,
    this.comboSignal,
  });

  final GameSnapshot? snapshot;
  final bool autoFinishing;
  final bool canAutoFinish;
  final Signal<Move>? hint;

  /// The pile the player tried to move from illegally (board shakes it).
  final Signal<PileRef>? invalid;
  final VictoryReport? victory;
  final Signal<int>? comboSignal;

  GameState? get board => snapshot?.state;
  bool get hasActiveGame => snapshot != null && !snapshot!.finished;

  GameViewState copyWith({
    GameSnapshot? snapshot,
    bool? autoFinishing,
    bool? canAutoFinish,
    Signal<Move>? hint,
    Signal<PileRef>? invalid,
    VictoryReport? Function()? victory,
    Signal<int>? comboSignal,
  }) => GameViewState(
    snapshot: snapshot ?? this.snapshot,
    autoFinishing: autoFinishing ?? this.autoFinishing,
    canAutoFinish: canAutoFinish ?? this.canAutoFinish,
    hint: hint ?? this.hint,
    invalid: invalid ?? this.invalid,
    victory: victory != null ? victory() : this.victory,
    comboSignal: comboSignal ?? this.comboSignal,
  );
}

/// Application-layer orchestration of a Klondike session: applies player
/// intents through the pure engine, keeps the undo log, runs the play clock,
/// persists after every action and records results exactly once.
class GameController extends Notifier<GameViewState> {
  late PlayClock _clock;
  int _serial = 0;
  bool _cancelAuto = false;
  late Random _rng;

  @override
  GameViewState build() {
    _rng = ref.read(randomProvider);
    final initial = ref.read(initialGameProvider);
    _clock = PlayClock(
      now: ref.read(clockProvider),
      initialElapsedMs: initial?.elapsedMs ?? 0,
    );
    ref.onDispose(() => _cancelAuto = true);
    final s = GameViewState(snapshot: initial);
    // A game finished but killed before results were saved: record it now
    // (idempotent via the profile ledger).
    if (initial != null && initial.finished) {
      Future.microtask(() => _recordWin(initial));
    }
    return s.copyWith(
      canAutoFinish: initial != null && !initial.finished
          ? MoveAdvisor.canAutoFinish(initial.state)
          : false,
    );
  }

  AppSettings get _settings => ref.read(settingsProvider);
  AudioService get _audio => ref.read(audioServiceProvider);
  DateTime get _now => ref.read(clockProvider)();

  int get elapsedMs => _clock.elapsedMs;
  bool get clockRunning => _clock.isRunning;

  // ------------------------------------------------------------ lifecycle

  void resumeClock() {
    final s = state.snapshot;
    if (s != null && !s.finished && !state.autoFinishing) _clock.start();
  }

  /// Stops the clock without touching provider state (safe in dispose).
  void pauseClock() => _clock.pause();

  /// Pauses timing and persists immediately (app background, menus).
  Future<void> pauseAndSave() async {
    _clock.pause();
    await _save();
  }

  // ------------------------------------------------------------ new games

  GameConfig _configFor(int drawCount, GameMode mode) {
    if (mode == GameMode.daily) return GameConfig.draw1;
    final s = _settings;
    return GameConfig(
      drawCount: drawCount,
      maxRecycles: s.unlimitedRecycles ? null : (drawCount == 1 ? 2 : 3),
      allowFoundationToTableau: s.allowFoundationToTableau,
    );
  }

  String _newId() =>
      '${_now.microsecondsSinceEpoch.toRadixString(36)}-'
      '${_rng.nextInt(1 << 32).toRadixString(36)}';

  Future<void> startNewGame({
    GameMode mode = GameMode.random,
    int? drawCount,
    DateTime? dailyDate,
  }) async {
    await _abandonCurrent();
    final draw = mode == GameMode.daily
        ? 1
        : (drawCount ?? _settings.defaultDrawCount);
    final int seed;
    switch (mode) {
      case GameMode.random:
        seed = _rng.nextInt(0x7FFFFFFF);
      case GameMode.winning:
        final list = draw == 3 ? verifiedDraw3Seeds : verifiedDraw1Seeds;
        seed = list[_rng.nextInt(list.length)];
      case GameMode.daily:
        seed = DailyChallenge.seedFor(dailyDate ?? _now);
    }
    final config = _configFor(draw, mode);
    final deck = Deck.shuffled(seed);
    final now = _now;
    final snap = GameSnapshot(
      gameId: _newId(),
      seed: seed,
      mode: mode,
      config: config,
      deckOrder: [for (final c in deck) c.id],
      state: KlondikeEngine.deal(deck, config),
      history: const [],
      elapsedMs: 0,
      startedAt: now,
      updatedAt: now,
      dailyDate: mode == GameMode.daily
          ? DailyChallenge.keyFor(dailyDate ?? now)
          : null,
    );
    _clock.reset();
    state = GameViewState(snapshot: snap);
    ref.read(analyticsProvider).logEvent('game_start', {
      'mode': mode.name,
      'draw': draw,
    });
    _audio.play(Sfx.draw);
    await _save();
  }

  /// Counts an unfinished game with at least one move as a loss (once).
  Future<void> _abandonCurrent() async {
    final s = state.snapshot;
    if (s == null || s.finished || !s.hasProgress) return;
    _clock.pause();
    await ref
        .read(profileProvider.notifier)
        .recordGame(
          GameResult(
            gameId: s.gameId,
            drawCount: s.config.drawCount,
            won: false,
            elapsedMs: _clock.elapsedMs,
            moves: s.state.moves,
            hintsUsed: s.hintsUsed,
            undosUsed: s.undosUsed,
            maxCombo: s.maxCombo,
          ),
        );
  }

  /// Replays the exact same initial deal (same game id: results are still
  /// recorded at most once).
  Future<void> restart() async {
    final s = state.snapshot;
    if (s == null) return;
    _cancelAuto = true;
    final fresh = KlondikeEngine.deal(s.deck, s.config);
    _clock.reset();
    state = GameViewState(
      snapshot: GameSnapshot(
        gameId: s.gameId,
        seed: s.seed,
        mode: s.mode,
        config: s.config,
        deckOrder: s.deckOrder,
        state: fresh,
        history: const [],
        elapsedMs: 0,
        startedAt: s.startedAt,
        updatedAt: _now,
        dailyDate: s.dailyDate,
        restarts: s.restarts + 1,
      ),
    );
    await _save();
  }

  // ---------------------------------------------------------------- moves

  bool get _locked {
    final s = state.snapshot;
    return s == null || s.finished || state.autoFinishing;
  }

  Future<void> tapStock() async {
    if (_locked) return;
    final b = state.snapshot!.state;
    if (b.stock.isNotEmpty) {
      await _apply(const DrawMove());
    } else if (b.canRecycle) {
      await _apply(const RecycleMove());
    } else {
      _invalid(PileRef.stock);
    }
  }

  /// Tap on card [index] of [pile]: auto-move it (and cards above it).
  Future<bool> tapCard(PileRef pile, int index) async {
    if (_locked) return false;
    final b = state.snapshot!.state;
    if (pile.isStock) {
      await tapStock();
      return true;
    }
    final len = b.pileLength(pile);
    if (index < 0 || index >= len) return false;
    if (pile.isWaste && index != len - 1) return false;
    if (pile.isFoundation && index != len - 1) return false;
    if (pile.isTableau && !b.tableau[pile.index][index].faceUp) {
      _invalid(pile);
      return false;
    }
    final move = MoveAdvisor.tapMove(
      b,
      pile,
      len - index,
      preferFoundation: _settings.tapToFoundation,
    );
    if (move == null) {
      _invalid(pile);
      return false;
    }
    await _apply(move);
    return true;
  }

  /// Drag & drop. Returns false (board snaps back) if illegal.
  Future<bool> drop(PileRef from, int count, PileRef to) async {
    if (_locked) return false;
    final b = state.snapshot!.state;
    var target = to;
    // Any foundation slot accepts a single card for its own suit.
    if (to.isFoundation && count == 1) {
      final card = _topCard(b, from);
      if (card != null) target = PileRef.foundation(card.suit.index);
    }
    final move = TransferMove(from, target, count);
    if (!KlondikeEngine.isLegal(b, move)) {
      _invalid(from);
      return false;
    }
    await _apply(move);
    return true;
  }

  /// Destination piles that would accept the dragged cards (highlighting).
  List<PileRef> legalTargets(PileRef from, int count) {
    final b = state.snapshot?.state;
    if (b == null) return const [];
    final out = <PileRef>[];
    if (count == 1) {
      final card = _topCard(b, from);
      if (card != null) {
        final f = PileRef.foundation(card.suit.index);
        if (KlondikeEngine.isLegal(b, TransferMove(from, f))) out.add(f);
      }
    }
    for (var c = 0; c < 7; c++) {
      final to = PileRef.tableau(c);
      if (KlondikeEngine.isLegal(b, TransferMove(from, to, count))) out.add(to);
    }
    return out;
  }

  /// Whether the card at [index] of [pile] may start a drag.
  bool canDrag(PileRef pile, int index) {
    final b = state.snapshot?.state;
    if (b == null || _locked) return false;
    final len = b.pileLength(pile);
    if (index < 0 || index >= len) return false;
    return switch (pile.kind) {
      PileKind.waste => index == len - 1,
      PileKind.foundation =>
        index == len - 1 && b.config.allowFoundationToTableau,
      PileKind.tableau => KlondikeRules.isMovableRun(
        b.tableau[pile.index],
        index,
      ),
      PileKind.stock => false,
    };
  }

  PlayingCard? _topCard(GameState b, PileRef p) => switch (p.kind) {
    PileKind.waste => b.wasteTop,
    PileKind.foundation => b.foundationTop(p.index),
    PileKind.tableau =>
      b.tableau[p.index].isEmpty ? null : b.tableau[p.index].last.card,
    PileKind.stock => null,
  };

  void _invalid(PileRef pile) {
    state = state.copyWith(invalid: Signal(pile, ++_serial));
    _audio.play(Sfx.invalid);
    _audio.haptic(HapticKind.error);
  }

  Future<void> _apply(Move move, {bool auto = false}) async {
    final s = state.snapshot!;
    final MoveResult r;
    try {
      r = KlondikeEngine.apply(s.state, move);
    } on IllegalMoveException catch (e) {
      AppLogger.w('game.illegal_move', {'error': e.error.name});
      return;
    }
    _clock.start();
    final productive =
        move is TransferMove &&
        (move.to.isFoundation || r.record.flippedSourceCard);
    final resetsCombo = move is DrawMove || move is RecycleMove;
    final combo = productive ? s.combo + 1 : (resetsCombo ? 0 : s.combo);
    final next = s.copyWith(
      state: r.state,
      history: [...s.history, r.record],
      combo: combo,
      maxCombo: max(s.maxCombo, combo),
      usedAutoFinish: s.usedAutoFinish || auto,
      elapsedMs: _clock.elapsedMs,
      updatedAt: _now,
    );
    state = state.copyWith(
      snapshot: next,
      canAutoFinish: !r.state.isWon && MoveAdvisor.canAutoFinish(r.state),
      comboSignal: productive && combo >= 3 ? Signal(combo, ++_serial) : null,
    );
    _feedback(move, r.record);
    if (r.state.isWon) {
      await _onWin();
    } else {
      await _save();
    }
  }

  void _feedback(Move move, MoveRecord rec) {
    switch (move) {
      case DrawMove():
      case RecycleMove():
        _audio.play(Sfx.draw);
      case TransferMove(:final to):
        _audio.play(to.isFoundation ? Sfx.foundation : Sfx.place);
        if (rec.flippedSourceCard) _audio.play(Sfx.flip);
    }
    _audio.haptic(HapticKind.light);
  }

  Future<void> undo() async {
    if (_locked) return;
    final s = state.snapshot!;
    if (s.history.isEmpty) return;
    final rec = s.history.last;
    final prev = KlondikeEngine.undo(s.state, rec);
    state = state.copyWith(
      snapshot: s.copyWith(
        state: prev,
        history: s.history.sublist(0, s.history.length - 1),
        undosUsed: s.undosUsed + 1,
        combo: 0,
        elapsedMs: _clock.elapsedMs,
        updatedAt: _now,
      ),
      canAutoFinish: MoveAdvisor.canAutoFinish(prev),
    );
    _audio.play(Sfx.place);
    await _save();
  }

  /// Shows a hint, consuming one hint token.
  Future<HintResult> requestHint() async {
    if (_locked) return HintResult.noMoves;
    if (!_settings.hintsEnabled) return HintResult.disabled;
    final s = state.snapshot!;
    final move = MoveAdvisor.hint(s.state);
    if (move == null) return HintResult.noMoves;
    final profile = ref.read(profileProvider);
    if (profile.hintTokens <= 0) return HintResult.noTokens;
    await ref.read(profileProvider.notifier).consumeHint();
    state = state.copyWith(
      hint: Signal(move, ++_serial),
      snapshot: s.copyWith(hintsUsed: s.hintsUsed + 1),
    );
    await _save();
    return HintResult.shown;
  }

  bool get hasUsefulMove {
    final b = state.snapshot?.state;
    return b != null && !MoveAdvisor.isStuck(b);
  }

  /// Plays the auto-finish plan step by step. [stepDelay] keeps it watchable;
  /// [skip] applies all remaining moves at once. Every step is a validated
  /// engine move, so cancelling mid-way leaves a consistent board.
  Future<void> autoFinish({Duration? stepDelay}) async {
    if (_locked || !state.canAutoFinish) return;
    final plan = MoveAdvisor.autoFinishPlan(state.snapshot!.state);
    if (plan == null) return;
    _cancelAuto = false;
    _skipAuto = false;
    state = state.copyWith(autoFinishing: true);
    final delay =
        stepDelay ??
        (_settings.reducedMotion
            ? const Duration(milliseconds: 40)
            : const Duration(milliseconds: 110));
    for (final m in plan) {
      if (_cancelAuto) break;
      if (!_skipAuto && delay > Duration.zero) {
        await Future<void>.delayed(delay);
        if (_cancelAuto) break;
      }
      final snap = state.snapshot;
      if (snap == null || snap.finished) break;
      state = state.copyWith(autoFinishing: false);
      await _apply(m, auto: true);
      if (state.snapshot?.finished ?? true) break;
      state = state.copyWith(autoFinishing: true);
    }
    state = state.copyWith(autoFinishing: false);
  }

  bool _skipAuto = false;
  void skipAutoFinish() => _skipAuto = true;
  void cancelAutoFinish() => _cancelAuto = true;

  // ------------------------------------------------------------- shuffle

  static const int maxShuffles = 3;

  int get shufflesLeft =>
      maxShuffles - (state.snapshot?.shufflesUsed ?? maxShuffles);

  bool get canShuffle =>
      !_locked &&
      shufflesLeft > 0 &&
      KlondikeEngine.shufflableCount(state.snapshot!.state) >= 2;

  /// Pays [ProfileData.shufflePrice] coins and shuffles.
  Future<ShuffleResult> shuffleWithCoins() async {
    if (_locked) return ShuffleResult.unavailable;
    if (shufflesLeft <= 0) return ShuffleResult.limitReached;
    if (!canShuffle) return ShuffleResult.unavailable;
    final s = state.snapshot!;
    if (ref.read(profileProvider).coins < ProfileData.shufflePrice) {
      return ShuffleResult.insufficientCoins;
    }
    await ref
        .read(profileProvider.notifier)
        .payShuffle('${s.gameId}:${s.shufflesUsed}');
    await _applyShuffle();
    return ShuffleResult.done;
  }

  /// Opt-in rewarded ad instead of coins; shuffles only after the SDK's
  /// earned-reward callback, once per reward event.
  Future<RewardOutcome> shuffleWithAd() async {
    if (!canShuffle) {
      return const RewardUnavailable(AdUnavailableReason.disabled);
    }
    _clock.pause();
    final outcome = await ref
        .read(adServiceProvider)
        .showRewarded(RewardPlacement.shuffle);
    if (outcome is RewardEarned) {
      final fresh = await ref
          .read(profileProvider.notifier)
          .redeemAdShuffle(outcome.rewardEventId);
      if (fresh && canShuffle) await _applyShuffle();
    }
    return outcome;
  }

  Future<void> _applyShuffle() async {
    final s = state.snapshot!;
    final seed = Deck.fnv1a('${s.seed}:${s.gameId}:${s.shufflesUsed}');
    final next = KlondikeEngine.reshuffle(s.state, seed);
    _clock.start();
    state = state.copyWith(
      snapshot: s.copyWith(
        state: next,
        // A shuffle is a new starting point: earlier moves can't be undone.
        history: const [],
        shufflesUsed: s.shufflesUsed + 1,
        combo: 0,
        elapsedMs: _clock.elapsedMs,
        updatedAt: _now,
      ),
      canAutoFinish: MoveAdvisor.canAutoFinish(next),
    );
    _audio.play(Sfx.draw);
    _audio.haptic(HapticKind.success);
    ref.read(analyticsProvider).logEvent('shuffle_used', {
      'n': s.shufflesUsed + 1,
    });
    await _save();
  }

  // ------------------------------------------------------------- victory

  Future<void> _onWin() async {
    _clock.pause();
    final s = state.snapshot!.copyWith(
      finished: true,
      elapsedMs: _clock.elapsedMs,
      updatedAt: _now,
    );
    state = state.copyWith(snapshot: s, autoFinishing: false);
    await _save(); // finished flag persisted before rewards are computed
    await _recordWin(s);
  }

  Future<void> _recordWin(GameSnapshot s) async {
    final elapsed = Duration(milliseconds: s.elapsedMs);
    final bonus = Scoring.timeBonus(elapsed);
    final finalScore = s.state.score + bonus;
    final before = ref.read(profileProvider).stats.total.bestScore;
    final outcome = await ref
        .read(profileProvider.notifier)
        .recordGame(
          GameResult(
            gameId: s.gameId,
            drawCount: s.config.drawCount,
            won: true,
            score: finalScore,
            elapsedMs: s.elapsedMs,
            moves: s.state.moves,
            hintsUsed: s.hintsUsed,
            undosUsed: s.undosUsed,
            maxCombo: s.maxCombo,
            usedAutoFinish: s.usedAutoFinish,
            winningDeal: s.mode != GameMode.random,
            dailyDate: s.dailyDate,
            seed: s.seed,
            firstAttempt: s.restarts == 0,
            shufflesUsed: s.shufflesUsed,
          ),
        );
    ref.read(adServiceProvider).onGameFinished();
    ref.read(analyticsProvider).logEvent('game_won', {
      'mode': s.mode.name,
      'draw': s.config.drawCount,
    });
    _audio.play(Sfx.victory);
    _audio.haptic(HapticKind.success);
    state = state.copyWith(
      victory: () => VictoryReport(
        gameId: s.gameId,
        mode: s.mode,
        drawCount: s.config.drawCount,
        baseScore: s.state.score,
        timeBonus: bonus,
        finalScore: finalScore,
        elapsedMs: s.elapsedMs,
        moves: s.state.moves,
        maxCombo: s.maxCombo,
        coinsEarned: outcome.alreadyRecorded ? 0 : outcome.coinsEarned,
        bestScore: max(before, finalScore),
        newRecord: outcome.newBestScore,
        newAchievements: outcome.newAchievements,
        achievementCoins: outcome.achievementCoins,
        dailyRewarded: outcome.dailyRewarded,
        speedBonus: outcome.alreadyRecorded ? 0 : outcome.speedBonus,
      ),
    );
  }

  /// Opt-in rewarded ad to double the coins of a won game (once per game).
  Future<RewardOutcome> doubleVictoryCoins() async {
    final v = state.victory;
    if (v == null || v.coinsEarned <= 0) {
      return const RewardUnavailable(AdUnavailableReason.disabled);
    }
    final profile = ref.read(profileProvider);
    if (profile.hasGrant('double:${v.gameId}')) {
      return const RewardUnavailable(AdUnavailableReason.disabled);
    }
    _clock.pause();
    final outcome = await ref
        .read(adServiceProvider)
        .showRewarded(RewardPlacement.doubleVictoryCoins);
    if (outcome is RewardEarned) {
      await ref
          .read(profileProvider.notifier)
          .doubleWinCoins(v.gameId, v.coinsEarned);
      _audio.play(Sfx.coins);
    }
    return outcome;
  }

  /// Opt-in rewarded ad for a hint pack.
  Future<RewardOutcome> rewardedHints() async {
    _clock.pause();
    final outcome = await ref
        .read(adServiceProvider)
        .showRewarded(RewardPlacement.hintPack);
    if (outcome is RewardEarned) {
      await ref
          .read(profileProvider.notifier)
          .grantRewardedHints(outcome.rewardEventId);
    }
    return outcome;
  }

  void clearVictory() => state = state.copyWith(victory: () => null);

  // ---------------------------------------------------------- persistence

  Future<void> _save() async {
    final s = state.snapshot;
    if (s == null) return;
    final withTime = s.copyWith(elapsedMs: _clock.elapsedMs);
    state = state.copyWith(snapshot: withTime);
    try {
      await ref.read(gameRepositoryProvider).save(withTime);
    } catch (e, st) {
      ref.read(crashReporterProvider).recordError(e, st);
    }
  }

  Future<void> deleteAll() async {
    _cancelAuto = true;
    _clock.reset();
    await ref.read(gameRepositoryProvider).clear();
    state = const GameViewState();
  }
}

final gameControllerProvider = NotifierProvider<GameController, GameViewState>(
  GameController.new,
);
