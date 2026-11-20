import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../../app/theme/tokens.dart';
import '../../../core/ads/ad_service.dart';
import '../../../core/providers.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/widgets/nova_dialogs.dart';
import '../../../shared/widgets/nova_widgets.dart';
import '../../settings/application/settings_controller.dart';
import '../../statistics/application/profile_controller.dart';
import '../application/game_controller.dart';
import '../domain/models/card.dart';
import '../domain/models/game_mode.dart';
import '../domain/models/game_state.dart';
import '../domain/models/pile_ref.dart';
import '../domain/rules/klondike_rules.dart';
import '../flame/board_layout.dart';
import '../flame/solitaire_board_game.dart';
import 'card_art/card_styles.dart';
import 'top_banner.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});
  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _ControllerDelegate implements BoardDelegate {
  _ControllerDelegate(this.ref);
  final WidgetRef ref;
  GameController get _c => ref.read(gameControllerProvider.notifier);
  @override
  bool canDrag(PileRef pile, int index) => _c.canDrag(pile, index);
  @override
  List<PileRef> legalTargets(PileRef from, int count) =>
      _c.legalTargets(from, count);
  @override
  Future<bool> drop(PileRef from, int count, PileRef to) =>
      _c.drop(from, count, to);
  @override
  Future<bool> tapCard(PileRef pile, int index) => _c.tapCard(pile, index);
  @override
  Future<void> tapStock() => _c.tapStock();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late final SolitaireBoardGame _game;
  late final AppLifecycleListener _lifecycle;
  bool _navigatingToVictory = false;
  static const _bannerPolicy = BannerPolicy();
  String? _bannerShownForGame;
  int? _combo;
  Timer? _comboTimer;

  late final GameController _ctrl;

  BoardVisuals _visuals() {
    final s = ref.read(settingsProvider);
    final p = ref.read(profileProvider);
    return BoardVisuals(
      cardStyle: CardStyle.byId(p.equipped.cards),
      tableStyle: TableStyle.byId(p.equipped.table),
      leftHanded: s.leftHanded,
      reducedMotion:
          s.reducedMotion ||
          WidgetsBinding
              .instance
              .platformDispatcher
              .accessibilityFeatures
              .disableAnimations,
    );
  }

  @override
  void initState() {
    super.initState();
    _ctrl = ref.read(gameControllerProvider.notifier);
    _game = SolitaireBoardGame(
      delegate: _ControllerDelegate(ref),
      visuals: _visuals(),
    );
    final st = ref.read(gameControllerProvider);
    final board = st.board;
    if (board != null) {
      _game.sync(board, deal: board.moves == 0 && !st.snapshot!.hasProgress);
      if (st.snapshot!.hasProgress) _ctrl.resumeClock();
    }
    _lifecycle = AppLifecycleListener(
      onHide: () => _ctrl.pauseAndSave(),
      onPause: () => _ctrl.pauseAndSave(),
      onShow: () {
        if (mounted &&
            (ModalRoute.of(context)?.isCurrent ?? false) &&
            ref.read(gameControllerProvider).snapshot?.hasProgress == true) {
          _ctrl.resumeClock();
        }
      },
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    _comboTimer?.cancel();
    // Never mutate providers while the tree is being torn down: stop the
    // clock now, persist on the next microtask.
    final ctrl = _ctrl..pauseClock();
    Future.microtask(ctrl.pauseAndSave);
    super.dispose();
  }

  void _onState(GameViewState? prev, GameViewState next) {
    final b = next.board;
    if (b != null && !identical(prev?.board, b)) {
      final newGame =
          prev?.snapshot?.gameId != next.snapshot?.gameId ||
          ((prev?.snapshot?.hasProgress ?? false) &&
              !next.snapshot!.hasProgress &&
              b.moves == 0);
      _game.sync(b, deal: newGame);
    }
    if (next.hint != null && next.hint!.serial != prev?.hint?.serial) {
      _game.showHint(next.hint!.value);
    }
    if (next.invalid != null && next.invalid!.serial != prev?.invalid?.serial) {
      _game.shake(next.invalid!.value);
    }
    if (next.comboSignal != null &&
        next.comboSignal!.serial != prev?.comboSignal?.serial) {
      setState(() => _combo = next.comboSignal!.value);
      _comboTimer?.cancel();
      _comboTimer = Timer(const Duration(milliseconds: 1100), () {
        if (mounted) setState(() => _combo = null);
      });
    }
    if (next.victory != null &&
        prev?.victory == null &&
        !_navigatingToVictory) {
      _navigatingToVictory = true;
      final reduce = _visuals().reducedMotion;
      Future.delayed(Duration(milliseconds: reduce ? 250 : 900), () {
        if (mounted) context.pushReplacement(Routes.victory);
      });
    }
  }

  Future<T?> _withPausedClock<T>(Future<T?> Function() body) async {
    await _ctrl.pauseAndSave();
    final r = await body();
    if (mounted &&
        ref.read(gameControllerProvider).snapshot?.hasProgress == true) {
      _ctrl.resumeClock();
    }
    return r;
  }

  Future<void> _confirmNewGame() async {
    final l = context.l10n;
    final snap = ref.read(gameControllerProvider).snapshot;
    final ok = snap == null || !snap.hasProgress || snap.finished
        ? true
        : await _withPausedClock(
            () => showConfirmDialog(
              context,
              title: l.newGameTitle,
              body: l.newGameBody,
            ),
          );
    if (ok == true) {
      // Same deal type and draw mode as the current game (a daily challenge
      // continues with a random deal).
      final mode = snap == null || snap.mode == GameMode.daily
          ? GameMode.random
          : snap.mode;
      await _ctrl.startNewGame(mode: mode, drawCount: snap?.config.drawCount);
    }
  }

  Future<void> _confirmRestart() async {
    final l = context.l10n;
    final ok = await _withPausedClock(
      () => showConfirmDialog(
        context,
        title: l.restartTitle,
        body: l.restartBody,
      ),
    );
    if (ok == true) await _ctrl.restart();
  }

  Future<void> _pauseMenu() async {
    final l = context.l10n;
    final choice = await _withPausedClock(
      () => showDialog<String>(
        context: context,
        builder: (c) => SimpleDialog(
          title: Text(l.pauseTitle, textAlign: TextAlign.center),
          contentPadding: const EdgeInsets.all(NovaSpace.lg),
          children: [
            GoldButton(
              label: l.resume,
              icon: Icons.play_arrow_rounded,
              height: 50,
              onPressed: () => Navigator.pop(c, 'resume'),
            ),
            const SizedBox(height: NovaSpace.md),
            PanelButton(
              label: l.restartDeal,
              icon: Icons.replay_rounded,
              onPressed: () => Navigator.pop(c, 'restart'),
            ),
            const SizedBox(height: NovaSpace.md),
            PanelButton(
              label: l.newGame,
              icon: Icons.add_circle_outline_rounded,
              onPressed: () => Navigator.pop(c, 'new'),
            ),
            const SizedBox(height: NovaSpace.md),
            PanelButton(
              label: l.howToPlay,
              icon: Icons.menu_book_rounded,
              onPressed: () => Navigator.pop(c, 'rules'),
            ),
            const SizedBox(height: NovaSpace.md),
            PanelButton(
              label: l.settings,
              icon: Icons.settings_rounded,
              onPressed: () => Navigator.pop(c, 'settings'),
            ),
            const SizedBox(height: NovaSpace.md),
            PanelButton(
              label: l.home,
              icon: Icons.home_rounded,
              onPressed: () => Navigator.pop(c, 'home'),
            ),
          ],
        ),
      ),
    );
    if (!mounted) return;
    switch (choice) {
      case 'restart':
        await _confirmRestart();
      case 'new':
        await _confirmNewGame();
      case 'rules':
        await _withPausedClock(() => showHowToPlay(context));
      case 'settings':
        await _ctrl.pauseAndSave();
        if (mounted) await context.push(Routes.settings);
        if (mounted) _game.updateVisuals(_visuals());
      case 'home':
        await _ctrl.pauseAndSave();
        if (mounted) context.go(Routes.home);
    }
  }

  Future<void> _hint() async {
    final l = context.l10n;
    final r = await _ctrl.requestHint();
    if (!mounted) return;
    switch (r) {
      case HintResult.shown:
        break;
      case HintResult.disabled:
        showNovaSnack(context, l.hintsDisabled, icon: Icons.lightbulb_outline);
      case HintResult.noMoves:
        await _noMovesDialog();
      case HintResult.noTokens:
        await _noTokensDialog();
    }
  }

  Future<void> _noMovesDialog() async {
    final l = context.l10n;
    final choice = await _withPausedClock(
      () => showDialog<String>(
        context: context,
        builder: (c) => AlertDialog(
          icon: const Icon(
            Icons.search_off_rounded,
            color: NovaColors.goldLight,
            size: 36,
          ),
          title: Text(l.noMovesTitle),
          content: Text(l.noMovesBody),
          actionsOverflowDirection: VerticalDirection.down,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, 'undo'),
              child: Text(l.actionUndo),
            ),
            TextButton(
              onPressed: () => Navigator.pop(c, 'restart'),
              child: Text(l.restartDeal),
            ),
            TextButton(
              onPressed: () => Navigator.pop(c, 'new'),
              child: Text(l.newGame),
            ),
            TextButton(onPressed: () => Navigator.pop(c), child: Text(l.close)),
          ],
        ),
      ),
    );
    switch (choice) {
      case 'undo':
        await _ctrl.undo();
      case 'restart':
        await _ctrl.restart();
      case 'new':
        await _confirmNewGame();
    }
  }

  Future<void> _noTokensDialog() async {
    final l = context.l10n;
    final ads = ref.read(adServiceProvider);
    final choice = await _withPausedClock(
      () => showDialog<String>(
        context: context,
        builder: (c) => AlertDialog(
          icon: const Icon(
            Icons.lightbulb_outline_rounded,
            color: NovaColors.goldLight,
            size: 36,
          ),
          title: Text(l.noHintsTitle),
          content: Text(l.noHintsBody),
          actionsOverflowDirection: VerticalDirection.down,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c),
              child: Text(l.cancel),
            ),
            if (ads.rewardedAvailable)
              TextButton(
                onPressed: () => Navigator.pop(c, 'ad'),
                child: Text(l.watchAdHints(ProfileData.rewardedHintCount)),
              ),
            TextButton(
              onPressed: () => Navigator.pop(c, 'buy'),
              child: Text(
                l.buyHints(ProfileData.hintPackSize, ProfileData.hintPackPrice),
              ),
            ),
          ],
        ),
      ),
    );
    if (!mounted) return;
    if (choice == 'buy') {
      final p = ref.read(profileProvider);
      if (p.coins < ProfileData.hintPackPrice) {
        await showInsufficientCoinsDialog(
          context,
          ProfileData.hintPackPrice - p.coins,
        );
        return;
      }
      await ref
          .read(profileProvider.notifier)
          .buyHintPack(DateTime.now().microsecondsSinceEpoch.toString());
      if (mounted) {
        showNovaSnack(
          context,
          l.hintsOwned(ref.read(profileProvider).hintTokens),
          icon: Icons.lightbulb,
        );
      }
    } else if (choice == 'ad') {
      final r = await _ctrl.rewardedHints();
      if (!mounted) return;
      switch (r) {
        case RewardEarned():
          showNovaSnack(
            context,
            l.hintsOwned(ref.read(profileProvider).hintTokens),
            icon: Icons.lightbulb,
          );
        case RewardSkipped():
          showNovaSnack(context, l.adNotCompleted);
        case RewardUnavailable(:final reason):
          if (reason == AdUnavailableReason.offline) {
            await showOfflineDialog(context);
          } else {
            await showAdUnavailableDialog(context);
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(gameControllerProvider, _onState);
    ref.listen(settingsProvider, (_, _) => _game.updateVisuals(_visuals()));
    ref.listen(
      profileProvider.select((p) => p.equipped),
      (_, _) => _game.updateVisuals(_visuals()),
    );
    final l = context.l10n;
    final st = ref.watch(gameControllerProvider);
    final snap = st.snapshot;
    final table = TableStyle.byId(
      ref.watch(profileProvider.select((p) => p.equipped.table)),
    );

    if (snap == null) {
      // No game (e.g. after deleting data): offer to start one.
      return NovaScaffold(
        title: l.playClassic,
        onBack: () => context.go(Routes.home),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(NovaSpace.xl),
            child: GoldButton(
              label: l.newGame,
              onPressed: () => _ctrl.startNewGame(),
            ),
          ),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _pauseMenu();
      },
      child: Scaffold(
        backgroundColor: table.edge,
        body: SafeArea(
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  final show = _bannerPolicy.shouldShow(
                    movesPlayed: snap.state.moves,
                    alreadyShownThisGame: _bannerShownForGame == snap.gameId,
                    gameFinished: snap.finished,
                  );
                  if (show) _bannerShownForGame = snap.gameId;
                  return TopBanner(
                    visible: show,
                    canInsert: () => !_game.isDragging,
                  );
                },
              ),
              _Hud(onPause: _pauseMenu),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, box) => Stack(
                    children: [
                      Positioned.fill(child: GameWidget(game: _game)),
                      Positioned.fill(
                        child: _BoardSemantics(
                          size: box.biggest,
                          state: snap.state,
                          leftHanded: ref.watch(
                            settingsProvider.select((s) => s.leftHanded),
                          ),
                        ),
                      ),
                      if (_combo != null)
                        Positioned(
                          top: box.maxHeight * 0.42,
                          left: 0,
                          right: 0,
                          child: IgnorePointer(
                            child: Center(
                              child: Text(
                                '${_combo}x',
                                style: const TextStyle(
                                  fontFamily: NovaFonts.display,
                                  fontSize: 46,
                                  fontWeight: FontWeight.w700,
                                  color: NovaColors.goldLight,
                                  shadows: [
                                    Shadow(color: Colors.black, blurRadius: 12),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (st.autoFinishing)
                        Positioned(
                          left: NovaSpace.lg,
                          right: NovaSpace.lg,
                          bottom: NovaSpace.lg,
                          child: NovaPanel(
                            padding: const EdgeInsets.symmetric(
                              horizontal: NovaSpace.lg,
                              vertical: NovaSpace.sm,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.auto_fix_high_rounded,
                                  color: NovaColors.goldLight,
                                ),
                                const SizedBox(width: NovaSpace.sm),
                                Expanded(child: Text(l.autoFinishing)),
                                TextButton(
                                  onPressed: _ctrl.skipAutoFinish,
                                  child: Text(l.skip),
                                ),
                                TextButton(
                                  onPressed: _ctrl.cancelAutoFinish,
                                  child: Text(l.cancel),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              _ActionBar(
                canUndo:
                    snap.history.isNotEmpty &&
                    !snap.finished &&
                    !st.autoFinishing,
                canAuto: st.canAutoFinish && !st.autoFinishing,
                hintsEnabled: ref.watch(
                  settingsProvider.select((s) => s.hintsEnabled),
                ),
                hintTokens: ref.watch(
                  profileProvider.select((p) => p.hintTokens),
                ),
                onUndo: _ctrl.undo,
                onHint: _hint,
                onAuto: () => _ctrl.autoFinish(),
                onNew: _confirmNewGame,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Score / time / moves. Rebuilds itself every second for the clock only.
class _Hud extends ConsumerStatefulWidget {
  const _Hud({required this.onPause});
  final VoidCallback onPause;
  @override
  ConsumerState<_Hud> createState() => _HudState();
}

class _HudState extends ConsumerState<_Hud> {
  Timer? _t;
  @override
  void initState() {
    super.initState();
    _t = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && ref.read(gameControllerProvider.notifier).clockRunning) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final st = ref.watch(gameControllerProvider);
    final b = st.board;
    final showTimer = ref.watch(settingsProvider.select((s) => s.showTimer));
    final elapsed = ref.read(gameControllerProvider.notifier).elapsedMs;
    Widget cell(String label, String value) => Expanded(
      child: MergeSemantics(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: NovaColors.textSecondary,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: NovaColors.ivory,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 4, NovaSpace.md, 6),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0B231F), Color(0xE60B231F)],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: l.actionPause,
            onPressed: widget.onPause,
            icon: const Icon(Icons.pause_circle_outline_rounded, size: 30),
          ),
          cell(l.hudScore, '${b?.score ?? 0}'),
          if (showTimer) cell(l.hudTime, formatClock(elapsed)),
          cell(l.hudMoves, '${b?.moves ?? 0}'),
        ],
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.canUndo,
    required this.canAuto,
    required this.hintsEnabled,
    required this.hintTokens,
    required this.onUndo,
    required this.onHint,
    required this.onAuto,
    required this.onNew,
  });

  final bool canUndo, canAuto, hintsEnabled;
  final int hintTokens;
  final VoidCallback onUndo, onHint, onAuto, onNew;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    Widget action(
      IconData icon,
      String label,
      VoidCallback? onTap, {
      Widget? badge,
      String? semantics,
    }) => Expanded(
      child: Semantics(
        button: true,
        enabled: onTap != null,
        label: semantics ?? label,
        excludeSemantics: true,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(NovaRadius.md),
          child: Opacity(
            opacity: onTap == null ? 0.4 : 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(icon, color: NovaColors.ivory, size: 28),
                      if (badge != null)
                        Positioned(right: -14, top: -8, child: badge),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: NovaColors.ivory,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return Container(
      margin: const EdgeInsets.fromLTRB(
        NovaSpace.sm,
        4,
        NovaSpace.sm,
        NovaSpace.sm,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xEE0B231F),
        borderRadius: BorderRadius.circular(NovaRadius.lg),
        border: Border.all(color: NovaColors.gold.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          action(Icons.undo_rounded, l.actionUndo, canUndo ? onUndo : null),
          action(
            Icons.lightbulb_outline_rounded,
            l.actionHint,
            hintsEnabled ? onHint : null,
            semantics: '${l.actionHint}, ${l.hintsLeft(hintTokens)}',
            badge: hintsEnabled
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      gradient: NovaColors.goldGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$hintTokens',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: NovaColors.navy,
                      ),
                    ),
                  )
                : null,
          ),
          action(
            Icons.auto_fix_high_rounded,
            l.actionAuto,
            canAuto ? onAuto : null,
          ),
          action(Icons.add_circle_outline_rounded, l.actionNew, onNew),
        ],
      ),
    );
  }
}

/// Invisible semantics nodes over each pile so TalkBack / VoiceOver users
/// can play with tap-to-move (Flame's canvas has no semantics of its own).
class _BoardSemantics extends ConsumerWidget {
  const _BoardSemantics({
    required this.size,
    required this.state,
    required this.leftHanded,
  });
  final Size size;
  final GameState state;
  final bool leftHanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final layout = BoardLayout.compute(size, state, leftHanded: leftHanded);
    final ctrl = ref.read(gameControllerProvider.notifier);
    final nodes = <Widget>[];
    for (final e in layout.slots.entries) {
      final pile = e.key;
      final r = pile.isTableau
          ? layout.dropZone(pile, state).deflate(layout.cardSize.width * 0.12)
          : e.value;
      String label;
      VoidCallback? onTap;
      switch (pile.kind) {
        case PileKind.stock:
          label = state.stock.isNotEmpty
              ? l.semStock(state.stock.length)
              : (state.canRecycle ? l.semStockRecycle : l.semStockEmpty);
          onTap = ctrl.tapStock;
        case PileKind.waste:
          final top = state.wasteTop;
          label = top == null
              ? l.semWaste
              : '${l.semWaste}: ${cardLabel(l, top)}';
          if (top != null) {
            onTap = () => ctrl.tapCard(pile, state.waste.length - 1);
          }
        case PileKind.foundation:
          final f = state.foundations[pile.index];
          label = l.semFoundation(
            suitName(l, Suit.values[pile.index]),
            f.length,
          );
          if (f.isNotEmpty) {
            label = '$label: ${cardLabel(l, f.last)}';
            onTap = () => ctrl.tapCard(pile, f.length - 1);
          }
        case PileKind.tableau:
          final col = state.tableau[pile.index];
          if (col.isEmpty) {
            label = l.semEmptyColumn(pile.index + 1);
          } else {
            final first = KlondikeRules.firstFaceUpIndex(col);
            final faceUp = [
              for (final t in col.sublist(first)) cardLabel(l, t.card),
            ];
            final down = first;
            label = [
              if (down > 0) '$down × ${l.semFaceDown}',
              ...faceUp,
            ].join(', ');
            onTap = () => ctrl.tapCard(pile, first);
          }
      }
      nodes.add(
        Positioned.fromRect(
          rect: r,
          child: Semantics(
            container: true,
            button: onTap != null,
            label: label,
            onTap: onTap,
            child: const SizedBox.expand(),
          ),
        ),
      );
    }
    return IgnorePointer(child: Stack(children: nodes));
  }
}
