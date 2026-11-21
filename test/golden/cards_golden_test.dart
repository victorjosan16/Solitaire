@Tags(['golden'])
library;

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/card.dart';
import 'package:solitaire_nova/features/solitaire/presentation/card_art/court_art.dart';
import 'package:solitaire_nova/shared/widgets/card_view.dart';

void main() {
  testWidgets('court cards with illustrated portraits', (tester) async {
    await tester.runAsync(() => CourtArt.load(rootBundle));
    await tester.binding.setSurfaceSize(const Size(560, 420));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: ColoredBox(
          color: const Color(0xFF16603F),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in Suit.values)
                for (final r in [1, 11, 12, 13])
                  CardView(card: PlayingCard(s, r), width: 56),
            ],
          ),
        ),
      ),
    );
    await expectLater(
      find.byType(Wrap),
      matchesGoldenFile('goldens/court_cards.png'),
    );
  });
}
