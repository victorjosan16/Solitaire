import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../../app/theme/tokens.dart';
import '../../../core/providers.dart';
import '../../../shared/widgets/nova_dialogs.dart';
import '../../../shared/widgets/nova_widgets.dart';
import '../../solitaire/application/game_controller.dart';
import '../../solitaire/domain/models/game_mode.dart';
import '../../statistics/application/profile_controller.dart';
import '../domain/daily_challenge.dart';

class DailyScreen extends ConsumerStatefulWidget {
  const DailyScreen({super.key});
  @override
  ConsumerState<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends ConsumerState<DailyScreen> {
  late DateTime _today;
  late DateTime _month;
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    final now = ref.read(clockProvider)();
    _today = DateTime(now.year, now.month, now.day);
    _month = DateTime(_today.year, _today.month);
    _selected = _today;
  }

  Future<void> _play() async {
    final game = ref.read(gameControllerProvider).snapshot;
    if (game != null && !game.finished && game.hasProgress) {
      final l = context.l10n;
      if (!await showConfirmDialog(
        context,
        title: l.newGameTitle,
        body: l.newGameBody,
      ))
        return;
    }
    await ref
        .read(gameControllerProvider.notifier)
        .startNewGame(mode: GameMode.daily, dailyDate: _selected);
    if (mounted) context.push(Routes.game);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final profile = ref.watch(profileProvider);
    final completed = profile.daily;
    final firstAllowed = DateTime(_today.year, _today.month - 1);
    final canPrev = _month.isAfter(firstAllowed);
    final canNext = _month.isBefore(DateTime(_today.year, _today.month));
    final selKey = DailyChallenge.keyFor(_selected);
    final selEntry = completed[selKey];
    final isToday = _selected == _today;
    final streak = DailyChallenge.currentStreak(completed.keys, _today);
    final monthDone = completed.keys
        .where(
          (k) => k.startsWith(DailyChallenge.keyFor(_month).substring(0, 7)),
        )
        .length;

    // Monday-first weekday headers in the active locale.
    final weekdayFmt = DateFormat.E(locale);
    final monday = DateTime(2024, 1, 1); // a Monday
    final headers = [
      for (var i = 0; i < 7; i++)
        weekdayFmt.format(monday.add(Duration(days: i))),
    ];
    final firstWeekday = DateTime(
      _month.year,
      _month.month,
      1,
    ).weekday; // 1 = Mon
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;

    return NovaScaffold(
      title: l.dailyTitle,
      onBack: () => context.pop(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: NovaSpace.lg),
        child: MaxWidth(
          child: Column(
            children: [
              NovaPanel(
                padding: const EdgeInsets.all(NovaSpace.md),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          tooltip: l.previousMonth,
                          onPressed: canPrev
                              ? () => setState(
                                  () => _month = DateTime(
                                    _month.year,
                                    _month.month - 1,
                                  ),
                                )
                              : null,
                          icon: const Icon(Icons.chevron_left_rounded),
                        ),
                        Expanded(
                          child: Text(
                            toBeginningOfSentenceCase(
                              DateFormat.yMMMM(locale).format(_month),
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: NovaColors.ivory,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: l.nextMonth,
                          onPressed: canNext
                              ? () => setState(
                                  () => _month = DateTime(
                                    _month.year,
                                    _month.month + 1,
                                  ),
                                )
                              : null,
                          icon: const Icon(Icons.chevron_right_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: NovaSpace.xs),
                    Row(
                      children: [
                        for (final h in headers)
                          Expanded(
                            child: ExcludeSemantics(
                              child: Text(
                                h,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  color: NovaColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: NovaSpace.xs),
                    GridView.count(
                      crossAxisCount: 7,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.05,
                      children: [
                        for (var i = 1; i < firstWeekday; i++)
                          const SizedBox.shrink(),
                        for (var d = 1; d <= daysInMonth; d++)
                          _DayCell(
                            date: DateTime(_month.year, _month.month, d),
                            today: _today,
                            selected: _selected,
                            done: completed.containsKey(
                              DailyChallenge.keyFor(
                                DateTime(_month.year, _month.month, d),
                              ),
                            ),
                            onTap: (date) => setState(() => _selected = date),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: NovaSpace.xs),
                      child: Text(
                        l.dailyCompletedCount(monthDone),
                        style: const TextStyle(color: NovaColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: NovaSpace.lg),
              NovaPanel(
                child: Row(
                  children: [
                    const Icon(
                      Icons.emoji_events_rounded,
                      color: NovaColors.gold,
                      size: 44,
                    ),
                    const SizedBox(width: NovaSpace.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isToday
                                ? l.todaysChallenge
                                : DateFormat.yMMMMd(locale).format(_selected),
                            style: const TextStyle(
                              fontFamily: NovaFonts.display,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: NovaColors.goldLight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l.dailyInfo,
                            style: const TextStyle(
                              color: NovaColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const CoinIcon(size: 18),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  isToday
                                      ? l.dailyReward(
                                          DailyChallenge.rewardCoins,
                                        )
                                      : l.dailyPastNoReward,
                                  style: const TextStyle(
                                    color: NovaColors.ivory,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (selEntry != null) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: NovaColors.success,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    selEntry.rewarded
                                        ? '${l.dailyCompleted} · ${l.dailyRewardClaimed}'
                                        : l.dailyCompleted,
                                    style: const TextStyle(
                                      color: NovaColors.ivory,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: NovaSpace.lg),
              GoldButton(label: l.play, onPressed: _play),
              const SizedBox(height: NovaSpace.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.local_fire_department_rounded,
                    color: NovaColors.gold,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l.dailyStreak(streak),
                    style: const TextStyle(color: NovaColors.ivory),
                  ),
                ],
              ),
              const SizedBox(height: NovaSpace.sm),
              Text(
                l.dailyCalendarNote,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: NovaColors.textMuted,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: NovaSpace.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.today,
    required this.selected,
    required this.done,
    required this.onTap,
  });
  final DateTime date, today, selected;
  final bool done;
  final ValueChanged<DateTime> onTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final playable = DailyChallenge.isPlayable(date, today);
    final isToday = date == today;
    final isSel = date == selected;
    final locale = Localizations.localeOf(context).toString();
    final label = [
      DateFormat.yMMMMd(locale).format(date),
      if (done) l.dailyCompleted,
      if (!playable && date.isAfter(today)) l.dailyFuture,
    ].join(', ');
    return Semantics(
      button: playable,
      selected: isSel,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: playable ? () => onTap(date) : null,
        child: Center(
          child: AnimatedContainer(
            duration: NovaDurations.fast,
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isToday ? NovaColors.goldGradient : null,
              border: isSel && !isToday
                  ? Border.all(color: NovaColors.gold, width: 2)
                  : null,
            ),
            child: done
                ? Icon(
                    Icons.check_circle_rounded,
                    color: isToday ? NovaColors.navy : NovaColors.success,
                    size: 26,
                  )
                : Text(
                    '${date.day}',
                    style: TextStyle(
                      fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
                      color: isToday
                          ? NovaColors.navy
                          : (playable
                                ? NovaColors.ivory
                                : NovaColors.textMuted.withValues(alpha: 0.5)),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
