import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/theme/tokens.dart';
import '../../../core/providers.dart';
import '../../../shared/widgets/nova_widgets.dart';
import '../../statistics/application/profile_controller.dart';
import '../domain/achievements.dart';

IconData achievementIcon(AchievementIcon i) => switch (i) {
  AchievementIcon.crown => Icons.workspace_premium_rounded,
  AchievementIcon.trophy => Icons.emoji_events_rounded,
  AchievementIcon.flame => Icons.local_fire_department_rounded,
  AchievementIcon.bolt => Icons.bolt_rounded,
  AchievementIcon.timer => Icons.timer_outlined,
  AchievementIcon.calendar => Icons.calendar_month_rounded,
  AchievementIcon.star => Icons.star_rounded,
  AchievementIcon.cards => Icons.style_rounded,
  AchievementIcon.palette => Icons.palette_rounded,
  AchievementIcon.brain => Icons.psychology_rounded,
  AchievementIcon.target => Icons.track_changes_rounded,
  AchievementIcon.infinity => Icons.auto_fix_high_rounded,
};

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final p = ref.watch(profileProvider);
    final now = ref.read(clockProvider)();
    final locale = Localizations.localeOf(context).toString();
    final done = p.achievements.length;
    final total = achievementCatalog.length;
    // Unlocked first (newest first), then by progress.
    final sorted = [...achievementCatalog]
      ..sort((a, b) {
        final ua = p.achievements[a.id], ub = p.achievements[b.id];
        if (ua != null && ub != null) return ub.compareTo(ua);
        if (ua != null) return -1;
        if (ub != null) return 1;
        final ra = a.progress(p, now) / a.target,
            rb = b.progress(p, now) / b.target;
        return rb.compareTo(ra);
      });
    return NovaScaffold(
      title: l.achievements,
      onBack: () => context.pop(),
      body: MaxWidth(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: NovaSpace.xl),
              child: Column(
                children: [
                  Text(
                    l.achievementsProgress(done, total),
                    style: const TextStyle(color: NovaColors.textSecondary),
                  ),
                  const SizedBox(height: 6),
                  NovaProgressBar(value: done / total, height: 9),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(NovaSpace.lg),
                itemCount: sorted.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: NovaSpace.md),
                itemBuilder: (context, i) {
                  final a = sorted[i];
                  final unlockedAt = p.achievements[a.id];
                  final prog = a.progress(p, now).clamp(0, a.target);
                  final title = achievementTitle(l, a.id);
                  final desc = achievementDescription(l, a);
                  return MergeSemantics(
                    child: NovaPanel(
                      highlight: unlockedAt != null,
                      padding: const EdgeInsets.all(NovaSpace.md),
                      child: Row(
                        children: [
                          Medallion(
                            icon: achievementIcon(a.icon),
                            dimmed: unlockedAt == null,
                          ),
                          const SizedBox(width: NovaSpace.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: NovaColors.ivory,
                                  ),
                                ),
                                Text(
                                  desc,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: NovaColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                if (unlockedAt != null)
                                  Text(
                                    l.earnedOn(
                                      DateFormat.yMMMd(locale)
                                          .format(unlockedAt.toLocal()),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: NovaColors.goldLight,
                                    ),
                                  )
                                else
                                  Row(
                                    children: [
                                      Expanded(
                                        child: NovaProgressBar(
                                          value: prog / a.target,
                                          height: 7,
                                        ),
                                      ),
                                      const SizedBox(width: NovaSpace.sm),
                                      Text(
                                        '$prog / ${a.target}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: NovaColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: NovaSpace.sm),
                          Column(
                            children: [
                              if (unlockedAt != null)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: NovaColors.success,
                                  size: 26,
                                )
                              else
                                const Icon(
                                  Icons.lock_outline_rounded,
                                  color: NovaColors.textMuted,
                                  size: 22,
                                ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const CoinIcon(size: 14),
                                  const SizedBox(width: 2),
                                  Text(
                                    l.rewardCoins(a.reward),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: NovaColors.goldLight,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
