/// User preferences (lightweight, stored in SharedPreferences).
class AppSettings {
  const AppSettings({
    this.localeCode,
    this.music = false,
    this.sound = true,
    this.haptics = true,
    this.reducedMotion = false,
    this.leftHanded = false,
    this.defaultDrawCount = 1,
    this.tapToFoundation = true,
    this.hintsEnabled = true,
    this.showTimer = true,
    this.unlimitedRecycles = true,
    this.allowFoundationToTableau = true,
    this.cloudBackup = false,
    this.analyticsEnabled = false,
    this.personalizedAds = false,
    this.consentAnswered = false,
  });

  /// `null` → follow the device locale when supported, else English.
  final String? localeCode;
  final bool music;
  final bool sound;
  final bool haptics;
  final bool reducedMotion;
  final bool leftHanded;
  final int defaultDrawCount;

  /// Tap-to-move prefers foundations over tableau targets.
  final bool tapToFoundation;
  final bool hintsEnabled;
  final bool showTimer;

  /// When false, Draw 1 allows 2 recycles and Draw 3 allows 3 (documented).
  final bool unlimitedRecycles;
  final bool allowFoundationToTableau;
  final bool cloudBackup;
  final bool analyticsEnabled;
  final bool personalizedAds;
  final bool consentAnswered;

  AppSettings copyWith({
    String? Function()? localeCode,
    bool? music,
    bool? sound,
    bool? haptics,
    bool? reducedMotion,
    bool? leftHanded,
    int? defaultDrawCount,
    bool? tapToFoundation,
    bool? hintsEnabled,
    bool? showTimer,
    bool? unlimitedRecycles,
    bool? allowFoundationToTableau,
    bool? cloudBackup,
    bool? analyticsEnabled,
    bool? personalizedAds,
    bool? consentAnswered,
  }) => AppSettings(
    localeCode: localeCode != null ? localeCode() : this.localeCode,
    music: music ?? this.music,
    sound: sound ?? this.sound,
    haptics: haptics ?? this.haptics,
    reducedMotion: reducedMotion ?? this.reducedMotion,
    leftHanded: leftHanded ?? this.leftHanded,
    defaultDrawCount: defaultDrawCount ?? this.defaultDrawCount,
    tapToFoundation: tapToFoundation ?? this.tapToFoundation,
    hintsEnabled: hintsEnabled ?? this.hintsEnabled,
    showTimer: showTimer ?? this.showTimer,
    unlimitedRecycles: unlimitedRecycles ?? this.unlimitedRecycles,
    allowFoundationToTableau:
        allowFoundationToTableau ?? this.allowFoundationToTableau,
    cloudBackup: cloudBackup ?? this.cloudBackup,
    analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
    personalizedAds: personalizedAds ?? this.personalizedAds,
    consentAnswered: consentAnswered ?? this.consentAnswered,
  );
}

/// Supported UI languages, English first (default / fallback).
const supportedLanguageCodes = [
  'en', 'ro', 'ru', 'uk', 'de', 'fr', 'es', 'it', 'pt', 'pl',
];

/// Endonyms shown in the language picker (not translated on purpose).
const languageEndonyms = {
  'en': 'English',
  'ro': 'Română',
  'ru': 'Русский',
  'uk': 'Українська',
  'de': 'Deutsch',
  'fr': 'Français',
  'es': 'Español',
  'it': 'Italiano',
  'pt': 'Português',
  'pl': 'Polski',
};
