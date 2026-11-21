import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/widgets/nova_widgets.dart';
import '../../achievements/presentation/achievements_screen.dart';
import '../../statistics/presentation/stats_screen.dart';

/// Player profile: statistics and achievements in one place.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.initialTab = 0});
  final int initialTab;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late int _tab = widget.initialTab.clamp(0, 1);

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return NovaScaffold(
      title: l.navProfile,
      onBack: () => context.pop(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              NovaSpace.lg,
              0,
              NovaSpace.lg,
              NovaSpace.md,
            ),
            child: MaxWidth(
              child: NovaTabs(
                labels: [l.statistics, l.achievements],
                selected: _tab,
                onChanged: (i) => setState(() => _tab = i),
              ),
            ),
          ),
          Expanded(
            child: _tab == 0
                ? const StatsScreen(embedded: true)
                : const AchievementsScreen(embedded: true),
          ),
        ],
      ),
    );
  }
}
