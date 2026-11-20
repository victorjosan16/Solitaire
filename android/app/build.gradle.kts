plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.solitairenova.solitaire_nova"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // PROVISIONAL application id: replace before the first store upload.
        applicationId = "com.solitairenova.solitaire_nova"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        // Google's documented SAMPLE AdMob app id unless a real one is passed:
        //   ./gradlew -PADMOB_APP_ID_ANDROID=ca-app-pub-xxx~yyy  (or gradle.properties, not committed)
        manifestPlaceholders["admobAppId"] =
            (project.findProperty("ADMOB_APP_ID_ANDROID") as String?)
                ?: "ca-app-pub-3940256099942544~3347511713"
    }

    buildTypes {
        release {
            // Release signing: provide android/key.properties (gitignored) and
            // wire a signingConfig here before publishing. Until then release
            // builds are signed with the debug key so `flutter run --release`
            // works locally; such builds must never be uploaded to a store.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
