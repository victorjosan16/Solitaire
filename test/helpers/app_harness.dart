import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solitaire_nova/app/app.dart';
import 'package:solitaire_nova/app/router/app_router.dart';
import 'package:solitaire_nova/core/ads/ad_service.dart';
import 'package:solitaire_nova/core/database/json_document_store.dart';
import 'package:solitaire_nova/core/providers.dart';
import 'package:solitaire_nova/core/services/audio_service.dart';
import 'package:solitaire_nova/features/solitaire/domain/models/game_snapshot.dart';
import 'package:solitaire_nova/shared/models/profile.dart';

bool _fontsLoaded = false;

/// Loads real fonts so screenshots/goldens show actual glyphs instead of
/// the test "Ahem" boxes.
Future<void> loadAppFonts() async {
  if (_fontsLoaded) return;
  _fontsLoaded = true;
  final sdk =
      Platform.environment['FLUTTER_ROOT'] ??
      File(Platform.resolvedExecutable).parent.parent.parent.parent.parent.path;
  final materialFonts = '$sdk/bin/cache/artifacts/material_fonts';
  Future<void> family(String name, List<String> paths) async {
    final loader = FontLoader(name);
    var any = false;
    for (final p in paths) {
      final f = File(p);
      if (f.existsSync()) {
        any = true;
        loader.addFont(Future.value(ByteData.sublistView(f.readAsBytesSync())));
      }
    }
    if (any) await loader.load();
  }

  await family('Roboto', [
    '$materialFonts/Roboto-Regular.ttf',
    '$materialFonts/Roboto-Medium.ttf',
    '$materialFonts/Roboto-Bold.ttf',
    '$materialFonts/Roboto-Black.ttf',
  ]);
  await family('MaterialIcons', ['$materialFonts/MaterialIcons-Regular.otf']);
  await family('Cinzel', ['assets/fonts/Cinzel-Bold.ttf']);
  await family('Cormorant', [
    'assets/fonts/CormorantGaramond-SemiBold.ttf',
    'assets/fonts/CormorantGaramond-Bold.ttf',
  ]);
}

class Harness {
  Harness(this.container, this.dir, this.ads, this.audio);
  final ProviderContainer container;
  final Directory dir;
  final FakeAdService ads;
  final SilentAudioService audio;

  GoRouter get router => container.read(routerProvider);
}

/// Pumps the full app with test doubles. Data lives in a fresh temp dir
/// unless [dir] is given (to simulate a restart on the same storage).
Future<Harness> pumpApp(
  WidgetTester tester, {
  Size size = const Size(390, 844),
  double dpr = 2,
  String? route,
  Map<String, Object> prefs = const {'settings.consentAnswered': true},
  ProfileData? profile,
  GameSnapshot? game,
  Directory? dir,
  FakeAdService? ads,
  DateTime Function()? clock,
  List<Override> extra = const [],
}) async {
  await loadAppFonts();
  tester.view.physicalSize = size * dpr;
  tester.view.devicePixelRatio = dpr;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues(prefs);
  final sp = await SharedPreferences.getInstance();
  final d = dir ?? Directory.systemTemp.createTempSync('nova_widget');
  final store = JsonDocumentStore(d);
  final fakeAds = ads ?? FakeAdService();
  final audio = SilentAudioService();
  final container = ProviderContainer(
    overrides: [
      documentStoreProvider.overrideWithValue(store),
      sharedPreferencesProvider.overrideWithValue(sp),
      initialProfileProvider.overrideWithValue(profile ?? const ProfileData()),
      initialGameProvider.overrideWithValue(game),
      adServiceProvider.overrideWithValue(fakeAds),
      audioServiceProvider.overrideWithValue(audio),
      if (clock != null) clockProvider.overrideWithValue(clock),
      ...extra,
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const SolitaireNovaApp(),
    ),
  );
  await tester.pump();
  if (route != null) {
    container.read(routerProvider).go(route);
    await settle(tester);
  }
  return Harness(container, d, fakeAds, audio);
}

/// Like pumpAndSettle but bounded (Flame and confetti keep ticking).
Future<void> settle(
  WidgetTester tester, [
  Duration total = const Duration(milliseconds: 1600),
]) async {
  const step = Duration(milliseconds: 100);
  for (var t = Duration.zero; t < total; t += step) {
    await tester.pump(step);
  }
}
