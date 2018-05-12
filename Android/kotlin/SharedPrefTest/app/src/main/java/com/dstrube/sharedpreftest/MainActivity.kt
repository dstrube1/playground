package com.dstrube.sharedpreftest

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.content.SharedPreferences
import android.widget.EditText
import android.content.Context
import android.view.View


class MainActivity : AppCompatActivity() {

    var et: EditText? = null
    var prefs: SharedPreferences? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onResume() {
        super.onResume()

        et = findViewById(R.id.editText1)

        prefs = getSharedPreferences("myPref", Context.MODE_PRIVATE)

        val storedPref = prefs?.getString("myPref", "")

        if (storedPref == null || storedPref == "") {
            return
        }

        et?.setText(storedPref)
    }

    fun Clear(v: View) {
        val editor = prefs?.edit()
        editor?.putString("myPref", "")
        editor?.commit()
        et?.setText("")

    }

    fun Save(v: View) {
        val text = et?.getText().toString()
        if (text == "") {
            return
        }
        val editor = prefs?.edit()
        editor?.putString("myPref", text)
        editor?.commit()

    }


}
