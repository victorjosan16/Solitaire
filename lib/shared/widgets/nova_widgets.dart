import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../app/theme/tokens.dart';

/// Primary call-to-action: polished gold pill.
class GoldButton extends StatelessWidget {
  const GoldButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.height = 56,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double height;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final child = Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: NovaSpace.xl),
      decoration: BoxDecoration(
        gradient: enabled ? NovaColors.goldGradient : null,
        color: enabled ? null : const Color(0xFF5B5543),
        borderRadius: BorderRadius.circular(NovaRadius.pill),
        border: Border.all(color: const Color(0xFFFFEDB8), width: 1.2),
        boxShadow: enabled
            ? const [
                BoxShadow(
                  color: Color(0x73000000),
                  blurRadius: 14,
                  offset: Offset(0, 6),
                ),
                BoxShadow(color: Color(0xFF7A5A22), offset: Offset(0, 2.5)),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: const Color(0xFF0B3A30), size: 34),
            const SizedBox(width: NovaSpace.md),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: NovaFonts.display,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1608),
              ),
            ),
          ),
        ],
      ),
    );
    return Semantics(
      button: true,
      enabled: enabled,
      child: _Pressable(onTap: onPressed, child: child),
    );
  }
}

/// Secondary button: emerald panel with gold hairline.
class PanelButton extends StatelessWidget {
  const PanelButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.badge,
    this.height = 52,
    this.leading,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Widget? leading;
  final Widget? badge;
  final double height;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      constraints: BoxConstraints(minHeight: height),
      padding: const EdgeInsets.symmetric(horizontal: NovaSpace.lg),
      decoration: BoxDecoration(
        gradient: NovaColors.panelGradient,
        borderRadius: BorderRadius.circular(NovaRadius.pill),
        border: Border.all(color: NovaColors.gold.withValues(alpha: 0.55)),
        boxShadow: NovaShadows.soft,
      ),
      child: Row(
        children: [
          ?leading,
          if (icon != null)
            Icon(icon, color: NovaColors.goldLight, size: NovaIconSize.md),
          const SizedBox(width: NovaSpace.md),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: NovaColors.ivory,
              ),
            ),
          ),
          const SizedBox(width: NovaSpace.md + NovaIconSize.md),
        ],
      ),
    );
    return Semantics(
      button: true,
      enabled: onPressed != null,
      child: _Pressable(
        onTap: onPressed,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            content,
            if (badge != null) Positioned(right: -2, top: -6, child: badge!),
          ],
        ),
      ),
    );
  }
}

/// Scale-on-press feedback without the Material ink.
class _Pressable extends StatefulWidget {
  const _Pressable({required this.onTap, required this.child});
  final VoidCallback? onTap;
  final Widget child;
  @override
  State<_Pressable> createState() => _PressableState();
}

class _PressableState extends State<_Pressable> {
  bool _down = false;
  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? (_) => setState(() => _down = true) : null,
      onTapCancel: enabled ? () => setState(() => _down = false) : null,
      onTapUp: enabled ? (_) => setState(() => _down = false) : null,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _down ? 0.97 : 1,
        duration: NovaDurations.fast,
        child: Opacity(opacity: enabled ? 1 : 0.55, child: widget.child),
      ),
    );
  }
}

/// Rounded emerald panel with gold border.
class NovaPanel extends StatelessWidget {
  const NovaPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(NovaSpace.lg),
    this.highlight = false,
    this.radius = NovaRadius.lg,
  });

  final Widget child;
  final EdgeInsets padding;
  final bool highlight;
  final double radius;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      gradient: NovaColors.panelGradient,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: NovaColors.gold.withValues(alpha: highlight ? 0.95 : 0.35),
        width: highlight ? 2 : 1,
      ),
      boxShadow: highlight
          ? [...NovaShadows.soft, ...NovaShadows.goldGlow(0.3)]
          : NovaShadows.soft,
    ),
    child: child,
  );
}

