import 'package:flutter/foundation.dart';

/// Build-time configuration via `--dart-define` (never commit real IDs).
///
///   flutter build appbundle \
///     --dart-define=ADMOB_REWARDED_ANDROID=ca-app-pub-xxx/yyy \
///     --dart-define=ADMOB_INTERSTITIAL_ANDROID=ca-app-pub-xxx/zzz ...
///
/// In debug/profile builds Google's public *test* ad units are used. In
/// release builds ads are disabled unless production IDs are supplied, so a
/// misconfigured release can never serve test ads or crash.
class AppConfig {
  const AppConfig._();

  static const _rewardedAndroid = String.fromEnvironment(
    'ADMOB_REWARDED_ANDROID',
  );
  static const _rewardedIos = String.fromEnvironment('ADMOB_REWARDED_IOS');
  static const _interstitialAndroid = String.fromEnvironment(
    'ADMOB_INTERSTITIAL_ANDROID',
  );
  static const _interstitialIos = String.fromEnvironment(
    'ADMOB_INTERSTITIAL_IOS',
  );

  /// Set `--dart-define=ADS_ENABLED=false` to ship an ad-free build.
  static const adsEnabledFlag = bool.fromEnvironment(
    'ADS_ENABLED',
    defaultValue: true,
  );

  static const privacyPolicyUrl = String.fromEnvironment(
    'PRIVACY_POLICY_URL',
    defaultValue: '',
  );

  // Google's documented public test ad units.
  static const _testRewardedAndroid = 'ca-app-pub-3940256099942544/5224354917';
  static const _testRewardedIos = 'ca-app-pub-3940256099942544/1712485313';
  static const _testInterstitialAndroid =
      'ca-app-pub-3940256099942544/1033173712';
  static const _testInterstitialIos = 'ca-app-pub-3940256099942544/4411468910';

  static bool get _isIos => defaultTargetPlatform == TargetPlatform.iOS;

  static String? get rewardedUnitId => _pick(
    _isIos ? _rewardedIos : _rewardedAndroid,
    _isIos ? _testRewardedIos : _testRewardedAndroid,
  );

  static String? get interstitialUnitId => _pick(
    _isIos ? _interstitialIos : _interstitialAndroid,
    _isIos ? _testInterstitialIos : _testInterstitialAndroid,
  );

  static bool get usingTestAds =>
      !kReleaseMode && (_isIos ? _rewardedIos : _rewardedAndroid).isEmpty;

  static String? _pick(String prod, String test) {
    if (!adsEnabledFlag) return null;
    if (prod.isNotEmpty) return prod;
    return kReleaseMode ? null : test;
  }

  static const appVersion = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: '0.1.0',
  );
}
