import 'package:flutter/foundation.dart';

/// Ad and app configuration.
///
/// AdMob ids are not secrets (they ship inside every APK), so the production
/// Android ids live here. Rules:
/// * debug / profile builds → Google's public TEST units (never click your
///   own live ads);
/// * release builds → the production units below;
/// * any id can be overridden with `--dart-define=ADMOB_..._ANDROID=...`;
/// * `--dart-define=ADS_ENABLED=false` builds an ad-free app.
///
/// Interstitials (full-screen ads between games) are intentionally NOT used.
class AppConfig {
  const AppConfig._();

  // ---------------------------------------------------- production (AdMob)
  /// Android AdMob APP id (also set in android/app/build.gradle.kts).
  static const admobAppIdAndroid = 'ca-app-pub-4151706326405945~7945466753';
  static const _prodBannerAndroid = 'ca-app-pub-4151706326405945/4002352310';
  static const _prodRewardedAndroid = 'ca-app-pub-4151706326405945/8647128151';
  // iOS ids: add when the iOS app is created in AdMob.
  static const _prodBannerIos = '';
  static const _prodRewardedIos = '';

  // ------------------------------------------------------------ overrides
  static const _rewardedAndroid = String.fromEnvironment(
    'ADMOB_REWARDED_ANDROID',
  );
  static const _rewardedIos = String.fromEnvironment('ADMOB_REWARDED_IOS');
  static const _bannerAndroid = String.fromEnvironment('ADMOB_BANNER_ANDROID');
  static const _bannerIos = String.fromEnvironment('ADMOB_BANNER_IOS');

  /// Set `--dart-define=ADS_ENABLED=false` to ship an ad-free build.
  static const adsEnabledFlag = bool.fromEnvironment(
    'ADS_ENABLED',
    defaultValue: true,
  );

  static const privacyPolicyUrl = String.fromEnvironment(
    'PRIVACY_POLICY_URL',
    defaultValue: 'https://victorjosan16.github.io/privacy/',
  );

  // ------------------------------------------- Google's public test units
  static const _testRewardedAndroid = 'ca-app-pub-3940256099942544/5224354917';
  static const _testRewardedIos = 'ca-app-pub-3940256099942544/1712485313';
  static const _testBannerAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static const _testBannerIos = 'ca-app-pub-3940256099942544/2934735716';

  static bool get _isIos => defaultTargetPlatform == TargetPlatform.iOS;

  static String? get rewardedUnitId => _pick(
    _isIos ? _rewardedIos : _rewardedAndroid,
    _isIos ? _prodRewardedIos : _prodRewardedAndroid,
    _isIos ? _testRewardedIos : _testRewardedAndroid,
  );

  static String? get bannerUnitId => _pick(
    _isIos ? _bannerIos : _bannerAndroid,
    _isIos ? _prodBannerIos : _prodBannerAndroid,
    _isIos ? _testBannerIos : _testBannerAndroid,
  );

  /// Interstitials are not used in Solitaire Nova.
  static String? get interstitialUnitId => null;

  static bool get usingTestAds => !kReleaseMode;

  static String? _pick(String override, String production, String test) {
    if (!adsEnabledFlag) return null;
    if (override.isNotEmpty) return override;
    if (!kReleaseMode) return test;
    return production.isEmpty ? null : production;
  }

  static const appVersion = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: '1.0.0',
  );
}
