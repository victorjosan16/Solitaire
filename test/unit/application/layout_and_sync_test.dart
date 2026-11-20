import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:solitaire_nova/core/services/cloud_backup.dart';
import 'package:solitaire_nova/features/solitaire/application/play_clock.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/card.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_config.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_state.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/pile_ref.dart';
import 'package:solitaire_nova/features/solitaire/flame/board_layout.dart';

import '../engine/test_helpers.dart';
import '../persistence/json_document_store_test.dart' show sampleSnapshot;

/// Worst case: a column with 6 face-down cards and a full King..Ace run.
GameState worstCase() {
  final run = <TableauCard>[];
  for (var r = 13; r >= 1; r--) {
    final suit = r.isEven ? 'S' : 'H';
    run.add(
      up(
        '${switch (r) {
          1 => 'A',
          11 => 'J',
          12 => 'Q',
          13 => 'K',
          _ => '$r',
        }}$suit',
      ),
    );
  }
  return board(
    tableau: [
      [],
      [],
      [],
      [],
      [],
      [],
      [
        down('2C'),
        down('3C'),
        down('4C'),
        down('5C'),
        down('6C'),
        down('7C'),
        ...run,
      ],
    ],
  );
}

void main() {
  group('BoardLayout', () {
    for (final size in const [
      Size(320, 520),
      Size(360, 640),
      Size(390, 700),
      Size(820, 1100),
      Size(1180, 700),
      Size(700, 330),
    ]) {
      test('all cards on screen and indices readable at $size', () {
        final s = worstCase();
        final l = BoardLayout.compute(size, s);
        final pl = l.placements(s);
        expect(pl, hasLength(52));
        for (final p in pl.values) {
          final r = p.topLeft & l.cardSize;
          expect(r.left, greaterThanOrEqualTo(-1));
          expect(r.right, lessThanOrEqualTo(size.width + 1));
          expect(r.top, greaterThanOrEqualTo(0));
          expect(r.bottom, lessThanOrEqualTo(size.height + 1), reason: '$p');
        }
        // Face-up overlap leaves at least 16% of a card visible: enough for
        // the rank index printed in the top band.
        expect(
          l.tableauFaceUp[6] / l.cardSize.height,
          greaterThanOrEqualTo(0.159),
        );
        expect(l.cardSize.height / l.cardSize.width, closeTo(1.4, 1e-9));
      });
    }

    test('left-handed mode mirrors stock and foundations only', () {
      final s = board(tableau: List.generate(7, (_) => []));
      const size = Size(390, 700);
      final r = BoardLayout.compute(size, s);
      final l = BoardLayout.compute(size, s, leftHanded: true);
      expect(
        r.slots[PileRef.stock]!.left,
        greaterThan(r.slots[PileRef.foundation(0)]!.left),
      );
      expect(
        l.slots[PileRef.stock]!.left,
        lessThan(l.slots[PileRef.foundation(0)]!.left),
      );
      for (var c = 0; c < 7; c++) {
        expect(l.slots[PileRef.tableau(c)], r.slots[PileRef.tableau(c)]);
      }
    });

    test('draw 3 fans only the last batch', () {
      final s = board(
        config: GameConfig.draw3,
        waste: ['2C', '3C', '4C', '5C', '6C'],
        tableau: List.generate(7, (_) => []),
      ).copyWith(wasteFanStart: 2);
      final l = BoardLayout.compute(const Size(390, 700), s);
      final pl = l.placements(s);
      final base = l.slots[PileRef.waste]!.left;
      expect(pl[c('2C').id]!.topLeft.dx, base);
      expect(pl[c('3C').id]!.topLeft.dx, base);
      expect(pl[c('6C').id]!.topLeft.dx, closeTo(base + 2 * l.wasteFan, 1e-9));
      expect(pl[c('6C').id]!.z, greaterThan(pl[c('5C').id]!.z));
    });
  });

  group('PlayClock', () {
    test('never counts backwards clock jumps', () {
      var now = DateTime(2026);
      final clock = PlayClock(now: () => now);
      clock.start();
      now = now.subtract(const Duration(hours: 1));
      clock.pause();
      expect(clock.elapsedMs, 0);
    });
  });

  group('Cloud conflict policy', () {
    final a = sampleSnapshot(seed: 1, draws: 3);
    final b = sampleSnapshot(seed: 2, draws: 5);
    test('missing sides', () {
      expect(resolveGameConflict(a, null), ConflictResolution.keepLocal);
      expect(resolveGameConflict(null, a), ConflictResolution.keepRemote);
    });
    test('same game: more progress and newer wins', () {
      final ahead = a.copyWith(
        history: [...a.history, a.history.first],
        updatedAt: a.updatedAt.add(const Duration(minutes: 1)),
      );
      expect(resolveGameConflict(a, ahead), ConflictResolution.keepRemote);
      expect(resolveGameConflict(ahead, a), ConflictResolution.keepLocal);
    });
    test('diverged active games ask the user when remote is newer', () {
      final newer = b.copyWith(
        updatedAt: a.updatedAt.add(const Duration(hours: 1)),
      );
      expect(resolveGameConflict(a, newer), ConflictResolution.askUser);
      expect(resolveGameConflict(newer, a), ConflictResolution.keepLocal);
    });
    test('finished games never override an active local one', () {
      expect(
        resolveGameConflict(a, b.copyWith(finished: true)),
        ConflictResolution.keepLocal,
      );
    });
  });

  test('suit order used by foundations is stable', () {
    expect(Suit.values.map((s) => s.code).join(), 'CDHS');
  });
}
