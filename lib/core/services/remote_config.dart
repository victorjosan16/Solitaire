/// Remote Config abstraction with safe local defaults. A Firebase Remote
/// Config adapter may override values; all values are clamped by consumers
/// (e.g. [InterstitialPolicy.withRemote]).
abstract class RemoteConfigService {
  int getInt(String key);
}

class LocalRemoteConfig implements RemoteConfigService {
  const LocalRemoteConfig([this.overrides = const {}]);
  final Map<String, int> overrides;

  static const defaults = {
    'interstitial_min_games': 2,
    'interstitial_cooldown_s': 240,
  };

  @override
  int getInt(String key) => overrides[key] ?? defaults[key] ?? 0;
}
