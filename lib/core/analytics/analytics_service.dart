import '../logging/app_logger.dart';

/// Analytics abstraction. Events carry no personal data. The concrete
/// Firebase Analytics adapter is an integration step (see README); the
/// default build logs locally and only when the player opted in.
abstract class AnalyticsService {
  void setEnabled(bool enabled);
  void logEvent(String name, [Map<String, Object> params = const {}]);
}

class LocalAnalyticsService implements AnalyticsService {
  bool _enabled = false;
  final List<String> recent = [];

  @override
  void setEnabled(bool enabled) => _enabled = enabled;

  @override
  void logEvent(String name, [Map<String, Object> params = const {}]) {
    if (!_enabled) return;
    recent.add(name);
    if (recent.length > 50) recent.removeAt(0);
    AppLogger.d('analytics.$name', params);
  }
}

/// Crash reporting abstraction (Crashlytics adapter is optional).
abstract class CrashReporter {
  void recordError(Object error, StackTrace? stack, {bool fatal = false});
}

class LogCrashReporter implements CrashReporter {
  @override
  void recordError(Object error, StackTrace? stack, {bool fatal = false}) =>
      AppLogger.e('crash', {'fatal': fatal}, error, stack);
}
