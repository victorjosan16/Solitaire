package com.solitairenova.app

import android.app.Activity
import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.graphics.Typeface
import android.os.Bundle
import android.view.Gravity
import android.widget.Button
import android.widget.LinearLayout
import android.widget.ScrollView
import android.widget.TextView
import android.widget.Toast

/**
 * Launcher entry point, running in its own lightweight ":gate" process (no
 * content providers, no Flutter). Normally it forwards to [MainActivity]
 * immediately; if the previous run crashed it shows the crash report with
 * Copy / Share / Continue buttons.
 */
class GateActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val report = CrashLog.read(this)
        if (report == null) {
            openGame()
            return
        }
        setContentView(buildUi(report))
    }

    private fun openGame() {
        startActivity(Intent(this, MainActivity::class.java))
        finish()
        @Suppress("DEPRECATION")
        overridePendingTransition(0, 0)
    }

    private fun buildUi(report: String): LinearLayout {
        val pad = (16 * resources.displayMetrics.density).toInt()
        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setBackgroundColor(Color.parseColor("#101B27"))
            setPadding(pad, pad * 2, pad, pad)
        }
        root.addView(TextView(this).apply {
            text = "Solitaire Nova s-a închis neașteptat / closed unexpectedly"
            setTextColor(Color.parseColor("#F1DDA6"))
            textSize = 18f
            setTypeface(typeface, Typeface.BOLD)
        })
        root.addView(TextView(this).apply {
            text = "Copiază raportul și trimite-l dezvoltatorului. / Copy the report and send it to the developer."
            setTextColor(Color.parseColor("#B9C7C1"))
            setPadding(0, pad / 2, 0, pad / 2)
        })
        val scroll = ScrollView(this)
        scroll.addView(TextView(this).apply {
            text = report
            setTextColor(Color.parseColor("#F7F4EC"))
            typeface = Typeface.MONOSPACE
            textSize = 11f
            setTextIsSelectable(true)
        })
        root.addView(scroll, LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, 0, 1f))
        val buttons = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER
            setPadding(0, pad / 2, 0, 0)
        }
        fun button(label: String, onClick: () -> Unit) = Button(this).apply {
            text = label
            setOnClickListener { onClick() }
        }
        buttons.addView(button("Copiază / Copy") {
            val cm = getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
            cm.setPrimaryClip(ClipData.newPlainText("Solitaire Nova crash", report))
            Toast.makeText(this, "OK", Toast.LENGTH_SHORT).show()
        })
        buttons.addView(button("Trimite / Share") {
            val send = Intent(Intent.ACTION_SEND).apply {
                type = "text/plain"
                putExtra(Intent.EXTRA_SUBJECT, "Solitaire Nova crash report")
                putExtra(Intent.EXTRA_TEXT, report)
            }
            startActivity(Intent.createChooser(send, "Solitaire Nova"))
        })
        buttons.addView(button("Continuă / Continue") {
            CrashLog.clear(this)
            openGame()
        })
        root.addView(buttons)
        return root
    }
}
