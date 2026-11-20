import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/widgets/nova_dialogs.dart';
import '../../../shared/widgets/nova_widgets.dart';
import '../application/profile_controller.dart';
import '../domain/player_stats.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});
  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  int _tab = 0;

  String _duration(int ms) {
    final l = context.l10n;
    final d = Duration(milliseconds: ms);
    return l.durationHm(d.inHours, d.inMinutes.remainder(60));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final p = ref.watch(profileProvider);
    final stats = p.stats;
    final ModeStats m = switch (_tab) {
      1 => stats.draw1,
      2 => stats.draw3,
      _ => stats.total,
    };
    final pct = NumberFormat.decimalPercentPattern(
      locale: locale,
      decimalDigits: 1,
    );
    final num = NumberFormat.decimalPattern(locale);
    return NovaScaffold(
      title: l.statistics,
      onBack: () => context.pop(),
      body: MaxWidth(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: NovaSpace.lg),
          children: [
            NovaTabs(
              labels: [l.statsTotal, l.drawOne, l.drawThree],
              selected: _tab,
              onChanged: (i) => setState(() => _tab = i),
            ),
            const SizedBox(height: NovaSpace.lg),
            if (m.played == 0)
              NovaPanel(
                child: Column(
                  children: [
                    const Icon(
                      Icons.insights_rounded,
                      size: 48,
                      color: NovaColors.goldLight,
                    ),
                    const SizedBox(height: NovaSpace.md),
                    Text(
                      l.statsEmpty,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: NovaColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            else
              NovaPanel(
                padding: const EdgeInsets.symmetric(
                  horizontal: NovaSpace.lg,
                  vertical: NovaSpace.sm,
                ),
                child: Column(
                  children: [
                    StatRow(
                      icon: Icons.sports_esports_rounded,
                      label: l.statsPlayed,
                      value: num.format(m.played),
                    ),
                    const Divider(),
                    StatRow(
                      icon: Icons.emoji_events_rounded,
                      label: l.statsWins,
                      value: num.format(m.won),
                    ),
                    const Divider(),
                    StatRow(
                      icon: Icons.percent_rounded,
                      label: l.statsWinRate,
                      value: pct.format(m.winRate),
                    ),
                    const Divider(),
                    StatRow(
                      icon: Icons.timer_outlined,
                      label: l.statsTotalTime,
                      value: _duration(m.totalPlayMs),
                    ),
                    const Divider(),
                    StatRow(
                      icon: Icons.bar_chart_rounded,
                      label: l.statsBestScore,
                      value: num.format(m.bestScore),
                    ),
                    const Divider(),
                    StatRow(
                      icon: Icons.bolt_rounded,
                      label: l.statsFastest,
                      value: m.fastestWinMs == null
                          ? '—'
                          : formatClock(m.fastestWinMs!),
                    ),
                    const Divider(),
                    StatRow(
                      icon: Icons.swap_vert_rounded,
                      label: l.statsFewestMoves,
                      value: m.fewestMovesWin?.toString() ?? '—',
                    ),
                    const Divider(),
                    StatRow(
                      icon: Icons.local_fire_department_rounded,
                      label: l.statsCurrentStreak,
                      value:
                          '${_tab == 0 ? stats.overallStreak : m.currentStreak}',
                    ),
                    const Divider(),
                    StatRow(
                      icon: Icons.whatshot_rounded,
                      label: l.statsBestStreak,
                      value:
                          '${_tab == 0 ? stats.overallBestStreak : m.bestStreak}',
                    ),
                    if (_tab == 0) ...[
                      const Divider(),
                      StatRow(
                        icon: Icons.flash_on_rounded,
                        label: l.statsMaxCombo,
                        value: '${stats.maxCombo}x',
                      ),
                      const Divider(),
                      StatRow(
                        icon: Icons.calendar_month_rounded,
                        label: l.statsDailyDone,
                        value: num.format(p.daily.length),
                      ),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: NovaSpace.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.phone_android_rounded,
                  size: 16,
                  color: NovaColors.textMuted,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    l.statsLocalLabel,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: NovaColors.textMuted),
                  ),
                ),
              ],
            ),
            const SizedBox(height: NovaSpace.xl),
          ],
        ),
      ),
    );
  }
}
