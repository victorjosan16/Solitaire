import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:solitaire_nova/app/app.dart';
import 'package:solitaire_nova/app/l10n/l10n.dart';
import 'package:solitaire_nova/app/router/app_router.dart';
import 'package:solitaire_nova/features/achievements/domain/achievements.dart';
import 'package:solitaire_nova/features/customization/domain/cosmetics.dart';
import 'package:solitaire_nova/features/settings/domain/app_settings.dart';

import '../helpers/app_harness.dart';

void main() {
  test('every supported locale has a catalog and resolves', () {
    expect(
      AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet(),
      supportedLanguageCodes.toSet(),
    );
    expect(resolveLocale(null, const [Locale('ja')]), const Locale('en'));
    expect(resolveLocale(null, const [Locale('uk', 'UA')]), const Locale('uk'));
    expect(resolveLocale('pl', const [Locale('de')]), const Locale('pl'));
    expect(resolveLocale('xx', const [Locale('de')]), const Locale('de'));
  });

  test(
    'all achievements and cosmetics have localized names in every locale',
    () async {
      for (final code in supportedLanguageCodes) {
        final l = await AppLocalizations.delegate.load(Locale(code));
        for (final a in achievementCatalog) {
          expect(
            achievementTitle(l, a.id),
            isNot(a.id),
            reason: '$code ${a.id}',
          );
          expect(
            achievementDescription(l, a),
            isNotEmpty,
            reason: '$code ${a.id}',
          );
        }
        for (final c in cosmeticCatalog) {
          expect(cosmeticName(l, c.id), isNot(c.id), reason: '$code ${c.id}');
        }
        // Plurals resolve for typical counts.
        for (final n in [0, 1, 2, 5, 21, 22, 25, 100]) {
          expect(l.hintsLeft(n), isNotEmpty);
          expect(l.dailyStreak(n), isNotEmpty);
        }
      }
    },
  );

  for (final code in supportedLanguageCodes) {
    for (final scale in [1.0, 1.3]) {
      testWidgets('$code @${scale}x: key screens fit on a 320dp phone', (
        tester,
      ) async {
        tester.platformDispatcher.textScaleFactorTestValue = scale;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        final h = await pumpApp(
          tester,
          size: const Size(320, 640),
          prefs: {'settings.consentAnswered': true, 'settings.locale': code},
          route: Routes.home,
        );
        for (final r in [
          Routes.daily,
          Routes.shop,
          Routes.achievements,
          Routes.stats,
          Routes.themes,
          Routes.settings,
          Routes.home,
        ]) {
          h.router.go(r);
          await settle(tester, const Duration(milliseconds: 600));
          final e = tester.takeException();
          if (e is FlutterError) {
            fail('$r: ${e.toStringDeep()}');
          }
          expect(e, isNull, reason: r);
        }
        // Overflows/exceptions would have failed the test already.
        expect(tester.takeException(), isNull);
      });
    }
  }
}
