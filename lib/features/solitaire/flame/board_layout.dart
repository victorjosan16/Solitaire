import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/painting.dart' show EdgeInsets;

import '../domain/models/game_state.dart';
import '../domain/models/pile_ref.dart';

/// Where one card sits on the board.
class CardPlacement {
  const CardPlacement({
    required this.pile,
    required this.index,
    required this.topLeft,
    required this.faceUp,
    required this.z,
  });
  final PileRef pile;
  final int index;
  final Offset topLeft;
  final bool faceUp;
  final int z;
}

/// Pure geometry for the Klondike board. No Flame dependency: unit-tested
/// for every screen size (no overlap off-screen, legible overlaps).
class BoardLayout {
  BoardLayout._({
    required this.size,
    required this.cardSize,
    required this.slots,
    required this.tableauFaceDown,
    required this.tableauFaceUp,
    required this.wasteFan,
  });

  final Size size;
  final Size cardSize;

  /// Rect of the base position of every pile (13 piles).
  final Map<PileRef, Rect> slots;

  /// Per-column vertical offsets (compressed when a column gets long).
  final List<double> tableauFaceDown;
  final List<double> tableauFaceUp;
  final double wasteFan;

  static const double aspect = 1.4;

  /// Builds the layout for [state] in [size].
  ///
  /// Right-handed (default): foundations left, waste + stock right (stock in
  /// the far right column, like the reference). Left-handed mirrors this.
  factory BoardLayout.compute(
    Size size,
    GameState state, {
    bool leftHanded = false,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    final usableW = size.width - padding.horizontal;
    final usableH = size.height - padding.vertical;
    final gap = math.max(3.0, usableW * 0.014);
    var cardW = (usableW - gap * 8) / 7;
    // Landscape / short screens: keep a full King run (13 face-up + 6
    // face-down) readable by bounding card height.
    final maxCardH = usableH / 3.4;
    if (cardW * aspect > maxCardH) cardW = maxCardH / aspect;
    cardW = math.max(cardW, 20);
    final cardH = cardW * aspect;
    final totalW = cardW * 7 + gap * 6;
    final left = padding.left + (usableW - totalW) / 2;
    final top = padding.top + gap;

    double colX(int c) => left + c * (cardW + gap);
    final slots = <PileRef, Rect>{};
    final topRow = Size(cardW, cardH);
    final foundationCols = leftHanded ? [3, 4, 5, 6] : [0, 1, 2, 3];
    for (var i = 0; i < 4; i++) {
      slots[PileRef.foundation(i)] =
          Offset(colX(foundationCols[i]), top) & topRow;
    }
    final stockCol = leftHanded ? 0 : 6;
    final wasteCol = leftHanded ? 1 : 4;
    slots[PileRef.stock] = Offset(colX(stockCol), top) & topRow;
    slots[PileRef.waste] = Offset(colX(wasteCol), top) & topRow;

    final tableauTop = top + cardH + gap * 2.2;
    for (var c = 0; c < 7; c++) {
      slots[PileRef.tableau(c)] = Offset(colX(c), tableauTop) & topRow;
    }

    // Column offsets: default proportions, compressed to fit vertically.
    final bottom = size.height - padding.bottom - gap;
    final avail = bottom - tableauTop - cardH;
    final fdDefault = cardH * 0.13, fuDefault = cardH * 0.29;
    final fds = <double>[], fus = <double>[];
    for (final col in state.tableau) {
      final nDown = col.where((t) => !t.faceUp).length;
      final nUp = math.max(0, col.length - nDown - 1);
      var fd = fdDefault, fu = fuDefault;
      final need = nDown * fd + nUp * fu;
      if (need > avail && need > 0) {
        final k = math.max(0.0, avail) / need;
        fd = math.max(fdDefault * k, 3.0);
        fu = math.max(fuDefault * k, cardH * 0.16);
        // If still too tall, squeeze face-down cards to the minimum.
        if (nDown * fd + nUp * fu > avail) fd = 3;
      }
      fds.add(fd);
      fus.add(fu);
    }
    return BoardLayout._(
      size: size,
      cardSize: topRow,
      slots: slots,
      tableauFaceDown: fds,
      tableauFaceUp: fus,
      wasteFan: cardW * 0.24,
    );
  }

  /// Position (top-left) of every card, keyed by card id.
  Map<int, CardPlacement> placements(GameState s) {
    final out = <int, CardPlacement>{};
    var z = 0;
    final stock = slots[PileRef.stock]!;
    for (var i = 0; i < s.stock.length; i++) {
      // Tiny stacking offset hints at the stock depth.
      final d = (i ~/ 8) * 0.8;
      out[s.stock[i].id] = CardPlacement(
        pile: PileRef.stock,
        index: i,
        topLeft: stock.topLeft.translate(-d, -d),
        faceUp: false,
        z: z++,
      );
    }
    final waste = slots[PileRef.waste]!;
    final fanFrom = s.config.drawCount == 3
        ? math.max(s.wasteFanStart, s.waste.length - 3)
        : s.waste.length;
    for (var i = 0; i < s.waste.length; i++) {
      final k = i >= fanFrom ? i - fanFrom : 0;
      out[s.waste[i].id] = CardPlacement(
        pile: PileRef.waste,
        index: i,
        topLeft: waste.topLeft.translate(k * wasteFan, 0),
        faceUp: true,
        z: z++,
      );
    }
    for (var f = 0; f < 4; f++) {
      final r = slots[PileRef.foundation(f)]!;
      final pile = s.foundations[f];
      for (var i = 0; i < pile.length; i++) {
        out[pile[i].id] = CardPlacement(
          pile: PileRef.foundation(f),
          index: i,
          topLeft: r.topLeft,
          faceUp: true,
          z: z++,
        );
      }
    }
    for (var c = 0; c < 7; c++) {
      final r = slots[PileRef.tableau(c)]!;
      var y = r.top;
      final col = s.tableau[c];
      for (var i = 0; i < col.length; i++) {
        out[col[i].card.id] = CardPlacement(
          pile: PileRef.tableau(c),
          index: i,
          topLeft: Offset(r.left, y),
          faceUp: col[i].faceUp,
          z: 100 + c * 20 + i,
        );
        y += col[i].faceUp ? tableauFaceUp[c] : tableauFaceDown[c];
      }
    }
    return out;
  }

  /// Drop-target area of a pile: its slot, extended down to the bottom of a
  /// tableau column so dropping anywhere on the column works.
  Rect dropZone(PileRef p, GameState s) {
    final r = slots[p]!;
    if (!p.isTableau) return r.inflate(cardSize.width * 0.15);
    final col = s.tableau[p.index];
    var h = r.height;
    for (var i = 0; i < col.length - 1; i++) {
      h += col[i].faceUp ? tableauFaceUp[p.index] : tableauFaceDown[p.index];
    }
    return Rect.fromLTWH(
      r.left,
      r.top,
      r.width,
      h,
    ).inflate(cardSize.width * 0.12);
  }
}
