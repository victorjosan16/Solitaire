import 'package:firebase_analytics/firebase_analytics.dart';

import '../logging/app_logger.dart';
import 'analytics_service.dart';

/// Firebase Analytics adapter. Collection starts disabled (manifest flag) and
/// is switched on only when the player accepted analytics in the privacy
/// prompt or settings. Events carry no personal data.
class FirebaseAnalyticsService implements AnalyticsService {
  FirebaseAnalyticsService([FirebaseAnalytics? analytics])
    : _fa = analytics ?? FirebaseAnalytics.instance;

  final FirebaseAnalytics _fa;
  bool _enabled = false;

  @override
  void setEnabled(bool enabled) {
    _enabled = enabled;
    _guard('setEnabled', () async {
      await _fa.setConsent(
        analyticsStorageConsentGranted: enabled,
        adStorageConsentGranted: enabled,
      );
      await _fa.setAnalyticsCollectionEnabled(enabled);
    });
  }

  @override
  void logEvent(String name, [Map<String, Object> params = const {}]) {
    if (!_enabled) return;
    final clean = <String, Object>{
      for (final e in params.entries)
        e.key: switch (e.value) {
          final bool b => b ? 1 : 0,
          final num n => n,
          final v => v.toString(),
        },
    };
    _guard(name, () => _fa.logEvent(name: name, parameters: clean));
  }

  void _guard(String what, Future<void> Function() f) {
    f().catchError((Object e, StackTrace st) {
      AppLogger.e('analytics.firebase', {'op': what}, e, st);
    });
  }
}
