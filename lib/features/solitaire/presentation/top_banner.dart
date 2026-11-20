import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/theme/tokens.dart';
import '../../../core/ads/ad_service.dart';
import '../../../core/providers.dart';

/// Banner strip at the top of the game screen.
///
/// Loads only when [visible] becomes true (after the grace moves), inserts
/// itself only while [canInsert] says no card is being dragged (the board
/// re-lays out when the strip appears), and disposes the ad when hidden.
/// A gold hairline and padding separate it from the HUD's pause button
/// (AdMob placement policy: no ads flush against game controls).
class TopBanner extends ConsumerStatefulWidget {
  const TopBanner({super.key, required this.visible, required this.canInsert});

  final bool visible;
  final bool Function() canInsert;

  static const double gap = 8;

  @override
  ConsumerState<TopBanner> createState() => _TopBannerState();
}

class _TopBannerState extends ConsumerState<TopBanner> {
  BannerSlot? _slot;
  BannerSlot? _pending;
  bool _loading = false;
  Timer? _retry;

  @override
  void didUpdateWidget(TopBanner old) {
    super.didUpdateWidget(old);
    _sync();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  void _sync() {
    if (!mounted) return;
    if (!widget.visible) {
      _drop();
      return;
    }
    if (_slot != null || _loading) return;
    final ads = ref.read(adServiceProvider);
    if (!ads.bannersAvailable) return;
    _loading = true;
    final width = MediaQuery.sizeOf(context).width.floor();
    ads.loadBanner(width).then((slot) {
      _loading = false;
      if (!mounted || !widget.visible) {
        slot?.dispose();
        return;
      }
      _pending = slot;
      _insertWhenIdle();
    });
  }

  void _insertWhenIdle() {
    _retry?.cancel();
    if (!mounted || _pending == null) return;
    if (!widget.canInsert()) {
      _retry = Timer(const Duration(milliseconds: 300), _insertWhenIdle);
      return;
    }
    setState(() {
      _slot = _pending;
      _pending = null;
    });
  }

  void _drop() {
    _retry?.cancel();
    _pending?.dispose();
    _pending = null;
    if (_slot != null) {
      final s = _slot!;
      setState(() => _slot = null);
      s.dispose();
    }
  }

  @override
  void dispose() {
    _retry?.cancel();
    _pending?.dispose();
    _slot?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slot = _slot;
    if (slot == null) return const SizedBox.shrink();
    return Container(
      color: NovaColors.navyDeep,
      padding: const EdgeInsets.only(top: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: slot.build()),
          const SizedBox(height: TopBanner.gap - 1),
          Divider(
            height: 1,
            thickness: 1,
            color: NovaColors.gold.withValues(alpha: 0.35),
          ),
        ],
      ),
    );
  }
}
