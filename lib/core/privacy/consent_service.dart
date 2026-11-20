import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../logging/app_logger.dart';

/// Wraps the platform consent flow (Google UMP: GDPR/EEA, UK, US states).
/// The app-owned dialog (analytics opt-in, personalized ads preference) is
/// shown separately by the UI; UMP shows its certified form only where the
/// user's region requires it.
abstract class ConsentService {
  /// Requests consent info and shows the UMP form if required. Never throws
  /// and never blocks gameplay; offline simply leaves ads unavailable.
  Future<void> gather();
  Future<bool> canRequestAds();
  Future<bool> privacyOptionsRequired();
  Future<void> showPrivacyOptions();
}

class UmpConsentService implements ConsentService {
  @override
  Future<void> gather() async {
    final done = Completer<void>();
    try {
      ConsentInformation.instance.requestConsentInfoUpdate(
        ConsentRequestParameters(),
        () async {
          await ConsentForm.loadAndShowConsentFormIfRequired((err) {
            if (err != null) {
              AppLogger.w('consent.form_error', {'code': err.errorCode});
            }
            if (!done.isCompleted) done.complete();
          });
        },
        (err) {
          AppLogger.w('consent.update_failed', {'code': err.errorCode});
          if (!done.isCompleted) done.complete();
        },
      );
    } catch (e) {
      AppLogger.w('consent.unavailable', const {}, e);
      if (!done.isCompleted) done.complete();
    }
    return done.future.timeout(const Duration(seconds: 15), onTimeout: () {});
  }

  @override
  Future<bool> canRequestAds() async {
    try {
      return await ConsentInformation.instance.canRequestAds();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> privacyOptionsRequired() async {
    try {
      return await ConsentInformation.instance
              .getPrivacyOptionsRequirementStatus() ==
          PrivacyOptionsRequirementStatus.required;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> showPrivacyOptions() async {
    try {
      await ConsentForm.showPrivacyOptionsForm((_) {});
    } catch (e) {
      AppLogger.w('consent.options_failed', const {}, e);
    }
  }
}

class NoConsentService implements ConsentService {
  @override
  Future<void> gather() async {}
  @override
  Future<bool> canRequestAds() async => false;
  @override
  Future<bool> privacyOptionsRequired() async => false;
  @override
  Future<void> showPrivacyOptions() async {}
}
