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

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final s = ref.watch(settingsProvider);
    final ctrl = ref.read(settingsProvider.notifier);
    void set(AppSettings Function(AppSettings) f) => ctrl.update(f);

    Widget section(String title, List<Widget> children) => Padding(
      padding: const EdgeInsets.only(bottom: NovaSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              NovaSpace.sm,
              0,
              0,
              NovaSpace.sm,
            ),
            child: Semantics(
              header: true,
              child: Text(
                upperFor(context, title),
                style: const TextStyle(
                  letterSpacing: 1.2,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: NovaColors.gold,
                ),
              ),
            ),
          ),
          NovaPanel(
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
        ],
      ),
    );

    Widget toggle(
      IconData icon,
      String label,
      bool value,
      ValueChanged<bool> onChanged, {
      String? subtitle,
    }) => SwitchListTile(
      secondary: Icon(icon, color: NovaColors.goldLight),
      title: Text(label, style: const TextStyle(color: NovaColors.ivory)),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: const TextStyle(color: NovaColors.textMuted, fontSize: 12),
            ),
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
            section(l.settingsAudio, [
              toggle(
                Icons.music_note_rounded,
                l.music,
                s.music,
                (v) => set((x) => x.copyWith(music: v)),
              ),
              toggle(
                Icons.volume_up_rounded,
                l.sound,
                s.sound,
                (v) => set((x) => x.copyWith(sound: v)),
              ),
              toggle(
                Icons.vibration_rounded,
                l.haptics,
                s.haptics,
                (v) => set((x) => x.copyWith(haptics: v)),
              ),
            ]),
            section(l.settingsGameplay, [
              ListTile(
                leading: const Icon(
                  Icons.style_rounded,
                  color: NovaColors.goldLight,
                ),
                title: Text(
                  l.defaultDraw,
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
              toggle(
                Icons.front_hand_rounded,
                l.leftHanded,
                s.leftHanded,
                (v) => set((x) => x.copyWith(leftHanded: v)),
              ),
              toggle(
                Icons.touch_app_rounded,
                l.tapToFoundation,
                s.tapToFoundation,
                (v) => set((x) => x.copyWith(tapToFoundation: v)),
              ),
              toggle(
                Icons.lightbulb_outline_rounded,
                l.hintsSetting,
                s.hintsEnabled,
                (v) => set((x) => x.copyWith(hintsEnabled: v)),
              ),
              toggle(
                Icons.timer_outlined,
                l.showTimer,
                s.showTimer,
                (v) => set((x) => x.copyWith(showTimer: v)),
              ),
              toggle(
                Icons.all_inclusive_rounded,
                l.unlimitedPasses,
                s.unlimitedRecycles,
                (v) => set((x) => x.copyWith(unlimitedRecycles: v)),
                subtitle: '${l.limitedPassesNote} ${l.rulesNextGame}',
              ),
              toggle(
                Icons.undo_rounded,
                l.foundationMoves,
                s.allowFoundationToTableau,
                (v) => set((x) => x.copyWith(allowFoundationToTableau: v)),
                subtitle: l.rulesNextGame,
              ),
            ]),
            section(l.settingsDisplay, [
              toggle(
                Icons.motion_photos_off_outlined,
                l.reducedMotion,
                s.reducedMotion,
                (v) => set((x) => x.copyWith(reducedMotion: v)),
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
            section(l.settingsPrivacy, [
              toggle(
                Icons.analytics_outlined,
                l.analyticsSetting,
                s.analyticsEnabled,
                (v) => set((x) => x.copyWith(analyticsEnabled: v)),
              ),
              toggle(
                Icons.ads_click_rounded,
                l.personalizedAds,
                s.personalizedAds,
                (v) => set((x) => x.copyWith(personalizedAds: v)),
              ),
              link(Icons.privacy_tip_outlined, l.privacyChoices, () async {
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
              }),
              link(
                Icons.policy_outlined,
                l.privacyPolicy,
                () => showInfoDialog(
                  context,
                  title: l.privacyPolicy,
                  body: AppConfig.privacyPolicyUrl.isEmpty
                      ? l.privacyPolicyBody
                      : '${l.privacyPolicyBody}\n\n${AppConfig.privacyPolicyUrl}',
                  icon: Icons.policy_outlined,
                ),
              ),
            ]),
            section(l.settingsData, [
              toggle(Icons.cloud_outlined, l.cloudBackup, false, (v) async {
                if (!ref.read(cloudBackupProvider).isConfigured) {
                  await showInfoDialog(
                    context,
                    title: l.cloudBackup,
                    body: l.cloudBackupUnavailable,
                    icon: Icons.cloud_off_rounded,
                  );
                }
              }),
              link(
                Icons.person_outline_rounded,
                l.signIn,
                () => showInfoDialog(
                  context,
                  title: l.signIn,
                  body: l.cloudBackupUnavailable,
                  icon: Icons.cloud_off_rounded,
                ),
              ),
              link(
                Icons.restore_rounded,
                l.restorePurchases,
                () => showInfoDialog(
                  context,
                  title: l.restorePurchases,
                  body: l.restoreNone,
                  icon: Icons.restore_rounded,
                ),
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
                  await ref.read(gameControllerProvider.notifier).deleteAll();
                  await ref.read(profileProvider.notifier).deleteAll();
                  await ref.read(settingsProvider.notifier).reset();
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
            ]),
            section(l.settingsAbout, [
              link(
                Icons.menu_book_rounded,
                l.howToPlay,
                () => showHowToPlay(context),
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
              link(
                Icons.description_outlined,
                l.licenses,
                () => showLicensePage(
                  context: context,
                  applicationName: l.appTitle,
                  applicationVersion: AppConfig.appVersion,
                ),
              ),
            ]),
          ],
        ),
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