/// Gold coin glyph (original): disc with an embossed star.
class CoinIcon extends StatelessWidget {
  const CoinIcon({super.key, this.size = 24});
  final double size;
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: CustomPaint(size: Size.square(size), painter: _CoinPainter()),
  );
}

class _CoinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2;
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = const RadialGradient(
          colors: [Color(0xFFFFE9A8), Color(0xFFE2B34A), Color(0xFFA77A22)],
          stops: [0, 0.6, 1],
        ).createShader(Rect.fromCircle(center: c, radius: r)),
    );
    canvas.drawCircle(
      c,
      r * 0.78,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.1
        ..color = const Color(0xFFB98A2E),
    );
    final star = Path();
    for (var i = 0; i < 10; i++) {
      final a = -math.pi / 2 + i * math.pi / 5;
      final rr = i.isEven ? r * 0.5 : r * 0.22;
      final p = c + Offset(math.cos(a) * rr, math.sin(a) * rr);
      i == 0 ? star.moveTo(p.dx, p.dy) : star.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(star..close(), Paint()..color = const Color(0xFFFFF4CC));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Coin balance pill, as in the reference header.
class CoinBadge extends StatelessWidget {
  const CoinBadge({super.key, required this.coins, this.onAdd, this.label});
  final int coins;
  final VoidCallback? onAdd;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      excludeSemantics: label != null,
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
        decoration: BoxDecoration(
          color: const Color(0xCC0A1F1C),
          borderRadius: BorderRadius.circular(NovaRadius.pill),
          border: Border.all(color: NovaColors.gold.withValues(alpha: 0.7)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CoinIcon(size: 24),
            const SizedBox(width: 6),
            Text(
              formatThousands(coins),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: NovaColors.ivory,
              ),
            ),
            if (onAdd != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: NovaColors.success,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 18, color: Colors.white),
                ),
              ),
            ] else
              const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

/// Locale-agnostic thousands grouping used for coin amounts in compact UI.
String formatThousands(int v) {
  final s = v.abs().toString();
  final b = StringBuffer(v < 0 ? '-' : '');
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
    b.write(s[i]);
  }
  return b.toString();
}

/// Gold progress bar.
class NovaProgressBar extends StatelessWidget {
  const NovaProgressBar({super.key, required this.value, this.height = 8});
  final double value;
  final double height;
  @override
  Widget build(BuildContext context) => Container(
    height: height,
    decoration: BoxDecoration(
      color: const Color(0xFF0A1A18),
      borderRadius: BorderRadius.circular(height),
      border: Border.all(color: NovaColors.gold.withValues(alpha: 0.3)),
    ),
    child: FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: value.clamp(0, 1),
      child: Container(
        decoration: BoxDecoration(
          gradient: NovaColors.goldGradient,
          borderRadius: BorderRadius.circular(height),
        ),
      ),
    ),
  );
}

/// Pill segmented tabs (gold = selected).
class NovaTabs extends StatelessWidget {
  const NovaTabs({
    super.key,
    required this.labels,
    required this.selected,
    required this.onChanged,
  });

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(
      color: const Color(0xFF0A221F),
      borderRadius: BorderRadius.circular(NovaRadius.pill),
      border: Border.all(color: NovaColors.gold.withValues(alpha: 0.35)),
    ),
    child: Row(
      children: [
        for (var i = 0; i < labels.length; i++)
          Expanded(
            child: Semantics(
              selected: i == selected,
              button: true,
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: NovaDurations.medium,
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    gradient: i == selected ? NovaColors.goldGradient : null,
                    borderRadius: BorderRadius.circular(NovaRadius.pill),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        labels[i],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: i == selected
                              ? NovaColors.navy
                              : NovaColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

/// Screen header: back chevron, serif gold title, optional trailing widget.
class NovaHeader extends StatelessWidget {
  const NovaHeader({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
    this.icon,
  });

  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final back = MaterialLocalizations.of(context).backButtonTooltip;
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          if (onBack != null)
            IconButton(
              tooltip: back,
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: NovaColors.goldLight,
            )
          else
            const SizedBox(width: 48),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: NovaColors.goldLight),
                  const SizedBox(width: NovaSpace.sm),
                ],
                Flexible(
                  child: Semantics(
                    header: true,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: NovaFonts.display,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: NovaColors.goldLight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: trailing == null ? 48 : null, child: trailing),
        ],
      ),
    );
  }
}

