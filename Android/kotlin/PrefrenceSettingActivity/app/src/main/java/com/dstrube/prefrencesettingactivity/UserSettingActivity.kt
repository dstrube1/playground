package com.dstrube.prefrencesettingactivity

import android.os.Bundle
import android.app.Activity


class UserSettingActivity : Activity() {


    public override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //this makes it incompatible with API 10:
        fragmentManager.beginTransaction().replace(android.R.id.content,
                SettingFragment()).commit()

    }
}
