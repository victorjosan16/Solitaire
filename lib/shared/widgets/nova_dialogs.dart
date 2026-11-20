import 'package:material_ui/material_ui.dart';

import '../../app/l10n/l10n.dart';
import '../../app/theme/tokens.dart';

/// Consistent premium dialogs. All return a value instead of navigating, so
/// callers control flow (and widget tests can drive them).
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String body,
  String? confirmLabel,
  bool destructive = false,
}) async {
  final l = context.l10n;
  final r = await showDialog<bool>(
    context: context,
    builder: (c) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c, false),
          child: Text(l.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(c, true),
          style: destructive
              ? TextButton.styleFrom(foregroundColor: const Color(0xFFFF8A80))
              : null,
          child: Text(confirmLabel ?? l.confirm),
        ),
      ],
    ),
  );
  return r ?? false;
}

Future<void> showInfoDialog(
  BuildContext context, {
  required String title,
  required String body,
  IconData? icon,
}) {
  final l = context.l10n;
  return showDialog<void>(
    context: context,
    builder: (c) => AlertDialog(
      icon: icon == null
          ? null
          : Icon(icon, color: NovaColors.goldLight, size: 36),
      title: Text(title),
      content: SingleChildScrollView(child: Text(body)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c), child: Text(l.ok)),
      ],
    ),
  );
}

Future<void> showOfflineDialog(BuildContext context) => showInfoDialog(
  context,
  title: context.l10n.offlineTitle,
  body: context.l10n.offlineBody,
  icon: Icons.wifi_off_rounded,
);

Future<void> showAdUnavailableDialog(BuildContext context) => showInfoDialog(
  context,
  title: context.l10n.adUnavailableTitle,
  body: context.l10n.adUnavailableBody,
  icon: Icons.hourglass_empty_rounded,
);

Future<void> showErrorDialog(BuildContext context) => showInfoDialog(
  context,
  title: context.l10n.errorTitle,
  body: context.l10n.errorBody,
  icon: Icons.error_outline_rounded,
);

/// Shown when a purchase needs more coins than the player has.
Future<void> showInsufficientCoinsDialog(BuildContext context, int missing) =>
    showInfoDialog(
      context,
      title: context.l10n.insufficientTitle,
      body: context.l10n.insufficientBody(missing),
      icon: Icons.savings_outlined,
    );

/// Cloud conflict resolution prompt (used by the sync adapter).
Future<bool?> showCloudConflictDialog(BuildContext context) {
  final l = context.l10n;
  return showDialog<bool>(
    context: context,
    builder: (c) => AlertDialog(
      icon: const Icon(
        Icons.cloud_sync_outlined,
        color: NovaColors.goldLight,
        size: 36,
      ),
      title: Text(l.cloudConflictTitle),
      content: Text(l.cloudConflictBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c, false),
          child: Text(l.keepCloud),
        ),
        TextButton(
          onPressed: () => Navigator.pop(c, true),
          child: Text(l.keepThisDevice),
        ),
      ],
    ),
  );
}

void showNovaSnack(BuildContext context, String text, {IconData? icon}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: NovaColors.goldLight),
              const SizedBox(width: NovaSpace.md),
            ],
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
}

/// "How to play" rules sheet.
Future<void> showHowToPlay(BuildContext context) {
  final l = context.l10n;
  Widget rule(IconData icon, String text) => Padding(
    padding: const EdgeInsets.only(bottom: NovaSpace.md),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: NovaColors.gold, size: 22),
        const SizedBox(width: NovaSpace.md),
        Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
      ],
    ),
  );
  return showDialog<void>(
    context: context,
    builder: (c) => AlertDialog(
      title: Text(l.howToPlay),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            rule(Icons.view_column_rounded, l.rulesTableau),
            rule(Icons.emoji_events_outlined, l.rulesFoundation),
            rule(Icons.layers_rounded, l.rulesStock),
            rule(Icons.touch_app_rounded, l.rulesControls),
            rule(Icons.bolt_rounded, l.rulesCombo),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c), child: Text(l.ok)),
      ],
    ),
  );
}

/// Small red notification dot.
class RedDot extends StatelessWidget {
  const RedDot({super.key});
  @override
  Widget build(BuildContext context) => Container(
    width: 22,
    height: 22,
    decoration: BoxDecoration(
      color: NovaColors.danger,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: const Icon(Icons.add, size: 13, color: Colors.white),
  );
}

/// A row in key/value tables (stats, victory).
class StatRow extends StatelessWidget {
  const StatRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });
  final String label;
  final String value;
  final IconData? icon;
  @override
  Widget build(BuildContext context) => MergeSemantics(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: NovaColors.goldLight, size: 22),
            const SizedBox(width: NovaSpace.md),
          ],
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, color: NovaColors.ivory),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: NovaColors.ivory,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    ),
  );
}
