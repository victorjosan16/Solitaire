import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/animation.dart';

import '../domain/models/card.dart';
import '../domain/models/game_state.dart';
import '../domain/models/move.dart';
import '../domain/models/pile_ref.dart';
import '../presentation/card_art/card_painter.dart';
import '../presentation/card_art/card_styles.dart';
import 'board_layout.dart';

/// The board talks to the application layer only through this interface;
/// it contains no game rules of its own.
abstract class BoardDelegate {
  bool canDrag(PileRef pile, int index);
  List<PileRef> legalTargets(PileRef from, int count);
  Future<bool> drop(PileRef from, int count, PileRef to);
  Future<bool> tapCard(PileRef pile, int index);
  Future<void> tapStock();
}

class BoardVisuals {
  const BoardVisuals({
    this.cardStyle = CardStyle.classic,
    this.tableStyle = TableStyle.emerald,
    this.leftHanded = false,
    this.reducedMotion = false,
  });
  final CardStyle cardStyle;
  final TableStyle tableStyle;
  final bool leftHanded;
  final bool reducedMotion;
}

/// Flame renderer + gesture front-end for the Klondike board.
class SolitaireBoardGame extends FlameGame {
  SolitaireBoardGame({
    required this.delegate,
    this._visuals = const BoardVisuals(),
  });

  final BoardDelegate delegate;
  BoardVisuals _visuals;
  BoardVisuals get visuals => _visuals;

  GameState? _state;
  BoardLayout? layout;
  final Map<int, CardComponent> _cards = {};
  final Map<PileRef, SlotComponent> _slots = {};
  _Drag? _drag;
  bool _loaded = false;
  GameState? _pending;
  bool _pendingDeal = false;

  static const moveDuration = 0.18;
  static const flipDuration = 0.16;

  @override
  ui.Color backgroundColor() => const ui.Color(0x00000000);

  @override
  Future<void> onLoad() async {
    add(TableComponent()..priority = -1000);
    for (final p in [
      PileRef.stock,
      PileRef.waste,
      for (var i = 0; i < 4; i++) PileRef.foundation(i),
      for (var i = 0; i < 7; i++) PileRef.tableau(i),
    ]) {
      final s = SlotComponent(p)..priority = -500;
      _slots[p] = s;
      add(s);
    }
    for (final c in PlayingCard.all) {
      final comp = CardComponent(c);
      _cards[c.id] = comp;
      add(comp);
    }
    _loaded = true;
    if (_pending != null) sync(_pending!, deal: _pendingDeal);
  }

  void updateVisuals(BoardVisuals v) {
    final relayout = v.leftHanded != _visuals.leftHanded;
    _visuals = v;
    if (relayout && _state != null) sync(_state!, animate: false);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (_loaded && _state != null) sync(_state!, animate: false);
  }

  bool get _animate => !_visuals.reducedMotion;

  /// Brings the board in line with [s]. Cards whose position or face changed
  /// animate (unless reduced motion); [deal] plays the opening deal.
  void sync(GameState s, {bool animate = true, bool deal = false}) {
    if (!_loaded || size.x <= 0) {
      _pending = s;
      _pendingDeal = deal;
      return;
    }
    _pending = null;
    _cancelDrag();
    _state = s;
    final l = layout = BoardLayout.compute(
      ui.Size(size.x, size.y),
      s,
      leftHanded: _visuals.leftHanded,
    );
    final cardSize = Vector2(l.cardSize.width, l.cardSize.height);
    for (final e in _slots.entries) {
      final r = l.slots[e.key]!;
      e.value
        ..position = Vector2(r.left, r.top)
        ..size = cardSize
        ..recycle = e.key.isStock && s.stock.isEmpty && s.canRecycle
        ..exhausted = e.key.isStock && s.stock.isEmpty && !s.canRecycle;
    }
    final placements = l.placements(s);
    final stockRect = l.slots[PileRef.stock]!;
    var order = 0;
    for (final p in placements.entries) {
      final comp = _cards[p.key]!;
      final pl = p.value;
      comp.size = cardSize;
      comp.pile = pl.pile;
      comp.index = pl.index;
      final target = Vector2(
        pl.topLeft.dx + cardSize.x / 2,
        pl.topLeft.dy + cardSize.y / 2,
      );
      if (deal && _animate && pl.pile.isTableau) {
        comp.snapTo(
          Vector2(stockRect.center.dx, stockRect.center.dy),
          faceUp: false,
          z: pl.z,
        );
        final delay = order++ * 0.035;
        comp.animateTo(target, z: pl.z, duration: 0.24, delay: delay);
        if (pl.faceUp) comp.flip(true, delay: delay + 0.2, duration: flipDuration);
        continue;
      }
      if (!animate || !_animate) {
        comp.snapTo(target, faceUp: pl.faceUp, z: pl.z);
        continue;
      }
      if (comp.faceUp != pl.faceUp) comp.flip(pl.faceUp, duration: flipDuration);
      if ((comp.position - target).length > 0.5) {
        comp.animateTo(target, z: pl.z, duration: moveDuration);
      } else {
        comp.priority = pl.z;
      }
    }
  }

