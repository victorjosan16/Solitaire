import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/ads/ad_service.dart';
import 'core/ads/admob_ad_service.dart';
import 'core/analytics/analytics_service.dart';
import 'core/config/app_config.dart';
import 'core/database/json_document_store.dart';
import 'core/logging/app_logger.dart';
import 'core/privacy/consent_service.dart';
import 'core/providers.dart';
import 'core/services/audio_service.dart';
import 'features/solitaire/data/game_repository.dart';
import 'features/statistics/data/profile_repository.dart';

/// Loads local data (no network), wires services and starts the app.
/// Firebase is intentionally not initialised here; see README "Firebase".
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final crash = LogCrashReporter();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    crash.recordError(details.exception, details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    crash.recordError(error, stack, fatal: true);
    return true;
  };
  LicenseRegistry.addLicense(() async* {
    final ofl = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['Cinzel', 'Cormorant Garamond'], ofl);
  });

  final prefs = await SharedPreferences.getInstance();
  final docsDir = await getApplicationSupportDirectory();
  final store = JsonDocumentStore(Directory('${docsDir.path}/nova'));
  final profile = await ProfileRepository(store).load();
  final game = await GameRepository(store).loadCurrent();
  AppLogger.i('bootstrap.loaded', {
    'resumable': game != null && !game.finished,
  });

  final consent = UmpConsentService();
  final container = ProviderContainer(
    overrides: [
      documentStoreProvider.overrideWithValue(store),
      sharedPreferencesProvider.overrideWithValue(prefs),
      initialProfileProvider.overrideWithValue(profile),
      initialGameProvider.overrideWithValue(game),
      consentServiceProvider.overrideWithValue(consent),
      crashReporterProvider.overrideWithValue(crash),
      audioServiceProvider.overrideWithValue(AudioplayersAudioService()),
      adServiceProvider.overrideWith((ref) {
        if (!AppConfig.adsEnabledFlag ||
            kIsWeb ||
            !(Platform.isAndroid || Platform.isIOS)) {
          return DisabledAdService();
        }
        final svc = AdMobAdService(
          consent: consent,
          personalized: () =>
              prefs.getBool('settings.personalizedAds') ?? false,
        );
        ref.onDispose(svc.dispose);
        return svc;
      }),
    ],
  );
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SolitaireNovaApp(),
    ),
  );
}
