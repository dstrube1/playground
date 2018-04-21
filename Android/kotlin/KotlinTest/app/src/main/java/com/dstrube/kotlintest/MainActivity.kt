package com.dstrube.kotlintest

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

class MainActivity : Activity() {

    var tv : TextView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onResume() {
        super.onResume()

        tv = findViewById(R.id.textView1) //as TextView

        tv?.text = "x"

        var myText:String? = null

        val t:test = test(1,"x")

        myText = "t = ${t.param1} + ${t.param2} \n"
        myText += "t.toString() = ${t.toString()}\n"
        myText += "t.equals(t) = ${t.equals(t)}\n"
        myText += "t.hashCode() = ${t.hashCode()}\n"
        val u = t.copy(2,"y")
        myText += "u.toString() = ${u}\n"
        myText += "t.equals(u) = ${t == u}\n"
        myText += "u.hashCode() = ${u.hashCode()}\n"
        val v = t.copy()
        myText += "v.toString() = ${v}\n"
        myText += "t.equals(v) (==) = ${t == v}\n"
        myText += "t === v = ${t === v}\n"
        myText += "v.hashCode() = ${v.hashCode()}\n"

        tv?.text = myText

        println("println is also good for debugging")

        //leftoff about 8 min in to here:
        //https://www.youtube.com/watch?v=X1RVYt2QKQE
    }
}

data class test(val param1 :Int, val param2:String)