  // ---------------------------------------------------------- feedback

  void showHint(Move move) {
    final s = _state;
    if (s == null) return;
    switch (move) {
      case DrawMove():
      case RecycleMove():
        _slots[PileRef.stock]?.pulse();
        _topCardsOf(PileRef.stock, 1).forEach((c) => c.pulse());
      case TransferMove(:final from, :final to, :final count):
        _topCardsOf(from, count).forEach((c) => c.pulse());
        final targetTop = _topCardsOf(to, 1);
        if (targetTop.isEmpty) {
          _slots[to]?.pulse();
        } else {
          targetTop.first.pulse();
        }
    }
  }

  void shake(PileRef pile) {
    final cards = _topCardsOf(pile, 1);
    if (pile.isTableau && _drag == null) {
      // Shake the face-up run for clarity.
    }
    for (final c in cards) {
      c.shake(enabled: _animate);
    }
  }

  List<CardComponent> _topCardsOf(PileRef pile, int count) {
    final comps = _cards.values.where((c) => c.pile == pile).toList()
      ..sort((a, b) => a.index.compareTo(b.index));
    if (comps.isEmpty) return const [];
    return comps.sublist((comps.length - count).clamp(0, comps.length));
  }

  // ------------------------------------------------------------- drag

  static const double _tapSlop = 9;

  void beginDrag(CardComponent card) {
    if (_drag != null) return;
    final allowed = delegate.canDrag(card.pile, card.index);
    final group = allowed
        ? (_cards.values
              .where((c) => c.pile == card.pile && c.index >= card.index)
              .toList()
            ..sort((a, b) => a.index.compareTo(b.index)))
        : [card];
    final d = _Drag(card, group, allowed);
    _drag = d;
    if (allowed) {
      for (var i = 0; i < group.length; i++) {
        group[i]
          ..stopMotion()
          ..priority = 2000 + i
          ..lifted = true;
        d.origins.add(group[i].position.clone());
      }
      final targets = delegate.legalTargets(card.pile, group.length);
      d.highlighted = targets;
      for (final t in targets) {
        final top = _topCardsOf(t, 1);
        if (top.isEmpty) {
          _slots[t]?.highlight = true;
        } else {
          top.first.highlight = true;
        }
      }
    }
  }

  void updateDrag(Vector2 delta) {
    final d = _drag;
    if (d == null) return;
    d.moved += delta.length;
    if (!d.allowed) return;
    for (final c in d.group) {
      c.position.add(delta);
    }
  }

  Future<void> endDrag({bool cancelled = false}) async {
    final d = _drag;
    if (d == null) return;
    _drag = null;
    _clearHighlights(d);
    final s = _state;
    if (s == null) return;
    if (!cancelled && d.moved < _tapSlop) {
      _restore(d, animate: false);
      if (d.lead.pile.isStock) {
        await delegate.tapStock();
      } else {
        await delegate.tapCard(d.lead.pile, d.lead.index);
      }
      return;
    }
    if (cancelled || !d.allowed) {
      _restore(d);
      return;
    }
    final target = _bestDropTarget(d, s);
    if (target == null) {
      _restore(d);
      return;
    }
    final ok = await delegate.drop(d.lead.pile, d.group.length, target);
    if (!ok) _restore(d);
  }

