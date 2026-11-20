import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/solitaire/domain/models/game_snapshot.dart';
import '../shared/models/profile.dart';
import 'ads/ad_service.dart';
import 'analytics/analytics_service.dart';
import 'database/json_document_store.dart';
import 'privacy/consent_service.dart';
import 'services/audio_service.dart';
import 'services/cloud_backup.dart';
import 'services/remote_config.dart';

/// Infrastructure providers. All are overridden in `bootstrap.dart` (and in
/// tests) so nothing below reaches a platform channel implicitly.
Never _missing(String name) =>
    throw UnimplementedError('$name must be overridden in ProviderScope');

final documentStoreProvider = Provider<JsonDocumentStore>(
  (ref) => _missing('documentStoreProvider'),
);
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => _missing('sharedPreferencesProvider'),
);

/// Data loaded before the first frame (local only, a few milliseconds).
final initialProfileProvider = Provider<ProfileData>(
  (ref) => const ProfileData(),
);
final initialGameProvider = Provider<GameSnapshot?>((ref) => null);

final adServiceProvider = Provider<AdService>((ref) => DisabledAdService());
final consentServiceProvider = Provider<ConsentService>(
  (ref) => NoConsentService(),
);
final analyticsProvider = Provider<AnalyticsService>(
  (ref) => LocalAnalyticsService(),
);
final crashReporterProvider = Provider<CrashReporter>(
  (ref) => LogCrashReporter(),
);
final audioServiceProvider = Provider<AudioService>(
  (ref) => SilentAudioService(),
);
final cloudBackupProvider = Provider<CloudBackupService>(
  (ref) => UnavailableCloudBackup(),
);
final remoteConfigProvider = Provider<RemoteConfigService>(
  (ref) => const LocalRemoteConfig(),
);

/// Injectable wall clock (tests freeze time).
final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

/// Randomness for deal selection and ids (tests inject a seeded Random).
final randomProvider = Provider<Random>((ref) => Random.secure());
