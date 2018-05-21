package com.dstrube.radiotest

import android.app.Activity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.RadioButton
import android.widget.RadioGroup
import android.widget.Toast

class MainActivity : Activity() {

    private var radioGroup: RadioGroup? = null
    private var radioButton: RadioButton? = null
    private var button: Button? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onResume() {
        super.onResume()
        radioGroup = findViewById(R.id.radioGroup1)
        button = findViewById(R.id.button1)
        addListenerOnButton()
    }

    private fun addListenerOnButton() {
        button?.setOnClickListener{ v ->
            ImageClick(v)
        }
    }

    fun ImageClick(v: View) {
        //image button source:
        //http://www.clker.com/cliparts/5/9/c/2/1194984395619889880earth_globe_dan_gerhrads_01.svg.med.png
        val selected = radioGroup?.checkedRadioButtonId ?: return
        radioButton = findViewById<RadioButton?>(selected)
        Toast.makeText(applicationContext, radioButton?.text, Toast.LENGTH_LONG).show()
    }


}
