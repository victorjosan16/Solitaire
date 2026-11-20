import 'dart:async';
import 'dart:math';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../config/app_config.dart';
import '../logging/app_logger.dart';
import '../privacy/consent_service.dart';
import 'ad_service.dart';

/// Google Mobile Ads implementation. Test units in debug; production units
/// only via --dart-define (see [AppConfig]). No mediation is configured; if
/// LevelPlay or AdMob mediation is added later it must replace, not run in
/// parallel with, this service.
class AdMobAdService implements AdService {
  AdMobAdService({required this.consent, required this.personalized, InterstitialPolicy? policy})
    : policy = policy ?? InterstitialPolicy();

  final ConsentService consent;
  final bool Function() personalized;
  final InterstitialPolicy policy;
  bool _initialized = false;
  RewardedAd? _rewarded;
  InterstitialAd? _interstitial;
  final _rng = Random.secure();

  AdRequest get _request => AdRequest(nonPersonalizedAds: !personalized());

  @override
  Future<void> initialize() async {
    if (AppConfig.rewardedUnitId == null && AppConfig.interstitialUnitId == null) return;
    try {
      if (!await consent.canRequestAds()) return;
      await MobileAds.instance.initialize();
      _initialized = true;
      _loadRewarded();
      _loadInterstitial();
    } catch (e) {
      AppLogger.w('ads.init_failed', const {}, e);
    }
  }

  void _loadRewarded() {
    final id = AppConfig.rewardedUnitId;
    if (!_initialized || id == null || _rewarded != null) return;
    RewardedAd.load(
      adUnitId: id,
      request: _request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewarded = ad,
        onAdFailedToLoad: (e) => AppLogger.i('ads.rewarded_no_fill', {'code': e.code}),
      ),
    );
  }

  void _loadInterstitial() {
    final id = AppConfig.interstitialUnitId;
    if (!_initialized || id == null || _interstitial != null) return;
    InterstitialAd.load(
      adUnitId: id,
      request: _request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitial = ad,
        onAdFailedToLoad: (e) => AppLogger.i('ads.interstitial_no_fill', {'code': e.code}),
      ),
    );
  }

  @override
  bool get rewardedAvailable => _initialized && AppConfig.rewardedUnitId != null;

  @override
  Future<RewardOutcome> showRewarded(RewardPlacement placement) async {
    if (!_initialized) {
      final canAsk = await consent.canRequestAds();
      return RewardUnavailable(
        canAsk ? AdUnavailableReason.disabled : AdUnavailableReason.consentDenied,
      );
    }
    final ad = _rewarded;
    if (ad == null) {
      _loadRewarded();
      return const RewardUnavailable(AdUnavailableReason.noFill);
    }
    _rewarded = null;
    final done = Completer<RewardOutcome>();
    String? earnedId;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _loadRewarded();
        if (!done.isCompleted) {
          done.complete(earnedId != null ? RewardEarned(earnedId!) : const RewardSkipped());
        }
      },
      onAdFailedToShowFullScreenContent: (a, e) {
        a.dispose();
        _loadRewarded();
        if (!done.isCompleted) {
          done.complete(const RewardUnavailable(AdUnavailableReason.error));
        }
      },
    );
    await ad.show(
      onUserEarnedReward: (_, _) {
        // Unique per completed view: the idempotency key for the grant.
        earnedId = '${placement.name}-${DateTime.now().microsecondsSinceEpoch}-${_rng.nextInt(1 << 32)}';
      },
    );
    return done.future;
  }

  @override
  Future<bool> maybeShowInterstitial(InterstitialPlacement placement) async {
    final ad = _interstitial;
    if (ad == null || !policy.canShow()) {
      _loadInterstitial();
      return false;
    }
    _interstitial = null;
    policy.recordShown();
    final done = Completer<bool>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _loadInterstitial();
        if (!done.isCompleted) done.complete(true);
      },
      onAdFailedToShowFullScreenContent: (a, _) {
        a.dispose();
        _loadInterstitial();
        if (!done.isCompleted) done.complete(false);
      },
    );
    await ad.show();
    return done.future;
  }

  @override
  void onGameFinished() => policy.recordGameFinished();

  @override
  void dispose() {
    _rewarded?.dispose();
    _interstitial?.dispose();
  }
}
