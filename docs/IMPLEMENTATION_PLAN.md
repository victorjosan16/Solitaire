# Solitaire Nova — Implementation Plan

Status legend: `[x]` done and verified in this environment, `[~]` implemented but
only partially verifiable here, `[ ]` not started / blocked.

## Milestone 0 — Audit & plan
Audit (2026-11-20): repository contained only a 1-line `README.md`; no code,
assets or CI. Environment: Linux container, no Flutter preinstalled, no
Android SDK (dl.google.com is blocked by the network policy), no Xcode.

- [x] Installed Flutter 3.50.1 stable (Dart 3.14.0) from the official archive.
- [x] `flutter create --platforms android,ios` (org `com.solitairenova`, provisional).
- [x] Design references stored in `docs/design/` (screen concepts + UI kit).
- [x] This plan.

Risks
| Risk | Mitigation |
|---|---|
| No Android SDK / iOS toolchain in the dev container | CI job builds the Android debug APK on GitHub-hosted runners; iOS build commands documented for macOS hosts. Build results are never claimed unless produced. |
| Flutter 3.47+ moved Material to `package:material_ui` | The app imports `material_ui`; legacy `flutter/material.dart` is avoided. |
| Winnable-deal labelling | Only seeds solved by the bundled solver *and* replayed through the engine are shipped (`verified_seeds.dart`); tests re-verify a sample. |
| Ads / Firebase credentials | Abstract services, Google's public **test** IDs by default, production IDs via `--dart-define`; Firebase behind interfaces with offline no-op implementations. |
| Translation quality | Hand-written translations for all 10 locales; native-speaker review listed in release checklist. |

## Milestone 1 — Pure Dart engine ✅
- [x] Cards, piles, config, immutable `GameState`, JSON codecs
- [x] Deterministic Mulberry32 PRNG + Fisher–Yates; frozen regression vector
- [x] Rules validation with typed `MoveError`
- [x] Draw 1 / Draw 3, recycling, recycle limits, waste fan metadata
- [x] Command-style `MoveRecord` undo for every move type (incl. auto flip)
- [x] Scoring v1 (GAME_RULES.md), clamped at 0, reversible
- [x] Tap-to-move priority, hint engine (no pointless stock cycling), stuck detection
- [x] Auto-finish planner
- [x] DFS solver + verified winning seeds (400 Draw 1, 200 Draw 3, replay-verified)
- [x] 59 engine tests incl. randomized invariants

## Milestone 2 — Persistence ✅
- [x] `JsonDocumentStore` (atomic tmp+rename, .bak recovery, migrations, serialized writes) — Drift deliberately not used, rationale in ARCHITECTURE.md
- [x] `GameSnapshot` schema v1, profile document (economy + ledger), SharedPreferences settings
- [x] Kill/restart, corruption, interrupted-write and migration tests

## Milestone 3 — Flame board ✅ (device performance not measured)
- [x] Original vector card art (6 packs), cached pictures, 6 table styles
- [x] Pure `BoardLayout` tested from 320 dp to tablet landscape; left-hand mirror
- [x] Tap + drag with legal-target highlight and snap-back; hint pulse; shake on illegal
- [x] Move/flip/deal animations; reduced motion
- [x] Auto finish with Skip/Cancel
- [ ] 60 fps verification on a physical mid-range device

## Milestone 4 — Ten screens + design system ✅
- [x] Tokens, gold/panel buttons, tabs, panels, coin badge, logo, painted scenes, confetti
- [x] Splash, Home, Game, Victory, Daily, Themes, Stats, Achievements, Shop, Settings
- [x] All dialogs listed in the brief (cloud conflict dialog is implemented; triggered once a sync adapter exists)

## Milestone 5 — Content ✅
- [x] 10 hand-written locales with plurals; validated by `tool/l10n/build_arbs.py` and CI
- [x] Stats (Total / Draw 1 / Draw 3), 36 achievements, daily calendar, 18 cosmetics
- [x] Semantics overlay for the board; large text tested
- [ ] Native-speaker review

## Milestone 6 — Services ✅ / partial
- [x] `AdService` + AdMob (test ids in debug, disabled in release without ids), fake, disabled
- [x] Interstitial policy, idempotent rewarded grants, UMP consent wrapper, analytics opt-in
- [~] Firebase: interfaces + offline implementations + `firebase/firestore.rules` + checklist; SDK not added (needs project credentials)
- [ ] Real-money IAP (intentionally out of scope: coins only; Restore purchases explains this)

## Milestone 7 — Release readiness ✅ / partial
- [x] 174 automated tests (unit, widget, integration-style, golden)
- [x] GitHub Actions: l10n sync, format, analyze, tests, goldens (non-blocking), Android debug APK
- [x] README, ARCHITECTURE, GAME_RULES, TEST_PLAN + manual QA checklist
- [x] Original launcher icon, navy native launch background (Android)
- [ ] Android/iOS builds verified locally (blocked: no SDKs in container; Android via CI)
- [ ] Production app id, signing, AdMob/Firebase credentials (owner decisions)
- [ ] iOS launch storyboard colour, on-device QA
