package com.dstrube.prefrencesettingactivity

import android.os.Bundle
import android.preference.PreferenceFragment

class SettingFragment : PreferenceFragment() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        addPreferencesFromResource(R.xml.settings)

    }
}
