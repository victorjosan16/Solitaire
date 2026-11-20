# Solitaire Nova

Premium classic **Klondike Solitaire** for Android and iOS, built with Flutter + Flame.
Midnight Emerald / Midnight Gold design, 10 languages, fully offline, no gambling.

| | |
|---|---|
| Flutter / Dart | 3.50.1 stable / 3.14.0 |
| Board renderer | Flame 1.38 |
| State / navigation | flutter_riverpod 3.5, go_router 18 |
| Persistence | atomic JSON document store (see [ARCHITECTURE](docs/ARCHITECTURE.md#persistence)) + shared_preferences |
| Ads | google_mobile_ads 9.2 behind `AdService` (test ads in debug) |
| Audio | audioplayers 6.8 (original synthesized assets) |
| Localization | gen-l10n, ARB: en (default), ro, ru, uk, de, fr, es, it, pt, pl |

Design references: `docs/design/reference_screens.png`, `docs/design/reference_ui_kit.png`.
The implementation follows them closely but is not a pixel copy; all art (cards,
suits, scenes, icon, sounds) is original and generated in code or by scripts in `tool/`.

## Features
- Complete Klondike: Draw 1 / Draw 3, unlimited or limited stock passes, optional
  foundation→tableau, tap-to-move, drag & drop with legal-target highlights, unlimited
  undo, restart same deal, hints that never suggest pointless stock cycling, safe Auto Finish.
- **Random deals** and **Winning deals**: winning deals and daily challenges come only from
  600 seeds that the bundled solver solved *and* whose solutions were replayed through the
  engine (`lib/features/solitaire/domain/engine/verified_seeds.dart`).
- Ten screens: Splash, Home, Game, Victory, Daily Challenge, Themes, Statistics,
  Achievements (36), Shop, Settings — plus pause/confirm/no-moves/out-of-hints/insufficient
  coins/offline/ad unavailable/consent/restore/cloud-conflict/error/delete dialogs.
- Resume after process death: every action is saved atomically; finished-but-unrecorded
  wins are re-recorded idempotently on next launch.
- Virtual coins (no cash value) earned by wins, daily challenges and achievements; spent on
  cosmetics and hint packs. Every grant is idempotent (ledger keys).
- Accessibility: semantics overlay so TalkBack/VoiceOver users can play the Flame board
  by tap-to-move, reduced motion, high-contrast table, large-text tested to 1.3×,
  left-handed layout.

## Setup
```bash
flutter --version          # 3.50.1 stable expected
flutter pub get
flutter gen-l10n           # also runs automatically on build (generate: true)
```

## Run
```bash
flutter run                       # debug: Google test ad units, no credentials needed
flutter run --dart-define=ADS_ENABLED=false   # ad-free
```

## Test
```bash
dart format --output=none --set-exit-if-changed lib test tool
flutter analyze
flutter test --exclude-tags golden      # unit, widget, integration-style
flutter test --tags golden              # screenshot goldens (Linux rendering)
flutter test --tags golden --update-goldens   # regenerate after intentional UI changes
```
See [docs/TEST_PLAN.md](docs/TEST_PLAN.md) for coverage and the manual QA checklist.

## Build
Android (needs Android SDK; CI builds the debug APK on every push):
```bash
flutter build apk --debug
flutter build appbundle --release \
  --dart-define=ADMOB_REWARDED_ANDROID=ca-app-pub-XXX/YYY \
  --dart-define=ADMOB_INTERSTITIAL_ANDROID=ca-app-pub-XXX/ZZZ \
  -PADMOB_APP_ID_ANDROID=ca-app-pub-XXX~AAA
```
iOS (macOS + Xcode):
```bash
cd ios && pod install && cd ..
flutter build ipa --release --dart-define=ADMOB_REWARDED_IOS=... --dart-define=ADMOB_INTERSTITIAL_IOS=...
```
Put the iOS AdMob **app** id in `ios/Flutter/AdMob.xcconfig` (gitignored): `GAD_APP_ID=ca-app-pub-…~…`.

## Ads & privacy
- `AdService` (`lib/core/ads/`) with `AdMobAdService`, `DisabledAdService`, `FakeAdService`.
- Debug/profile builds use Google's public **test** units. Release builds **disable ads**
  unless production unit ids are passed via `--dart-define` (never committed).
- Rewarded ads are opt-in only (double victory coins, hint pack); rewards are granted only on
  the SDK's earned-reward callback, keyed by a unique event id.
- Interstitials only at natural breaks (leaving the Victory screen), never on launch, capped by
  `InterstitialPolicy` (≥2 games, ≥4 min cooldown, ≤4/session, 2 min launch grace).
- Consent: app-owned first-run dialog (analytics + personalized ads, both default **off**) and
  Google UMP (`UmpConsentService`) for regions that legally require it; "Privacy & ad choices"
  in Settings reopens it. Non-personalized requests when personalization is off.
- No LevelPlay mediation is configured. If added, it must replace `AdMobAdService`, not run
  in parallel.

## Firebase (optional, not wired in this build)
The app never requires Firebase. Interfaces with offline implementations exist for
analytics (`AnalyticsService`), crash reporting (`CrashReporter`), remote config
(`RemoteConfigService`) and cloud backup (`CloudBackupService`, conflict policy in
`resolveGameConflict`). Integration checklist:
1. `flutterfire configure` → generates `lib/firebase_options.dart` and native config files
   (all gitignored: `google-services.json`, `GoogleService-Info.plist`).
2. Add `firebase_core`, `firebase_analytics`, `firebase_crashlytics`, `firebase_remote_config`,
   `firebase_auth`, `cloud_firestore`.
3. In `bootstrap.dart`, `try { await Firebase.initializeApp(...) }` and on success override the
   service providers with Firebase adapters; on failure keep the local ones.
4. Gate analytics on `settings.analyticsEnabled`; keep events free of personal data.
5. Deploy `firebase/firestore.rules` (owner-only backup docs; no client-writable leaderboards).
6. Leaderboards: only via a Cloud Function that replays the submitted move log for the seed.

## Localization
Source of truth: `tool/l10n/<lang>.py`. Regenerate ARB files (validates keys and placeholders):
```bash
python3 tool/l10n/build_arbs.py && flutter gen-l10n
```
All 10 catalogs are complete and hand-written; **native-speaker review is still required
before release** (see release checklist).

## Release checklist
- [ ] Choose final application id / bundle id (currently provisional `com.solitairenova.solitaire_nova`).
- [ ] Release signing (`android/key.properties`, iOS provisioning) — never commit keys.
- [ ] Production AdMob app + unit ids via build config; verify test ads in debug.
- [ ] Privacy policy URL (`--dart-define=PRIVACY_POLICY_URL=…`), store data-safety forms.
- [ ] Native-speaker review of all 9 non-English catalogs.
- [ ] On-device performance pass (mid-range Android, older iPhone): 60 fps drag, no jank on deal.
- [ ] Manual QA checklist in `docs/TEST_PLAN.md`.
- [ ] iOS: add a navy LaunchScreen background; run on device.

## Docs
- [Implementation plan & status](docs/IMPLEMENTATION_PLAN.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Game rules, scoring, economy](docs/GAME_RULES.md)
- [Test plan & manual QA](docs/TEST_PLAN.md)

## Asset licensing
- Fonts: Cinzel, Cormorant Garamond — SIL OFL 1.1 (`assets/fonts/OFL.txt`); Roboto/Material
  Icons from the Flutter SDK.
- Cards, suit symbols, card backs, scenes, coin, crown, icon: original vector drawing code.
- Audio: original, synthesized by `tool/generate_audio.py`.
