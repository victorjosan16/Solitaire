import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solitaire_nova/core/ads/ad_service.dart';
import 'package:solitaire_nova/core/database/json_document_store.dart';
import 'package:solitaire_nova/core/providers.dart';
import 'package:solitaire_nova/core/services/audio_service.dart';
import 'package:solitaire_nova/features/solitaire/data/game_repository.dart';
import 'package:solitaire_nova/features/statistics/data/profile_repository.dart';

/// Mutable fake clock for deterministic timing tests.
class FakeClock {
  FakeClock([DateTime? start]) : now = start ?? DateTime(2026, 11, 20, 12);
  DateTime now;
  void advance(Duration d) => now = now.add(d);
  DateTime call() => now;
}

/// Builds a container the way bootstrap does: loading persisted documents
/// from [dir] first (so a second call simulates an app restart).
Future<ProviderContainer> makeContainer(
  Directory dir, {
  FakeClock? clock,
  AdService? ads,
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final sp = await SharedPreferences.getInstance();
  final store = JsonDocumentStore(dir);
  final profile = await ProfileRepository(store).load();
  final game = await GameRepository(store).loadCurrent();
  final c = ProviderContainer(
    overrides: [
      documentStoreProvider.overrideWithValue(store),
      sharedPreferencesProvider.overrideWithValue(sp),
      initialProfileProvider.overrideWithValue(profile),
      initialGameProvider.overrideWithValue(game),
      audioServiceProvider.overrideWithValue(SilentAudioService()),
      adServiceProvider.overrideWithValue(ads ?? DisabledAdService()),
      if (clock != null) clockProvider.overrideWithValue(clock.call),
    ],
  );
  return c;
}
