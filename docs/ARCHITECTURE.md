# Architecture

Feature-first, layered. **No game rules in widgets or Flame components.**

```
lib/
  main.dart → bootstrap.dart        load local data, wire services, runApp
  app/        app.dart, router/, theme/ (tokens), l10n/ (ARB + generated)
  core/       ads/, analytics/, privacy/, database/, config/, errors/, logging/, services/, providers.dart
  features/
    solitaire/
      domain/       pure Dart: models, rules, engine (engine, advisor, solver, deck), scoring
      application/  GameController (Riverpod Notifier), PlayClock
      data/         GameRepository
      flame/        BoardLayout (pure geometry) + SolitaireBoardGame (render/gestures)
      presentation/ GameScreen, card_art (shared painter)
    daily_challenge/ statistics/ achievements/ customization/ shop/ settings/ splash/ home/ victory/
  shared/     models/profile.dart (economy aggregate), widgets/ (design system)
tool/         seed generator, l10n builder, icon & audio generators
```

## Layers
| Layer | Depends on | Notes |
|---|---|---|
| domain | nothing (pure Dart) | `KlondikeEngine.apply/undo`, `KlondikeRules.validate`, `MoveAdvisor`, `KlondikeSolver` |
| application | domain, data, core | `GameController` turns intents (tap, drop, draw, undo, hint, auto) into engine moves; persists; records results |
| data | core/database | repositories for documents and prefs |
| presentation / flame | application | Flame board asks `BoardDelegate` (implemented by the controller) — it never decides legality |

## Game state & undo
`GameState` is immutable. `KlondikeEngine.apply` returns `(newState, MoveRecord)`; the record
holds exactly what is needed to reverse the move (auto-flip, cards drawn, actual clamped score
delta, waste fan). `undo(apply(s, m)) == s` is checked for every move type and after thousands of
random legal moves in `invariants_test.dart`.

## Persistence
`JsonDocumentStore` — chosen over Drift/SQLite deliberately:
* Data is a handful of small documents read/written whole (current game 10–40 KB, profile 5–20 KB).
* Atomicity per document: write `<doc>.json.tmp` → flush → copy previous good file to
  `.bak` → rename over `<doc>.json`. A crash leaves either the old or the new file.
* Corruption recovery: unparsable primary → `.bak` → fresh default (never crashes).
* Versioned envelopes `{schemaVersion, savedAt, data}` with a migration chain; documents from a
  newer schema are refused rather than misread.
* Serialized write queue (no interleaving).
* **Transactional economy**: coins, the idempotency ledger, stats, achievements, daily results
  and cosmetics live in ONE `profile` document so a grant and its ledger key commit together.
* No native dependency or code generation; recovery paths are unit-tested with real files.

`GameSnapshot` (schemaVersion 1): game id, seed, mode, config, deck order (restart), board,
undo log, elapsed active ms, hints/undos used, combo, auto-finish flag, finished flag, daily date,
timestamps. Saved after every action and on pause/background.

Lightweight settings use `shared_preferences`.

## Timer
`PlayClock` accumulates only active time: it starts on the first move, pauses on app background,
dialogs, menus and victory, ignores backward clock jumps, and cannot double-count (start is idempotent).

## Idempotency keys (ledger)
`game:<id>` (stats/XP), `win:<id>`, `daily:<date>`, `ach:<id>`, `double:<id>`, `buy:<item>`,
`hintpack:<purchaseId>`, `adhints:<rewardEventId>`. Replaying any grant is a no-op.

## Sync (optional, not wired)
`resolveGameConflict(local, remote)`: same game id → more progress & newer wins; different
active games → keep local unless remote is newer, then ask the user (`showCloudConflictDialog`);
finished games never replace an active local one. Game ids are immutable. Offline queue/backoff
belongs in the Firestore adapter.

## Rendering
`BoardLayout.compute(size, state, leftHanded)` is pure and tested for 320 dp phones through
tablets: cards stay on screen with a worst-case column (6 hidden + K→A run) and rank indices
remain visible (≥16% of card height per overlap). `SolitaireBoardGame` keeps 52 persistent
`CardComponent`s, animates only cards whose position/face changed (move 180 ms ease-out, flip
160 ms, deal stagger 35 ms), and caches card art as `ui.Picture`s. Reduced motion snaps instead.
Taps and drags share one gesture path (a drag below 9 px is a tap).

## Accessibility
Flame draws on a canvas, so `GameScreen` overlays invisible `Semantics` nodes per pile (labels
like "7 of Hearts", actions = tap-to-move). All buttons have labels; text scaling to 1.3× is tested
for every locale on a 320 dp screen.
