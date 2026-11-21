import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../../app/theme/tokens.dart';
import '../../../core/config/app_config.dart';
import '../../../core/providers.dart';
import '../../../shared/widgets/nova_dialogs.dart';
import '../../../shared/widgets/nova_logo.dart';
import '../../../shared/widgets/nova_widgets.dart';
import '../../solitaire/application/game_controller.dart';
import '../../statistics/application/profile_controller.dart';
import '../application/settings_controller.dart';
import '../domain/app_settings.dart';

/// Deliberately minimal settings. Everything else uses sensible defaults
/// (classic rules, unlimited stock passes, hints on, timer on, OS
/// reduced-motion respected).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final s = ref.watch(settingsProvider);
    final ctrl = ref.read(settingsProvider.notifier);
    void set(AppSettings Function(AppSettings) f) => ctrl.update(f);

    Widget toggle(
      IconData icon,
      String label,
      bool value,
      ValueChanged<bool> onChanged,
    ) => SwitchListTile(
      secondary: Icon(icon, color: NovaColors.goldLight),
      title: Text(label, style: const TextStyle(color: NovaColors.ivory)),
      value: value,
      onChanged: onChanged,
    );

    Widget link(
      IconData icon,
      String label,
      VoidCallback onTap, {
      String? trailing,
    }) => ListTile(
      leading: Icon(icon, color: NovaColors.goldLight),
      title: Text(label, style: const TextStyle(color: NovaColors.ivory)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null)
            Text(
              trailing,
              style: const TextStyle(color: NovaColors.textSecondary),
            ),
          const Icon(Icons.chevron_right_rounded, color: NovaColors.goldLight),
        ],
      ),
      onTap: onTap,
    );

    Widget group(List<Widget> children) => Padding(
      padding: const EdgeInsets.only(bottom: NovaSpace.lg),
      child: NovaPanel(
        padding: const EdgeInsets.symmetric(vertical: NovaSpace.xs),
        child: Column(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0) const Divider(indent: 56),
              children[i],
            ],
          ],
        ),
      ),
    );

    return NovaScaffold(
      title: l.settings,
      onBack: () => context.pop(),
      body: MaxWidth(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            NovaSpace.lg,
            NovaSpace.sm,
            NovaSpace.lg,
            NovaSpace.xl,
          ),
          children: [
            group([
              toggle(
                Icons.volume_up_rounded,
                l.sound,
                s.sound,
                (v) => set((x) => x.copyWith(sound: v)),
              ),
              toggle(
                Icons.music_note_rounded,
                l.music,
                s.music,
                (v) => set((x) => x.copyWith(music: v)),
              ),
              toggle(
                Icons.vibration_rounded,
                l.haptics,
                s.haptics,
                (v) => set((x) => x.copyWith(haptics: v)),
              ),
            ]),
            group([
              ListTile(
                leading: const Icon(
                  Icons.style_rounded,
                  color: NovaColors.goldLight,
                ),
                title: Text(
                  l.gameModeSetting,
                  style: const TextStyle(color: NovaColors.ivory),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: NovaSpace.sm),
                  child: NovaTabs(
                    labels: [l.drawOne, l.drawThree],
                    selected: s.defaultDrawCount == 3 ? 1 : 0,
                    onChanged: (i) => set(
                      (x) => x.copyWith(defaultDrawCount: i == 1 ? 3 : 1),
                    ),
                  ),
                ),
              ),
              link(
                Icons.language_rounded,
                l.language,
                () => _pickLanguage(context, ref),
                trailing: s.localeCode == null
                    ? l.languageSystem
                    : languageEndonyms[s.localeCode],
              ),
            ]),
            group([
              link(
                Icons.menu_book_rounded,
                l.howToPlay,
                () => showHowToPlay(context),
              ),
              link(
                Icons.privacy_tip_outlined,
                l.settingsPrivacy,
                () => _privacySheet(context, ref),
              ),
              link(
                Icons.info_outline_rounded,
                l.about,
                () => showAboutDialog(
                  context: context,
                  applicationName: l.appTitle,
                  applicationVersion: l.version(AppConfig.appVersion),
                  applicationIcon: SizedBox(
                    width: 56,
                    height: 40,
                    child: CustomPaint(painter: CrownPainter()),
                  ),
                  children: [Text(l.aboutBody)],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  /// Privacy policy, ad choices, anonymous statistics and data deletion.
  Future<void> _privacySheet(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: NovaColors.emeraldDeep,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(NovaRadius.lg),
        ),
      ),
      builder: (sheet) => Consumer(
        builder: (context, ref, _) {
          final s = ref.watch(settingsProvider);
          final ctrl = ref.read(settingsProvider.notifier);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: NovaSpace.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l.settingsPrivacy,
                    style: const TextStyle(
                      fontFamily: NovaFonts.display,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: NovaColors.goldLight,
                    ),
                  ),
                  const SizedBox(height: NovaSpace.sm),
                  ListTile(
                    leading: const Icon(
                      Icons.policy_outlined,
                      color: NovaColors.goldLight,
                    ),
                    title: Text(
                      l.privacyPolicy,
                      style: const TextStyle(color: NovaColors.ivory),
                    ),
                    onTap: () => showInfoDialog(
                      context,
                      title: l.privacyPolicy,
                      body:
                          '${l.privacyPolicyBody}\n\n${AppConfig.privacyPolicyUrl}',
                      icon: Icons.policy_outlined,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.ads_click_rounded,
                      color: NovaColors.goldLight,
                    ),
                    title: Text(
                      l.privacyChoices,
                      style: const TextStyle(color: NovaColors.ivory),
                    ),
                    onTap: () async {
                      final consent = ref.read(consentServiceProvider);
                      if (await consent.privacyOptionsRequired()) {
                        await consent.showPrivacyOptions();
                      } else if (context.mounted) {
                        await showInfoDialog(
                          context,
                          title: l.privacyChoices,
                          body: l.consentBody,
                          icon: Icons.privacy_tip_outlined,
                        );
                      }
                    },
                  ),
                  SwitchListTile(
                    secondary: const Icon(
                      Icons.ads_click_outlined,
                      color: NovaColors.goldLight,
                    ),
                    title: Text(
                      l.personalizedAds,
                      style: const TextStyle(color: NovaColors.ivory),
                    ),
                    value: s.personalizedAds,
                    onChanged: (v) =>
                        ctrl.update((x) => x.copyWith(personalizedAds: v)),
                  ),
                  SwitchListTile(
                    secondary: const Icon(
                      Icons.analytics_outlined,
                      color: NovaColors.goldLight,
                    ),
                    title: Text(
                      l.analyticsSetting,
                      style: const TextStyle(color: NovaColors.ivory),
                    ),
                    value: s.analyticsEnabled,
                    onChanged: (v) =>
                        ctrl.update((x) => x.copyWith(analyticsEnabled: v)),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.delete_forever_rounded,
                      color: Color(0xFFFF8A80),
                    ),
                    title: Text(
                      l.deleteData,
                      style: const TextStyle(color: Color(0xFFFF8A80)),
                    ),
                    onTap: () async {
                      final ok = await showConfirmDialog(
                        context,
                        title: l.deleteDataTitle,
                        body: l.deleteDataBody,
                        confirmLabel: l.delete,
                        destructive: true,
                      );
                      if (!ok) return;
                      await ref
                          .read(gameControllerProvider.notifier)
                          .deleteAll();
                      await ref.read(profileProvider.notifier).deleteAll();
                      await ref.read(settingsProvider.notifier).reset();
                      if (sheet.mounted) Navigator.of(sheet).pop();
                      if (context.mounted) {
                        showNovaSnack(
                          context,
                          l.deleteDataDone,
                          icon: Icons.check_circle_outline,
                        );
                        context.go(Routes.home);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.description_outlined,
                      color: NovaColors.goldLight,
                    ),
                    title: Text(
                      l.licenses,
                      style: const TextStyle(color: NovaColors.ivory),
                    ),
                    onTap: () => showLicensePage(
                      context: context,
                      applicationName: l.appTitle,
                      applicationVersion: AppConfig.appVersion,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickLanguage(BuildContext context, WidgetRef ref) async {
    final l = context.l10n;
    final current = ref.read(settingsProvider).localeCode;
    final choice = await showDialog<String>(
      context: context,
      builder: (c) => SimpleDialog(
        title: Text(l.language),
        children: [
          RadioGroup<String>(
            groupValue: current ?? '',
            onChanged: (v) => Navigator.pop(c, v),
            child: Column(
              children: [
                RadioListTile<String>(value: '', title: Text(l.languageSystem)),
                for (final code in supportedLanguageCodes)
                  RadioListTile<String>(
                    value: code,
                    title: Text(languageEndonyms[code]!),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
    if (choice == null) return;
    await ref
        .read(settingsProvider.notifier)
        .update(
          (s) => s.copyWith(localeCode: () => choice.isEmpty ? null : choice),
        );
  }
}
