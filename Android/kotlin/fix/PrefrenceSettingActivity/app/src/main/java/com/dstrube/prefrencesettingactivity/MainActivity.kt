package com.dstrube.prefrencesettingactivity

import android.app.Activity
import android.os.Bundle
import android.widget.TextView
import android.preference.PreferenceManager
import android.content.Intent
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View


class MainActivity : Activity() {

    private val RESULT_SETTINGS = 1
    private val TAG = MainActivity::class.java.name


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        showUserSettings()
    }

    override fun onResume() {
        super.onResume()
        Log.i(TAG, "")
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menuInflater.inflate(R.menu.main, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {

            R.id.menu_settings -> {
                val i = Intent(this, UserSettingActivity::class.java)
                startActivityForResult(i, RESULT_SETTINGS)
            }
        }

        return true
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
        super.onActivityResult(requestCode, resultCode, data)

        when (requestCode) {
            RESULT_SETTINGS -> showUserSettings()
        }

    }

    private fun showUserSettings() {
        val sharedPrefs = PreferenceManager.getDefaultSharedPreferences(this)

        val builder = StringBuilder()

        builder.append("\n Username: " + sharedPrefs.getString("prefUsername", "NULL")!!)

        builder.append("\n Send report:" + sharedPrefs.getBoolean("prefSendReport", false))

        builder.append("\n Sync Frequency: " + sharedPrefs.getString("prefSyncFrequency", "NULL")!!)

        builder.append("\n Ringtone: " + sharedPrefs.getString("pref_other", "NULL")!!)

        val settingsTextView = findViewById<View>(R.id.textUserSettings) as TextView

        settingsTextView.text = builder.toString()
    }

}
