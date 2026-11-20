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

## Milestone 1 — Pure Dart engine
- [x] Cards, piles, config, immutable `GameState`, JSON codecs
- [x] Deterministic Mulberry32 PRNG + Fisher–Yates; frozen regression vector
- [x] Rules validation with typed `MoveError`
- [x] Draw 1 / Draw 3, recycling, recycle limits, waste fan metadata
- [x] Command-style `MoveRecord` undo for every move type (incl. auto flip)
- [x] Scoring v1 (documented in GAME_RULES.md), clamped at 0, reversible
- [x] Tap-to-move priority, hint engine (no pointless stock cycling), stuck detection
- [x] Auto-finish planner (greedy foundation plan that must reach a win)
- [x] DFS solver + verified winning seed generator
- [x] Unit + randomized invariant tests (deal, rules, undo, JSON, solver replay)

## Milestone 2 — Persistence
- [x] `JsonDocumentStore`: atomic write (tmp + rename), `.bak` fallback, corruption recovery, serialized write queue
- [x] Versioned envelopes + migration registry
- [x] `GameSnapshot` (schemaVersion, seed, mode, deck order, state, undo log, timer, assists, timestamps)
- [x] Profile document (coins, ledger, stats, achievements, daily, cosmetics) — single document so economy updates are atomic
- [x] SharedPreferences settings
- [x] Tests: round trip, kill/restart, corrupted file, interrupted write, migration

## Milestone 3 — Flame board
- [x] Vector-drawn cards (original suit paths), cached pictures
- [x] Responsive layout (phone portrait, tablet landscape, left-hand mirror)
- [x] Tap, drag & drop with legal-target highlight and snap-back
- [x] Move/flip/deal animations, hint pulse, reduced motion
- [x] Auto finish animation with skip/cancel

## Milestone 4 — Ten screens + design system
- [x] Tokens (colors, spacing, radii, shadows, typography), premium buttons, panels
- [x] Splash, Home, Game, Victory, Daily, Themes, Stats, Achievements, Shop, Settings
- [x] Dialogs: pause, restart, new game, insufficient coins, offline, ad unavailable, consent, restore result, cloud conflict, error, delete data

## Milestone 5 — Content
- [x] 10 locales (en, ro, ru, uk, de, fr, es, it, pt, pl) via gen-l10n
- [x] Stats (total / draw 1 / draw 3), 35 achievements, daily calendar, cosmetics catalog
- [x] Semantics labels for cards and controls

## Milestone 6 — Services
- [x] `AdService` abstraction, AdMob implementation with test IDs, mock/no-op
- [x] Interstitial frequency policy, idempotent rewarded grants
- [x] Consent (UMP) wrapper, analytics opt-out
- [~] Firebase: interfaces + offline implementations + `firestore.rules`; SDK wiring is an explicit integration checklist (needs project credentials)

## Milestone 7 — Release readiness
- [x] Widget, golden and integration-style tests
- [x] GitHub Actions: format, analyze, test, Android debug APK
- [x] README, ARCHITECTURE, GAME_RULES, TEST_PLAN, manual QA checklist
- [ ] On-device performance profiling (requires physical device)
- [ ] Native-speaker translation review
- [ ] Production app id, signing keys, AdMob/Firebase production credentials (owner decision)
