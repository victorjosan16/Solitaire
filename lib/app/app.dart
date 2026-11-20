import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../features/settings/application/settings_controller.dart';
import '../features/settings/domain/app_settings.dart';
import 'l10n/l10n.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Resolves the UI locale: explicit setting → device locale if supported →
/// English.
Locale resolveLocale(String? setting, List<Locale>? device) {
  if (setting != null && supportedLanguageCodes.contains(setting)) {
    return Locale(setting);
  }
  for (final l in device ?? const <Locale>[]) {
    if (supportedLanguageCodes.contains(l.languageCode)) {
      return Locale(l.languageCode);
    }
  }
  return const Locale('en');
}

class SolitaireNovaApp extends ConsumerWidget {
  const SolitaireNovaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      onGenerateTitle: (c) => c.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.dark(),
      locale: settings.localeCode == null ? null : Locale(settings.localeCode!),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeListResolutionCallback: (locales, supported) =>
          resolveLocale(settings.localeCode, locales),
      routerConfig: router,
    );
  }
}
