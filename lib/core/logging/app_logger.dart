import 'dart:developer' as developer;

enum LogLevel { debug, info, warning, error }

/// Minimal structured logger. Never log personal data: callers pass event
/// names and technical fields only (ids are random, not user identifiers).
class AppLogger {
  AppLogger._();

  static final List<void Function(LogLevel, String, Map<String, Object?>)>
  _sinks = [];

  /// Extra sinks (e.g. a crash reporter breadcrumb trail).
  static void addSink(
    void Function(LogLevel, String, Map<String, Object?>) sink,
  ) => _sinks.add(sink);

  static void log(
    LogLevel level,
    String event, [
    Map<String, Object?> fields = const {},
    Object? error,
    StackTrace? stack,
  ]) {
    developer.log(
      fields.isEmpty ? event : '$event $fields',
      name: 'nova.${level.name}',
      level: switch (level) {
        LogLevel.debug => 500,
        LogLevel.info => 800,
        LogLevel.warning => 900,
        LogLevel.error => 1000,
      },
      error: error,
      stackTrace: stack,
    );
    for (final s in _sinks) {
      s(level, event, fields);
    }
  }

  static void d(String e, [Map<String, Object?> f = const {}]) =>
      log(LogLevel.debug, e, f);
  static void i(String e, [Map<String, Object?> f = const {}]) =>
      log(LogLevel.info, e, f);
  static void w(String e, [Map<String, Object?> f = const {}, Object? err]) =>
      log(LogLevel.warning, e, f, err);
  static void e(
    String e, [
    Map<String, Object?> f = const {},
    Object? err,
    StackTrace? st,
  ]) => log(LogLevel.error, e, f, err, st);
}
