package com.dstrube.kotlintest

import android.app.Activity
import android.os.Bundle
import android.widget.TextView
import java.math.BigDecimal

class MainActivity : Activity() {

    var tv: TextView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onResume() {
        super.onResume()

        tv = findViewById(R.id.textView1) //as TextView

        tv?.text = "x"

        var myText: String? = null

        val t: test = test(1, "x")

        myText = "t = ${t.param1} + ${t.param2} \n"
        myText += "t.toString() = ${t.toString()}\n"
        myText += "t.equals(t) = ${t.equals(t)}\n"
        myText += "t.hashCode() = ${t.hashCode()}\n"
        val u = t.copy(2, "y")
        myText += "u.toString() = ${u}\n"
        myText += "t.equals(u) = ${t == u}\n"
        myText += "u.hashCode() = ${u.hashCode()}\n"
        val v = t.copy()
        myText += "v.toString() = ${v}\n"
        myText += "t.equals(v) (==) = ${t == v}\n"
        myText += "t === v = ${t === v}\n"
        myText += "v.hashCode() = ${v.hashCode()}\n"
        myText += defaultParam(0)
        myText += defaultParam(1, "y")
        myText += defaultParam(y = "params can be out of order", x = 2)
        myText += "single expression function (plus implicit toString()): sum(1,2) = " + sum(1, 2)
        myText += "\n"
        myText += caseEx0(1)
        myText += caseEx0(2)
        myText += caseEx0(4)
        myText += caseEx0(5)
        myText += caseEx1(1)
        myText += caseEx1("2")
        myText += caseEx1(true)
        myText += caseEx1(5)

        val bd1 = BigDecimal(50)
        myText += "50% of 50?: ${bd1.percent(50)}\n"

        myText += "7.times(2) = ${7.times(2)}\n"
        myText += "7 times 3 = ${7 times 3}\n"

        tv?.text = myText

        println("println is also good for debugging")

        //leftoff about 16 min in to here:
        //https://www.youtube.com/watch?v=X1RVYt2QKQE
    }

    fun defaultParam(x: Int, y: String = "default value"): String {
        return "in defaultParam: x = $x, y=$y\n"
    }

    fun sum(x: Int, y: Int) = x + y

    fun caseEx0(x: Int): String {
        when (x) {
            1 -> return "1\n"
            in 1..4 -> return "in 1..4: $x\n"
            !in 1..4 -> return "!in 1..4: $x\n"
            else -> throw IllegalArgumentException("Impossible: $x")
        }
    }

    fun caseEx1(x: Any): String =
            when (x) {
                1 -> "1\n"
                is String -> "String: '$x'\n"
                else -> "else: $x\n"
            }

    //extension function - extending a type
    private fun BigDecimal.percent(percentage: Int) = this.multiply(BigDecimal(percentage)).divide(BigDecimal(100))

    //extension function with infix:
    private infix fun Int.times(x: Int) = x * this

    //extension property
    private val Int.bd: BigDecimal
        get() = BigDecimal(this)
        //usage: val bd1 = 100.bd
}

data class test(val param1: Int, val param2: String)