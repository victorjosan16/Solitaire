import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/theme/tokens.dart';
import '../../../core/ads/ad_service.dart';
import '../../../core/errors/app_error.dart';
import '../../../core/providers.dart';
import '../../../core/services/audio_service.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/widgets/nova_dialogs.dart';
import '../../../shared/widgets/nova_widgets.dart';
import '../../customization/domain/cosmetics.dart';
import '../../customization/presentation/cosmetic_preview.dart';
import '../../solitaire/application/game_controller.dart';
import '../../statistics/application/profile_controller.dart';

/// Cosmetic-only shop. Prices are in non-redeemable virtual coins; there is
/// no real-money store in this build.
class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key, this.initialTab = 0});
  final int initialTab;
  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  late int _tab = widget.initialTab.clamp(0, 3);
  bool _busy = false;
  static const _kinds = [
    CosmeticKind.cards,
    CosmeticKind.background,
    CosmeticKind.table,
  ];

  Future<void> _buy(CosmeticItem item) async {
    final l = context.l10n;
    final profile = ref.read(profileProvider);
    final name = cosmeticName(l, item.id);
    if (profile.coins < item.price) {
      await showInsufficientCoinsDialog(context, item.price - profile.coins);
      return;
    }
    final ok = await showConfirmDialog(
      context,
      title: l.purchaseTitle(name),
      body: l.purchaseBody(item.price, profile.coins - item.price),
      confirmLabel: l.buy,
    );
    if (!ok || !mounted || _busy) return;
    setState(() => _busy = true);
    try {
      await ref.read(profileProvider.notifier).purchase(item);
      ref.read(audioServiceProvider).play(Sfx.coins);
      if (mounted) {
        showNovaSnack(
          context,
          l.purchaseDone(name),
          icon: Icons.celebration_rounded,
        );
      }
    } on InsufficientCoinsError catch (e) {
      if (mounted) {
        await showInsufficientCoinsDialog(context, e.required - e.balance);
      }
    } on AlreadyOwnedError {
      // Double tap: already applied, nothing to do.
    } catch (_) {
      if (mounted) await showErrorDialog(context);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final profile = ref.watch(profileProvider);
    return NovaScaffold(
      title: l.shopTitle,
      onBack: () => context.pop(),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: CoinBadge(
          coins: profile.coins,
          label: l.coinsBalance(profile.coins),
        ),
      ),
      body: MaxWidth(
        maxWidth: 720,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: NovaSpace.lg),
              child: NovaTabs(
                labels: [
                  l.shopCardPacks,
                  l.shopBackgrounds,
                  l.shopTables,
                  l.shopHints,
                ],
                selected: _tab,
                onChanged: (i) => setState(() => _tab = i),
              ),
            ),
            Expanded(
              child: _tab == 3
                  ? _hintsTab(profile)
                  : _grid(profile, _kinds[_tab]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                NovaSpace.xl,
                0,
                NovaSpace.xl,
                NovaSpace.md,
              ),
              child: Text(
                l.coinsDisclaimer,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: NovaColors.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _grid(ProfileData profile, CosmeticKind kind) {
    final l = context.l10n;
    final items = cosmeticCatalog.where((c) => c.kind == kind).toList();
    final cols = MediaQuery.sizeOf(context).width > 700 ? 4 : 3;
    return GridView.builder(
      padding: const EdgeInsets.all(NovaSpace.lg),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        mainAxisSpacing: NovaSpace.md,
        crossAxisSpacing: NovaSpace.md,
        childAspectRatio: 0.68,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];
        final owned = profile.owns(item.id);
        final equipped = profile.equipped.forKind(kind) == item.id;
        final name = cosmeticName(l, item.id);
        final status = equipped
            ? l.equipped
            : (owned ? l.owned : '${item.price}');
        return Semantics(
          button: true,
          label: '$name, $status',
          excludeSemantics: true,
          child: GestureDetector(
            onTap: _busy
                ? null
                : () async {
                    if (!owned) {
                      await _buy(item);
                    } else if (!equipped) {
                      await ref.read(profileProvider.notifier).equip(item);
                    }
                  },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: NovaColors.panelGradient,
                borderRadius: BorderRadius.circular(NovaRadius.md + 2),
                border: Border.all(
                  color: equipped
                      ? NovaColors.gold
                      : NovaColors.gold.withValues(alpha: 0.35),
                  width: equipped ? 2.5 : 1,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: CosmeticPreview(
                      item: item,
                      cardStyleId: profile.equipped.cards,
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
                  const SizedBox(height: 2),
                  if (owned)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          equipped ? Icons.check_circle : Icons.check,
                          size: 16,
                          color: NovaColors.success,
                        ),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            equipped ? l.equipped : l.equip,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: NovaColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CoinIcon(size: 16),
                        const SizedBox(width: 3),
                        Text(
                          formatThousands(item.price),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
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
    );
  }

  Widget _hintsTab(ProfileData profile) {
    final l = context.l10n;
    final ads = ref.read(adServiceProvider);
    return ListView(
      padding: const EdgeInsets.all(NovaSpace.lg),
      children: [
        NovaPanel(
          child: Row(
            children: [
              const Medallion(icon: Icons.lightbulb_rounded),
              const SizedBox(width: NovaSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.hintPackTitle,
                      style: const TextStyle(
                        fontFamily: NovaFonts.display,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: NovaColors.goldLight,
                      ),
                    ),
                    Text(
                      l.hintPackBody(
                        ProfileData.hintPackSize,
                        ProfileData.hintPackPrice,
                      ),
                      style: const TextStyle(color: NovaColors.textSecondary),
                    ),
                    Text(
                      l.hintsOwned(profile.hintTokens),
                      style: const TextStyle(color: NovaColors.ivory),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: NovaSpace.md),
        GoldButton(
          label: l.buyHints(
            ProfileData.hintPackSize,
            ProfileData.hintPackPrice,
          ),
          height: 50,
          onPressed: _busy
              ? null
              : () async {
                  if (profile.coins < ProfileData.hintPackPrice) {
                    await showInsufficientCoinsDialog(
                      context,
                      ProfileData.hintPackPrice - profile.coins,
                    );
                    return;
                  }
                  await ref
                      .read(profileProvider.notifier)
                      .buyHintPack(
                        DateTime.now().microsecondsSinceEpoch.toString(),
                      );
                  ref.read(audioServiceProvider).play(Sfx.coins);
                },
        ),
        if (ads.rewardedAvailable) ...[
          const SizedBox(height: NovaSpace.md),
          PanelButton(
            label: l.watchAdHints(ProfileData.rewardedHintCount),
            icon: Icons.ondemand_video_rounded,
            onPressed: _busy
                ? null
                : () async {
                    setState(() => _busy = true);
                    final r = await ref
                        .read(gameControllerProvider.notifier)
                        .rewardedHints();
                    if (!mounted) return;
                    setState(() => _busy = false);
                    switch (r) {
                      case RewardEarned():
                        showNovaSnack(
                          context,
                          l.hintsOwned(ref.read(profileProvider).hintTokens),
                          icon: Icons.lightbulb,
                        );
                      case RewardSkipped():
                        showNovaSnack(context, l.adNotCompleted);
                      case RewardUnavailable(:final reason):
                        reason == AdUnavailableReason.offline
                            ? await showOfflineDialog(context)
                            : await showAdUnavailableDialog(context);
                    }
                  },
          ),
        ],
      ],
    );
  }
}