  void _cancelDrag() {
    final d = _drag;
    if (d == null) return;
    _drag = null;
    _clearHighlights(d);
    for (final c in d.group) {
      c.lifted = false;
    }
  }

  void _clearHighlights(_Drag d) {
    for (final c in _cards.values) {
      c.highlight = false;
    }
    for (final s in _slots.values) {
      s.highlight = false;
    }
    for (final c in d.group) {
      c.lifted = false;
    }
  }

  PileRef? _bestDropTarget(_Drag d, GameState s) {
    final l = layout!;
    final lead = d.lead;
    final rect = ui.Rect.fromCenter(
      center: ui.Offset(lead.position.x, lead.position.y),
      width: lead.size.x,
      height: lead.size.y,
    );
    PileRef? best;
    var bestArea = 0.0;
    final candidates = [
      for (var i = 0; i < 4; i++) PileRef.foundation(i),
      for (var i = 0; i < 7; i++) PileRef.tableau(i),
    ];
    // Prefer legal targets; fall back to any overlapped pile so the
    // controller can reject (and shake) an illegal drop.
    for (final legalOnly in [true, false]) {
      for (final p in candidates) {
        if (p == lead.pile) continue;
        if (legalOnly && !d.highlighted.contains(p)) continue;
        final inter = rect.intersect(l.dropZone(p, s));
        if (inter.width <= 0 || inter.height <= 0) continue;
        final area = inter.width * inter.height;
        if (area > bestArea) {
          bestArea = area;
          best = p;
        }
      }
      if (best != null) return best;
    }
    return null;
  }

  void _restore(_Drag d, {bool animate = true}) {
    for (var i = 0; i < d.group.length; i++) {
      final c = d.group[i];
      final origin = i < d.origins.length ? d.origins[i] : c.position;
      if (animate && _animate) {
        c.animateTo(origin, z: c.restingZ, duration: 0.16);
      } else {
        c
          ..position = origin
          ..priority = c.restingZ;
      }
    }
  }
}

class _Drag {
  _Drag(this.lead, this.group, this.allowed);
  final CardComponent lead;
  final List<CardComponent> group;
  final bool allowed;
  final List<Vector2> origins = [];
  List<PileRef> highlighted = const [];
  double moved = 0;
}

SolitaireBoardGame _gameOf(Component c) => c.findGame()! as SolitaireBoardGame;

/// One playing card. Tap and drag are both detected through drag callbacks
/// (a drag shorter than the tap slop is a tap), so they never conflict.
class CardComponent extends PositionComponent with DragCallbacks {
  CardComponent(this.card) : super(anchor: Anchor.center);

  final PlayingCard card;
  PileRef pile = PileRef.stock;
  int index = 0;
  bool faceUp = false;
  bool lifted = false;
  bool highlight = false;
  int restingZ = 0;
  double _pulse = 0;

  SolitaireBoardGame get _game => _gameOf(this);

  void snapTo(Vector2 center, {required bool faceUp, required int z}) {
    stopMotion();
    position = center;
    this.faceUp = faceUp;
    scale = Vector2.all(1);
    restingZ = z;
    priority = z;
  }

  void stopMotion() {
    for (final e in children.whereType<Effect>().toList()) {
      e.removeFromParent();
    }
    scale = Vector2(1, 1);
  }

  void animateTo(Vector2 target, {required int z, required double duration, double delay = 0}) {
    children.whereType<MoveEffect>().toList().forEach((e) => e.removeFromParent());
    restingZ = z;
    priority = 1000 + z; // fly above resting cards
    add(
      MoveToEffect(
        target,
        EffectController(
          duration: duration,
          curve: Curves.easeOutCubic,
          startDelay: delay,
        ),
        onComplete: () => priority = restingZ,
      ),
    );
  }

