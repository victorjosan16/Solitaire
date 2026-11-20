import 'dart:async';

import 'helpers/app_harness.dart';

/// Loads real fonts once for every test file (widget tests and goldens).
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();
  await testMain();
}
