import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Release signing (upload key). Never committed:
//   * locally: android/key.properties (gitignored), see docs/RELEASE.md
//   * CI: environment variables ANDROID_KEYSTORE_PATH, ANDROID_KEYSTORE_PASSWORD,
//         ANDROID_KEY_ALIAS, ANDROID_KEY_PASSWORD (from GitHub secrets)
val keystoreProperties = Properties().apply {
    val f = rootProject.file("key.properties")
    if (f.exists()) load(FileInputStream(f))
}
fun signingValue(prop: String, env: String): String? =
    (keystoreProperties.getProperty(prop) ?: System.getenv(env))?.takeIf { it.isNotBlank() }

val releaseStoreFile = signingValue("storeFile", "ANDROID_KEYSTORE_PATH")
val hasReleaseSigning = releaseStoreFile != null &&
    signingValue("storePassword", "ANDROID_KEYSTORE_PASSWORD") != null &&
    signingValue("keyAlias", "ANDROID_KEY_ALIAS") != null &&
    signingValue("keyPassword", "ANDROID_KEY_PASSWORD") != null

android {
    namespace = "com.solitairenova.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // Final Google Play package name (cannot change after first upload).
        applicationId = "com.solitairenova.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // versionCode/versionName come from pubspec.yaml or
        // `flutter build --build-number/--build-name` (CI uses the run number).
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        // Production AdMob APP id (not a secret; debug builds still request
        // only Google TEST ad units, see lib/core/config/app_config.dart).
        // Override: -PADMOB_APP_ID_ANDROID=ca-app-pub-xxx~yyy
        manifestPlaceholders["admobAppId"] =
            (project.findProperty("ADMOB_APP_ID_ANDROID") as String?)
                ?: "ca-app-pub-4151706326405945~7945466753"
    }

    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                storeFile = file(releaseStoreFile!!)
                storePassword = signingValue("storePassword", "ANDROID_KEYSTORE_PASSWORD")
                keyAlias = signingValue("keyAlias", "ANDROID_KEY_ALIAS")
                keyPassword = signingValue("keyPassword", "ANDROID_KEY_PASSWORD")
            }
        }
    }

    buildTypes {
        release {
            // Keep rules for reflection-loaded classes (WorkManager/Room via
            // Google Mobile Ads); see proguard-rules.pro.
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
            // With an upload key configured the build is store-ready; without
            // one it falls back to the debug key so local `flutter run
            // --release` still works (such builds are rejected by Play).
            signingConfig = if (hasReleaseSigning) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
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
