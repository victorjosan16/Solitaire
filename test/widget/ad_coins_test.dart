import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:solitaire_nova/app/router/app_router.dart';
import 'package:solitaire_nova/core/ads/ad_service.dart';
import 'package:solitaire_nova/features/statistics/application/profile_controller.dart';
import 'package:solitaire_nova/shared/models/profile.dart';

import '../helpers/app_harness.dart';

void main() {
  test('ad coins: +25 once per reward event, no daily cap', () {
    var p = const ProfileData(coins: 0);
    p = p.grantAdCoins('e1').grantAdCoins('e1');
    expect(p.coins, 25);
    for (var i = 0; i < 20; i++) {
      p = p.grantAdCoins('n$i');
    }
    expect(p.coins, 25 + 20 * 25);
  });

  testWidgets('Shop: watch ad → +25 coins; skipped → nothing', (tester) async {
    final ads = FakeAdService(nextOutcome: const RewardSkipped());
    final h = await pumpApp(
      tester,
      size: const Size(320, 640),
      route: Routes.shop,
      ads: ads,
      profile: const ProfileData(coins: 100),
    );
    expect(find.text('Watch ad: +25 coins'), findsOneWidget);

    await tester.tap(find.text('Watch ad: +25 coins'));
    await settle(tester);
    expect(h.container.read(profileProvider).coins, 100);

    ads.nextOutcome = const RewardEarned('shop-1');
    await settle(tester, const Duration(seconds: 5)); // snackbar gone
    await tester.tap(find.text('Watch ad: +25 coins'));
    await settle(tester);
    expect(h.container.read(profileProvider).coins, 125);

    ads.nextOutcome = const RewardEarned('shop-2');
    await settle(tester, const Duration(seconds: 5));
    await tester.tap(find.text('Watch ad: +25 coins'));
    await settle(tester);
    expect(h.container.read(profileProvider).coins, 150);
  });

  testWidgets('no rewarded ads available → button hidden', (tester) async {
    await pumpApp(
      tester,
      route: Routes.shop,
      ads: FakeAdService(available: false),
    );
    expect(find.text('Watch ad: +25 coins'), findsNothing);
  });
}
