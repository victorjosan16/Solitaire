import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/widgets/nova_widgets.dart';
import '../../statistics/application/profile_controller.dart';
import '../domain/cosmetics.dart';
import 'cosmetic_preview.dart';

class ThemesScreen extends ConsumerStatefulWidget {
  const ThemesScreen({super.key});
  @override
  ConsumerState<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends ConsumerState<ThemesScreen> {
  int _tab = 0;
  static const _kinds = [
    CosmeticKind.background,
    CosmeticKind.cards,
    CosmeticKind.table,
  ];

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final profile = ref.watch(profileProvider);
    final kind = _kinds[_tab];
    final items = cosmeticCatalog.where((c) => c.kind == kind).toList();
    final equippedId = profile.equipped.forKind(kind);
    final cols = MediaQuery.sizeOf(context).width > 700 ? 4 : 3;

    return NovaScaffold(
      title: l.themes,
      onBack: () => context.pop(),
      body: MaxWidth(
        maxWidth: 720,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: NovaSpace.lg),
              child: NovaTabs(
                labels: [l.themesBackgrounds, l.themesCards, l.themesTables],
                selected: _tab,
                onChanged: (i) => setState(() => _tab = i),
              ),
            ),
            if (kind != CosmeticKind.background)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  NovaSpace.lg,
                  NovaSpace.sm,
                  NovaSpace.lg,
                  0,
                ),
                child: Text(
                  l.themesContrastNote,
                  style: const TextStyle(
                    color: NovaColors.textMuted,
                    fontSize: 13,
                  ),
                ),
              ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(NovaSpace.lg),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: NovaSpace.md,
                  crossAxisSpacing: NovaSpace.md,
                  childAspectRatio: 0.72,
                ),
                itemCount: items.length,
                itemBuilder: (context, i) {
                  final item = items[i];
                  final owned = profile.owns(item.id);
                  final selected = item.id == equippedId;
                  final name = cosmeticName(l, item.id);
                  return Semantics(
                    button: true,
                    selected: selected,
                    label:
                        '$name, ${selected ? l.applied : (owned ? l.apply : l.locked)}',
                    excludeSemantics: true,
                    child: GestureDetector(
                      onTap: () async {
                        if (owned) {
                          await ref.read(profileProvider.notifier).equip(item);
                        } else {
                          final tab = switch (item.kind) {
                            CosmeticKind.cards => 0,
                            CosmeticKind.background => 1,
                            CosmeticKind.table => 2,
                          };
                          if (context.mounted) {
                            context.push('${Routes.shop}?tab=$tab');
                          }
                        }
                      },
                      child: AnimatedContainer(
                        duration: NovaDurations.fast,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            NovaRadius.md + 2,
                          ),
                          border: Border.all(
                            color: selected
                                ? NovaColors.gold
                                : NovaColors.gold.withValues(alpha: 0.25),
                            width: selected ? 2.5 : 1,
                          ),
                          boxShadow: selected
                              ? NovaShadows.goldGlow(0.4)
                              : null,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CosmeticPreview(
                                    item: item,
                                    cardStyleId: profile.equipped.cards,
                                  ),
                                  if (!owned)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.45,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          NovaRadius.md,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.lock_rounded,
                                        color: NovaColors.goldLight,
                                        size: 30,
                                      ),
                                    ),
                                  if (selected)
                                    const Positioned(
                                      right: 4,
                                      bottom: 4,
                                      child: CircleAvatar(
                                        radius: 13,
                                        backgroundColor: NovaColors.success,
                                        child: Icon(
                                          Icons.check,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: NovaColors.ivory,
                              ),
                            ),
                            if (!owned)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CoinIcon(size: 14),
                                  const SizedBox(width: 3),
                                  Text(
                                    formatThousands(item.price),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: NovaColors.goldLight,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                NovaSpace.lg,
                0,
                NovaSpace.lg,
                NovaSpace.lg,
              ),
              child: PanelButton(
                label: l.restoreDefaults,
                icon: Icons.restart_alt_rounded,
                onPressed: profile.equipped.isDefault
                    ? null
                    : () => ref
                          .read(profileProvider.notifier)
                          .restoreDefaultCosmetics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
