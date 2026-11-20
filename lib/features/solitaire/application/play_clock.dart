/// Accumulates *active* play time only. The game controller pauses it when
/// the app is backgrounded, a menu/dialog is open, or the game is over, so
/// there is never more than one running interval (no double timers).
class PlayClock {
  PlayClock({DateTime Function()? now, int initialElapsedMs = 0})
    : _now = now ?? DateTime.now,
      _accumulatedMs = initialElapsedMs;

  final DateTime Function() _now;
  int _accumulatedMs;
  DateTime? _runningSince;

  bool get isRunning => _runningSince != null;

  void start() {
    _runningSince ??= _now();
  }

  void pause() {
    final since = _runningSince;
    if (since == null) return;
    final delta = _now().difference(since).inMilliseconds;
    // Guard against wall-clock jumps backwards.
    if (delta > 0) _accumulatedMs += delta;
    _runningSince = null;
  }

  int get elapsedMs {
    final since = _runningSince;
    if (since == null) return _accumulatedMs;
    final delta = _now().difference(since).inMilliseconds;
    return _accumulatedMs + (delta > 0 ? delta : 0);
  }

  Duration get elapsed => Duration(milliseconds: elapsedMs);

  void reset([int ms = 0]) {
    _accumulatedMs = ms;
    _runningSince = null;
  }
}
