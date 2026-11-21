import 'package:firebase_core/firebase_core.dart';

/// Firebase project config for Android (from google-services.json of project
/// `games01-7faee`). These identifiers ship inside every APK; they are not
/// secrets. Configured in Dart so no Gradle google-services plugin is needed.
abstract final class NovaFirebaseOptions {
  static const android = FirebaseOptions(
    apiKey: 'AIzaSyD26f4o5rKfWBP9FYN_-w9toJxyaB68jU4',
    appId: '1:842668705393:android:03bf9eefe29d1c2b1bbdd0',
    messagingSenderId: '842668705393',
    projectId: 'games01-7faee',
    storageBucket: 'games01-7faee.firebasestorage.app',
  );
}
