import 'package:material_ui/material_ui.dart';

import '../../../app/theme/tokens.dart';
import '../../../shared/widgets/card_view.dart';
import '../../../shared/widgets/scene_painter.dart';
import '../../solitaire/domain/models/card.dart';
import '../../solitaire/presentation/card_art/card_painter.dart';
import '../../solitaire/presentation/card_art/card_styles.dart';
import '../domain/cosmetics.dart';

/// Visual thumbnail for a cosmetic item.
class CosmeticPreview extends StatelessWidget {
  const CosmeticPreview({super.key, required this.item, this.cardStyleId});
  final CosmeticItem item;

  /// Card pack used when previewing tables (legibility check).
  final String? cardStyleId;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(NovaRadius.md),
      child: LayoutBuilder(
        builder: (context, box) {
          final w = box.maxWidth;
          switch (item.kind) {
            case CosmeticKind.background:
              return SceneBackground(sceneId: item.id, dim: 0.1);
            case CosmeticKind.cards:
              final st = CardStyle.byId(item.id);
              return Container(
                color: const Color(0xFF0E2E29),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardView(
                      card: PlayingCard(Suit.spades, 1),
                      style: st,
                      width: w * 0.36,
                    ),
                    SizedBox(width: w * 0.04),
                    CardView(
                      card: PlayingCard(Suit.hearts, 1),
                      faceUp: false,
                      style: st,
                      width: w * 0.36,
                    ),
                  ],
                ),
              );
            case CosmeticKind.table:
              final t = TableStyle.byId(item.id);
              final st = CardStyle.byId(cardStyleId ?? 'cards.classic');
              return CustomPaint(
                painter: _TablePainter(t),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardView(
                        card: PlayingCard(Suit.hearts, 13),
                        style: st,
                        width: w * 0.3,
                      ),
                      SizedBox(width: w * 0.04),
                      CardView(
                        card: PlayingCard(Suit.clubs, 12),
                        style: st,
                        width: w * 0.3,
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class _TablePainter extends CustomPainter {
  _TablePainter(this.t);
  final TableStyle t;
  @override
  void paint(Canvas canvas, Size size) =>
      CardPainter.paintTable(canvas, size, t);
  @override
  bool shouldRepaint(_TablePainter old) => old.t != t;
}
