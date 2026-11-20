import 'package:flutter/widgets.dart';

/// Outcome of an opt-in rewarded ad. Rewards are granted ONLY on [earned],
/// using [rewardEventId] as the idempotency key.
sealed class RewardOutcome {
  const RewardOutcome();
}

class RewardEarned extends RewardOutcome {
  const RewardEarned(this.rewardEventId);
  final String rewardEventId;
}

/// Closed before the reward callback fired.
class RewardSkipped extends RewardOutcome {
  const RewardSkipped();
}

class RewardUnavailable extends RewardOutcome {
  const RewardUnavailable(this.reason);
  final AdUnavailableReason reason;
}

enum AdUnavailableReason { noFill, offline, consentDenied, disabled, error }

enum InterstitialPlacement { afterGameEnd, returnToMenu }

/// A loaded banner ready to be placed in the tree. The owner must call
/// [dispose] when the banner leaves the screen.
abstract class BannerSlot {
  double get height;
  Widget build();
  void dispose();
}

/// When the in-game banner may be visible (pure, unit-tested).
///
/// * Never during the first [graceMoves] moves of a game, so the deal and the
///   opening are ad-free.
/// * Once shown it stays for the rest of that game (no flicker on undo).
/// * Hidden as soon as the game is won (victory screen, menus: no banner).
class BannerPolicy {
  const BannerPolicy({this.graceMoves = 10});
  final int graceMoves;

  bool shouldShow({
    required int movesPlayed,
    required bool alreadyShownThisGame,
    required bool gameFinished,
  }) {
    if (gameFinished) return false;
    return alreadyShownThisGame || movesPlayed >= graceMoves;
  }
}

enum RewardPlacement { doubleVictoryCoins, hintPack, shuffle }

/// Ads abstraction. The game never depends on ads to function.
abstract class AdService {
  Future<void> initialize();

  /// Whether rewarded offers should be shown in the UI at all.
  bool get rewardedAvailable;

  Future<RewardOutcome> showRewarded(RewardPlacement placement);

  /// Shows an interstitial only if [InterstitialPolicy] allows it.
  Future<bool> maybeShowInterstitial(InterstitialPlacement placement);

  /// Informs the policy that a game finished (natural break point).
  void onGameFinished();

  /// Whether banners can be requested at all (configured + consent).
  bool get bannersAvailable;

  /// Loads a banner for a slot [widthDp] wide; null on no-fill/offline.
  Future<BannerSlot?> loadBanner(int widthDp);

  void dispose();
}

/// Frequency capping for interstitials (pure, unit-tested).
///
/// * Never during gameplay — callers only invoke at natural breaks.
/// * Never within [launchGrace] of app start (no ads on launch).
/// * At least [minGamesBetween] finished games and [cooldown] between ads.
/// * At most [maxPerSession] per app session.
class InterstitialPolicy {
  InterstitialPolicy({
    this.minGamesBetween = 3,
    this.cooldown = const Duration(minutes: 4),
    this.maxPerSession = 4,
    this.launchGrace = const Duration(minutes: 2),
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now {
    _sessionStart = _now();
  }

  final int minGamesBetween;
  final Duration cooldown;
  final int maxPerSession;
  final Duration launchGrace;
  final DateTime Function() _now;

  late final DateTime _sessionStart;
  DateTime? _lastShown;
  int _gamesSinceLast = 0;
  int _shownThisSession = 0;

  void recordGameFinished() => _gamesSinceLast++;

  bool canShow() {
    final now = _now();
    if (now.difference(_sessionStart) < launchGrace) return false;
    if (_shownThisSession >= maxPerSession) return false;
    if (_gamesSinceLast < minGamesBetween) return false;
    final last = _lastShown;
    if (last != null && now.difference(last) < cooldown) return false;
    return true;
  }

  void recordShown() {
    _lastShown = _now();
    _gamesSinceLast = 0;
    _shownThisSession++;
  }

  /// Applies remote overrides, clamped to policy-safe bounds.
  InterstitialPolicy withRemote({int? minGames, int? cooldownSeconds}) =>
      InterstitialPolicy(
        minGamesBetween: (minGames ?? minGamesBetween).clamp(2, 10),
        cooldown: Duration(
          seconds: (cooldownSeconds ?? cooldown.inSeconds).clamp(120, 3600),
        ),
        maxPerSession: maxPerSession,
        launchGrace: launchGrace,
        now: _now,
      );
}

/// No ads (tests, ad-free builds, unsupported platforms).
class DisabledAdService implements AdService {
  @override
  Future<void> initialize() async {}
  @override
  bool get rewardedAvailable => false;
  @override
  Future<RewardOutcome> showRewarded(RewardPlacement placement) async =>
      const RewardUnavailable(AdUnavailableReason.disabled);
  @override
  Future<bool> maybeShowInterstitial(InterstitialPlacement placement) async =>
      false;
  @override
  void onGameFinished() {}
  @override
  bool get bannersAvailable => false;
  @override
  Future<BannerSlot?> loadBanner(int widthDp) async => null;
  @override
  void dispose() {}
}

/// Scriptable fake for tests and UI demos.
class FakeAdService implements AdService {
  FakeAdService({
    this.nextOutcome = const RewardSkipped(),
    this.available = true,
  });

  RewardOutcome nextOutcome;
  bool available;
  int rewardedShown = 0;
  int interstitialsShown = 0;
  final InterstitialPolicy policy = InterstitialPolicy(
    launchGrace: Duration.zero,
    cooldown: Duration.zero,
  );

  @override
  Future<void> initialize() async {}
  @override
  bool get rewardedAvailable => available;
  @override
  Future<RewardOutcome> showRewarded(RewardPlacement placement) async {
    rewardedShown++;
    return nextOutcome;
  }

  @override
  Future<bool> maybeShowInterstitial(InterstitialPlacement placement) async {
    if (!policy.canShow()) return false;
    policy.recordShown();
    interstitialsShown++;
    return true;
  }

  @override
  void onGameFinished() => policy.recordGameFinished();

  /// Banners are off by default in tests; enable to exercise the layout.
  bool banners = false;
  int bannersLoaded = 0;

  @override
  bool get bannersAvailable => banners;

  @override
  Future<BannerSlot?> loadBanner(int widthDp) async {
    if (!banners) return null;
    bannersLoaded++;
    return _FakeBanner();
  }

  @override
  void dispose() {}
}

class _FakeBanner implements BannerSlot {
  @override
  double get height => 50;
  @override
  Widget build() => const SizedBox(
    height: 50,
    child: ColoredBox(
      color: Color(0xFF2B2F36),
      child: Center(
        child: Text('Test banner', style: TextStyle(color: Color(0xFFB0B6BE))),
      ),
    ),
  );
  @override
  void dispose() {}
}
