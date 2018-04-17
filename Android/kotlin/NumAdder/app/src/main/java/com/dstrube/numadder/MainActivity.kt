package com.dstrube.numadder

import android.app.Activity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.Toast

class MainActivity : Activity() {

    private var edText1: EditText? = null
    private var edText2: EditText? = null
    private var edText3: EditText? = null
    private var btnSum: Button? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onResume() {
        super.onResume()

        addListenerOnButton()
    }

    //If comment out call to addListenerOnButton, then this works; else no
    fun myClick(v: View) {
        Toast.makeText(applicationContext, "Hooray! Using XML specified button listener.", Toast.LENGTH_LONG).show()
    }

    private fun addListenerOnButton() {
        edText1 = findViewById(R.id.editText1) as EditText
        edText2 = findViewById(R.id.editText2) as EditText
        edText3 = findViewById(R.id.editText3) as EditText

        btnSum = findViewById(R.id.button1) as Button
        btnSum?.setOnClickListener(object : View.OnClickListener {
            override fun onClick(view: View) {
                try {
                    val t1 = edText1?.text.toString()
                    val t2 = edText2?.text.toString()

                    val i1 = Integer.parseInt(t1)
                    val i2 = Integer.parseInt(t2)

                    val sum = i1 + i2
                    val t3 = Integer.toString(sum)
                    edText3?.setText(t3)
                } catch (e: Exception) {

                }
            }
        })
    }
}
