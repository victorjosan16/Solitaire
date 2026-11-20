# Test plan

Automated suite: **204 tests** (2026-11-20, Flutter 3.50.1, Linux), all passing.

| Folder | Tests | What it covers |
|---|---|---|
| `test/unit/engine` | 59 | 52 unique cards; seeded shuffle determinism + frozen regression vector; PRNG uniformity; deal shape (1..7, top face up, 24 stock); every legal/illegal tableau & foundation move; King-only empty columns; multi-card runs; Draw 1/Draw 3 order and short draws; recycle order & limits; scoring incl. clamping; undo of every move type (also through JSON); win detection; tap-to-move priority; hints legal over 200 deals × 60 steps; no pointless stock hints; stuck detection; auto-finish plans; **randomized invariants** (3 rule sets × 150 seeds × 250 random legal moves: 52 unique cards, valid foundations, no face-down above face-up, non-negative score, JSON round trip each step, full undo back to the deal); solver solutions replay to wins; sample re-verification of shipped winning seeds |
| `test/unit/persistence` | 10 | missing doc, serialized writes, corrupt primary → backup, both corrupt, **interrupted write** (stray tmp), migrations chain, newer-schema refusal, **kill/restart** snapshot restore incl. undo log, structural validation (duplicate card), corrupted game file |
| `test/unit/profile` | 14 | 30+ unique achievements, **coin idempotency**, same game recorded once, stats/streaks/best/fastest per draw mode, achievements unlock once, **daily reward once & only today**, purchases (insufficient, owned, never negative), hint packs & rewarded hints idempotent, double coins once, levels, JSON round trip with hostile values, daily seeds/window/streaks |
| `test/unit/application` | 28 | controller: winning/daily deal selection, rule settings applied, draw/undo/illegal drop, persistence + restart, restart same deal, **timer pause / no double count / restore**, win recorded once across **process death**, abandon = one loss, hints & tokens, auto finish, auto-finish cancel consistency, **rewarded ad mock** (skipped/no-fill/earned/duplicate), interstitial policy; layout on 6 screen sizes (worst-case column fits), left-hand mirror, draw-3 fan; clock jumps; cloud conflict policy |
| `test/widget` | 42 | splash → home offline; navigation to all screens and back; first-run consent once; game start, pause dialog, restart confirmation; new-game confirmation; shop insufficient-coins + purchase; delete-data confirmation; stats empty state; **all 16 locales × text scale 1.0 and 1.3 on a 320 dp phone** over 7 screens (overflow = failure); localized names/plurals for every achievement & cosmetic |
| `test/integration` | 2 | end-to-end: Home → Classic Game → **tap the stock through the Flame board** → background save → app restart on same storage → Continue resumes exact board → win a verified deal → rewarded "double coins" claimed once → Main menu; daily challenge offline, reward once |
| `test/golden` | 31 | screenshots of all 10 screens at 390×844, 320×640 and 1180×820 (tablet landscape) + Russian/Ukrainian screens (`tags: golden`) |

Run: `flutter test --exclude-tags golden` (blocking) and `flutter test --tags golden`.

## Not automated here (needs hardware / credentials)
* Android/iOS builds: no Android SDK or Xcode in the dev container. CI builds the debug APK.
* Frame timing / memory profiling on a physical mid-range device.
* Real AdMob fills, UMP form in an EEA locale, Firebase.
* VoiceOver/TalkBack walkthrough on device (semantics tree is built and labelled; widget tests
  exercise it indirectly).

## Manual QA checklist (run on a real device before release)
### Gameplay
- [ ] Draw 1: draw through the whole stock, recycle, cards appear in the same order.
- [ ] Draw 3: fan shows last three; playing the top reveals the previous one; recycle; short final draw.
- [ ] Limited passes (Settings off): recycle stops after 2 (Draw 1) / 3 (Draw 3); stock shows ✕.
- [ ] Drag a multi-card run; drop on illegal target snaps back with shake + haptic.
- [ ] Legal targets glow while dragging; dropping anywhere over a tall column works.
- [ ] Tap-to-move with the setting on/off; King to empty column; no ping-pong of a bottom King.
- [ ] Undo every move type incl. recycle and auto-flips; score and moves revert.
- [ ] Hint highlights source + target; when stuck the "No useful moves" dialog appears, no false loss.
- [ ] Auto Finish appears only when all cards are face up; Skip and Cancel both leave a valid board.
- [ ] Win → victory after cards settle; coins shown once; leaving and reopening does not pay again.
### Screens & layout
- [ ] 320 dp phone (e.g. small Android), notch phone, gesture navigation, tablet landscape.
- [ ] System font size max: no clipped buttons in all 10 screens.
- [ ] Left-handed mode mirrors stock/foundations only.
- [ ] All six table styles and card packs readable; High Contrast table.
- [ ] Reduced motion (app setting and OS setting): no deal/flip animation, no confetti.
### Localization
- [ ] Switch through all 16 languages; CJK on device; Cyrillic headings; long German/Polish labels; plurals (1, 2, 5, 21).
- [ ] Device locale unsupported (e.g. Japanese) → English.
### Offline & lifecycle
- [ ] Airplane mode from first install: splash → home → play → daily challenge, no waits/errors.
- [ ] Rewarded button with no network → "No ad available"/offline dialog; no coins granted.
- [ ] Force-stop mid-game (process death) → relaunch → Continue shows the exact board, timer value.
- [ ] Background for 10 minutes → timer did not advance.
- [ ] Win, kill the app on the victory animation → relaunch: stats show 1 win, coins granted once.
### Ads & privacy
- [ ] First run consent dialog; "Essential only" → no personalized requests, analytics off.
- [ ] EEA test device: UMP form appears; Settings → Privacy & ad choices reopens it.
- [ ] Ad no-fill (airplane mode after load): graceful message.
- [ ] Rewarded ad closed early → no reward; completed → reward once.
- [ ] No interstitials anywhere; banner only on the game screen after 10 moves; rewarded ads opt-in.
### Data
- [ ] Settings → Delete local data asks for confirmation and resets coins/stats/game.
- [ ] Cloud backup/sign-in show "not configured" in builds without Firebase.
- [ ] Cloud sync conflict (once a Firebase adapter exists): both active saves diverged → user prompt.
