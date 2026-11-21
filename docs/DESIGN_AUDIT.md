# Design audit — premium redesign (presentation only)

## Screens (all existing, no new destinations)
Splash, Home, Game, Victory, Daily Challenge, Profile (Statistics + Achievements tabs),
Statistics, Achievements, Shop, Themes, Settings (+ Privacy sheet, How to play, Language).

## Visual-only files changed
- `lib/app/theme/tokens.dart` — palette aligned to the brand brief
  (#092B27, #10443B, #101C29, #F6F1E7, #D5B776, #B6C6BE, #3AA66F), richer gold gradient.
- `assets/images/logo.png` — illustrated crest from the asset pack; its opaque beige
  halo was removed (transparent edges), cropped, never stretched (`BoxFit.contain`).
- `lib/shared/widgets/nova_logo.dart` — `NovaLogo` shows the crest; the vector
  wordmark (`NovaWordmark`) remains as fallback.
- `lib/shared/widgets/scene_painter.dart` — `MenuBackground` / `VelvetBackground`:
  the free default background renders as painted emerald velvet; purchased
  backgrounds still render their landscapes (shop previews unchanged).
- `lib/shared/widgets/nova_widgets.dart` — gold button depth, `NovaTile`, `SuitDivider`.
- `lib/features/home/presentation/home_screen.dart` — layout: crest, Play, Daily,
  shortcut tiles to existing screens (Achievements, Statistics, How to play),
  highlighted bottom-nav selection.
- `lib/features/splash/presentation/splash_screen.dart` — uses `MenuBackground`.
- `lib/features/solitaire/presentation/game_screen.dart` — HUD as icon pills,
  gold toolbar icons. Board, pile positions, hitboxes and gestures untouched.

## Must not change (untouched)
Engine/domain (`lib/features/solitaire/domain`), controllers/providers, persistence,
profile/ledger, ads/consent services, l10n keys, routes, Android ids.

## Not used from the asset pack
Buttons/icons with baked Romanian text or clipped edges (labels must stay localized),
partial card faces (cards stay painted for correct ranks/suits), trophy/banner (halo).

## Verification
`flutter analyze` clean; all unit/widget/integration tests pass; goldens regenerated
(phone/small/tablet + uk/ru long-text checks).
