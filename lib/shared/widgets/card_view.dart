import 'package:material_ui/material_ui.dart';

import '../../features/solitaire/domain/models/card.dart';
import '../../features/solitaire/presentation/card_art/card_painter.dart';
import '../../features/solitaire/presentation/card_art/card_styles.dart';

/// A single card rendered with the shared [CardPainter] (for previews).
class CardView extends StatelessWidget {
  const CardView({
    super.key,
    required this.card,
    this.faceUp = true,
    this.style = CardStyle.classic,
    this.width = 60,
    this.shadow = true,
  });

  final PlayingCard card;
  final bool faceUp;
  final CardStyle style;
  final double width;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final size = Size(width, width * 1.4);
    return Container(
      decoration: shadow
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.09),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x66000000),
                  blurRadius: 8,
                  offset: Offset(1, 3),
                ),
              ],
            )
          : null,
      child: CustomPaint(
        size: size,
        painter: _CardViewPainter(card, faceUp, style),
      ),
    );
  }
}

class _CardViewPainter extends CustomPainter {
  _CardViewPainter(this.card, this.faceUp, this.style);
  final PlayingCard card;
  final bool faceUp;
  final CardStyle style;

  @override
  void paint(Canvas canvas, Size size) => CardPainter.paintCard(
    canvas,
    Offset.zero,
    size,
    card,
    faceUp: faceUp,
    style: style,
  );

  @override
  bool shouldRepaint(_CardViewPainter old) =>
      old.card != card || old.faceUp != faceUp || old.style != style;
}
