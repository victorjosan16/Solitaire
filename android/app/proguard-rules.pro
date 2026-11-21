# Solitaire Nova — R8 keep rules for the release build.
#
# Crash fixed by these rules (Android 16, release only):
#   Unable to get provider androidx.startup.InitializationProvider:
#   Failed to create an instance of androidx.work.impl.WorkDatabase
# Google Mobile Ads pulls in WorkManager, which starts at launch through
# androidx.startup and creates its Room database "<Name>_Impl" by reflection.
# R8 removed/renamed the generated class, so the app died before Flutter ran.

# Room: generated database implementations are loaded via reflection.
-keep class * extends androidx.room.RoomDatabase { <init>(); }
-keep class **_Impl { <init>(); }
-keep class androidx.work.impl.WorkDatabase_Impl { *; }

# WorkManager: workers and initializers are created by reflection.
-keep class * extends androidx.work.ListenableWorker {
    public <init>(android.content.Context, androidx.work.WorkerParameters);
}
-keep class * implements androidx.startup.Initializer { <init>(); }
-keep class androidx.work.impl.background.systemjob.SystemJobService { *; }
-keep class androidx.work.impl.background.systemalarm.** { *; }
-keep class androidx.work.impl.foreground.SystemForegroundService { *; }

# Our own launcher gate and crash reporter (referenced from the manifest).
-keep class com.solitairenova.app.** { *; }
