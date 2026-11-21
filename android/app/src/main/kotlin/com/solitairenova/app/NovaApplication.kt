package com.solitairenova.app

import android.app.Application
import android.content.Context
import android.os.Build
import java.io.PrintWriter
import java.io.StringWriter
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/**
 * Records any uncaught JVM crash (including crashes while Android starts the
 * app's content providers) to a private file. [GateActivity], which runs in a
 * separate process, shows it on the next launch so it can be copied without
 * a computer. No data leaves the device unless the player shares it.
 */
class NovaApplication : Application() {
    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        val previous = Thread.getDefaultUncaughtExceptionHandler()
        Thread.setDefaultUncaughtExceptionHandler { thread, error ->
            try {
                CrashLog.write(base, report(base, thread, error))
            } catch (_: Throwable) {
                // Never let the reporter itself hide the original crash.
            }
            previous?.uncaughtException(thread, error)
        }
    }

    private fun report(context: Context, thread: Thread, error: Throwable): String {
        val sw = StringWriter()
        error.printStackTrace(PrintWriter(sw))
        val version = try {
            val info = context.packageManager.getPackageInfo(context.packageName, 0)
            @Suppress("DEPRECATION")
            "${info.versionName} (${if (Build.VERSION.SDK_INT >= 28) info.longVersionCode else info.versionCode.toLong()})"
        } catch (_: Throwable) {
            "?"
        }
        val time = SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.US).format(Date())
        return buildString {
            appendLine("Solitaire Nova crash report")
            appendLine("Time: $time")
            appendLine("App: $version")
            appendLine("Device: ${Build.MANUFACTURER} ${Build.MODEL}")
            appendLine("Android: ${Build.VERSION.RELEASE} (API ${Build.VERSION.SDK_INT})")
            appendLine("Thread: ${thread.name}")
            appendLine()
            append(sw.toString())
        }
    }
}

object CrashLog {
    private const val FILE = "last_crash.txt"

    fun write(context: Context, text: String) {
        context.openFileOutput(FILE, Context.MODE_PRIVATE).use {
            it.write(text.toByteArray())
        }
    }

    fun read(context: Context): String? = try {
        context.openFileInput(FILE).bufferedReader().use { it.readText() }
            .takeIf { it.isNotBlank() }
    } catch (_: Throwable) {
        null
    }

    fun clear(context: Context) {
        context.deleteFile(FILE)
    }
}
