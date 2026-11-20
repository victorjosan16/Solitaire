import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/settings_repository.dart';
import '../domain/app_settings.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(sharedPreferencesProvider)),
);

class SettingsController extends Notifier<AppSettings> {
  @override
  AppSettings build() => ref.read(settingsRepositoryProvider).load();

  Future<void> update(AppSettings Function(AppSettings s) change) async {
    state = change(state);
    _applySideEffects();
    await ref.read(settingsRepositoryProvider).save(state);
  }

  void _applySideEffects() {
    ref
        .read(audioServiceProvider)
        .configure(
          sound: state.sound,
          music: state.music,
          haptics: state.haptics,
        );
    ref.read(analyticsProvider).setEnabled(state.analyticsEnabled);
  }

  /// Called once after startup so services reflect persisted preferences.
  void applyAll() => _applySideEffects();

  Future<void> reset() async {
    await ref.read(settingsRepositoryProvider).clear();
    state = const AppSettings();
    _applySideEffects();
  }
}

final settingsProvider = NotifierProvider<SettingsController, AppSettings>(
  SettingsController.new,
);
