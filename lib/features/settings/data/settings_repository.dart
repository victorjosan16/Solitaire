import 'package:shared_preferences/shared_preferences.dart';

import '../domain/app_settings.dart';

class SettingsRepository {
  SettingsRepository(this._prefs);

  final SharedPreferences _prefs;
  static const _p = 'settings.';

  AppSettings load() {
    bool b(String k, bool d) => _prefs.getBool('$_p$k') ?? d;
    const d = AppSettings();
    final locale = _prefs.getString('${_p}locale');
    final draw = _prefs.getInt('${_p}draw');
    return AppSettings(
      localeCode: supportedLanguageCodes.contains(locale) ? locale : null,
      music: b('music', d.music),
      sound: b('sound', d.sound),
      haptics: b('haptics', d.haptics),
      reducedMotion: b('reducedMotion', d.reducedMotion),
      leftHanded: b('leftHanded', d.leftHanded),
      defaultDrawCount: draw == 3 ? 3 : 1,
      tapToFoundation: b('tapToFoundation', d.tapToFoundation),
      hintsEnabled: b('hintsEnabled', d.hintsEnabled),
      showTimer: b('showTimer', d.showTimer),
      unlimitedRecycles: b('unlimitedRecycles', d.unlimitedRecycles),
      allowFoundationToTableau: b(
        'allowFoundationToTableau',
        d.allowFoundationToTableau,
      ),
      cloudBackup: b('cloudBackup', d.cloudBackup),
      analyticsEnabled: b('analyticsEnabled', d.analyticsEnabled),
      personalizedAds: b('personalizedAds', d.personalizedAds),
      consentAnswered: b('consentAnswered', d.consentAnswered),
    );
  }

  Future<void> save(AppSettings s) async {
    final loc = s.localeCode;
    if (loc == null) {
      await _prefs.remove('${_p}locale');
    } else {
      await _prefs.setString('${_p}locale', loc);
    }
    await _prefs.setInt('${_p}draw', s.defaultDrawCount);
    final bools = {
      'music': s.music,
      'sound': s.sound,
      'haptics': s.haptics,
      'reducedMotion': s.reducedMotion,
      'leftHanded': s.leftHanded,
      'tapToFoundation': s.tapToFoundation,
      'hintsEnabled': s.hintsEnabled,
      'showTimer': s.showTimer,
      'unlimitedRecycles': s.unlimitedRecycles,
      'allowFoundationToTableau': s.allowFoundationToTableau,
      'cloudBackup': s.cloudBackup,
      'analyticsEnabled': s.analyticsEnabled,
      'personalizedAds': s.personalizedAds,
      'consentAnswered': s.consentAnswered,
    };
    for (final e in bools.entries) {
      await _prefs.setBool('$_p${e.key}', e.value);
    }
  }

  Future<void> clear() async {
    for (final k in _prefs.getKeys().where((k) => k.startsWith(_p))) {
      await _prefs.remove(k);
    }
  }
}