/// Standard screen frame with the emerald gradient and safe areas.
class NovaScaffold extends StatelessWidget {
  const NovaScaffold({
    super.key,
    required this.body,
    this.title,
    this.onBack,
    this.trailing,
    this.background,
    this.bottom,
    this.embedded = false,
  });

  final Widget body;

  /// Render only [body] (used when a screen is a tab inside another screen).
  final bool embedded;
  final String? title;
  final VoidCallback? onBack;
  final Widget? trailing;
  final Widget? background;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    if (embedded) return body;
    return Scaffold(
      backgroundColor: NovaColors.navy,
      body: Stack(
        fit: StackFit.expand,
        children: [
          background ??
              const DecoratedBox(
                decoration: BoxDecoration(gradient: NovaColors.screenGradient),
              ),
          SafeArea(
            child: Column(
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: NovaSpace.sm,
                    ),
                    child: NovaHeader(
                      title: title!,
                      onBack: onBack,
                      trailing: trailing,
                    ),
                  ),
                Expanded(child: body),
                ?bottom,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Constrains content width on tablets so lists don't stretch edge to edge.
class MaxWidth extends StatelessWidget {
  const MaxWidth({super.key, required this.child, this.maxWidth = 560});
  final Widget child;
  final double maxWidth;
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    ),
  );
}

/// Circular icon medallion used in achievements and lists.
class Medallion extends StatelessWidget {
  const Medallion({
    super.key,
    required this.icon,
    this.size = 52,
    this.dimmed = false,
  });
  final IconData icon;
  final double size;
  final bool dimmed;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: const RadialGradient(
        colors: [Color(0xFF1E5C51), Color(0xFF0B2A26)],
      ),
      border: Border.all(
        color: NovaColors.gold.withValues(alpha: dimmed ? 0.35 : 0.9),
        width: 1.5,
      ),
    ),
    child: Icon(
      icon,
      size: size * 0.52,
      color: dimmed ? NovaColors.textMuted : NovaColors.goldLight,
    ),
  );
}

/// Uniform shortcut tile: gold icon over a localized label.
class NovaTile extends StatelessWidget {
  const NovaTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    excludeSemantics: true,
    child: _Pressable(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 88),
        padding: const EdgeInsets.symmetric(
          horizontal: NovaSpace.xs,
          vertical: NovaSpace.md,
        ),
        decoration: BoxDecoration(
          gradient: NovaColors.panelGradient,
          borderRadius: BorderRadius.circular(NovaRadius.md + 2),
          border: Border.all(color: NovaColors.gold.withValues(alpha: 0.5)),
          boxShadow: NovaShadows.soft,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: NovaColors.gold),
            const SizedBox(height: NovaSpace.xs + 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.15,
                  fontWeight: FontWeight.w600,
                  color: NovaColors.ivory,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Hairline gold divider with a centred spade, as in the brand reference.
class SuitDivider extends StatelessWidget {
  const SuitDivider({super.key});
  @override
  Widget build(BuildContext context) {
    Widget line(bool left) => Expanded(
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              NovaColors.gold.withValues(alpha: left ? 0 : 0.6),
              NovaColors.gold.withValues(alpha: left ? 0.6 : 0),
            ],
          ),
        ),
      ),
    );
    return ExcludeSemantics(
      child: Row(
        children: [
          line(true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: NovaSpace.sm),
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  gradient: NovaColors.goldGradient,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
          ),
          line(false),
        ],
      ),
    );
  }
}