  void flip(bool toFaceUp, {required double duration, double delay = 0}) {
    final half = duration / 2;
    add(
      SequenceEffect([
        ScaleEffect.to(Vector2(0, 1.04), EffectController(duration: half, startDelay: delay)),
        ScaleEffect.to(
          Vector2(1, 1),
          EffectController(duration: half),
          onComplete: () {},
        ),
      ]),
    );
    // Swap the face exactly at the half-way point.
    add(
      TimerComponent(
        period: delay + half,
        removeOnFinish: true,
        onTick: () => faceUp = toFaceUp,
      ),
    );
  }

  void pulse() => _pulse = 1.6;

  void shake({required bool enabled}) {
    if (!enabled) {
      _pulse = 0.4;
      return;
    }
    add(
      SequenceEffect([
        MoveByEffect(Vector2(5, 0), EffectController(duration: 0.04)),
        MoveByEffect(Vector2(-10, 0), EffectController(duration: 0.07)),
        MoveByEffect(Vector2(5, 0), EffectController(duration: 0.04)),
      ]),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_pulse > 0) _pulse = (_pulse - dt).clamp(0, 10);
  }

  @override
  void render(ui.Canvas canvas) {
    final w = size.x, h = size.y;
    final rr = ui.RRect.fromRectAndRadius(
      ui.Rect.fromLTWH(0, 0, w, h),
      ui.Radius.circular(w * 0.09),
    );
    // Cheap shadow; a softer, larger one while lifted.
    canvas.drawRRect(
      rr.shift(ui.Offset(lifted ? 3 : 0.8, lifted ? 6 : 1.4)),
      ui.Paint()
        ..color = const ui.Color(0x55000000)
        ..maskFilter = lifted ? const ui.MaskFilter.blur(ui.BlurStyle.normal, 5) : null,
    );
    CardPainter.paintCard(
      canvas,
      ui.Offset.zero,
      ui.Size(w, h),
      card,
      faceUp: faceUp,
      style: _game.visuals.cardStyle,
    );
    if (highlight || _pulse > 0) {
      final a = highlight ? 1.0 : (0.5 + 0.5 * (_pulse * 6).remainder(2).abs().clamp(0, 1));
      canvas.drawRRect(
        rr.inflate(1.5),
        ui.Paint()
          ..style = ui.PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = const ui.Color(0xFFF1DDA6).withValues(alpha: a),
      );
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _game.beginDrag(this);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) => _game.updateDrag(event.canvasDelta);

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _game.endDrag();
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _game.endDrag(cancelled: true);
  }
}

/// Empty pile placeholder (also the tap target for recycling the stock).
class SlotComponent extends PositionComponent with DragCallbacks {
  SlotComponent(this.pile);
  final PileRef pile;
  bool recycle = false;
  bool exhausted = false;
  bool highlight = false;
  double _pulse = 0;
  double _moved = 0;

  void pulse() => _pulse = 1.6;

  @override
  void update(double dt) {
    super.update(dt);
    if (_pulse > 0) _pulse = (_pulse - dt).clamp(0, 10);
  }

  @override
  void render(ui.Canvas canvas) {
    final game = _gameOf(this);
    CardPainter.paintSlot(
      canvas,
      ui.Rect.fromLTWH(0, 0, size.x, size.y),
      table: game.visuals.tableStyle,
      suit: pile.isFoundation ? Suit.values[pile.index] : null,
      recycle: recycle,
      highlight: highlight || _pulse > 0,
    );
    if (exhausted) {
      final p = ui.Paint()
        ..color = const ui.Color(0x88D6B574)
        ..strokeWidth = 2;
      canvas.drawLine(ui.Offset(size.x * 0.3, size.y * 0.4), ui.Offset(size.x * 0.7, size.y * 0.6), p);
      canvas.drawLine(ui.Offset(size.x * 0.7, size.y * 0.4), ui.Offset(size.x * 0.3, size.y * 0.6), p);
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _moved = 0;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) => _moved += event.canvasDelta.length;

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if (_moved < 9 && pile.isStock) _gameOf(this).delegate.tapStock();
  }
}

/// Felt table surface.
class TableComponent extends Component with HasGameReference<SolitaireBoardGame> {
  @override
  void render(ui.Canvas canvas) {
    final s = game.size;
    CardPainter.paintTable(canvas, ui.Size(s.x, s.y), game.visuals.tableStyle);
  }
}
