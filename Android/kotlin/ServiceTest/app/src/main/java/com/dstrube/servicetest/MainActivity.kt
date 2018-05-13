package com.dstrube.servicetest

import android.app.Activity
import android.os.Bundle
import android.widget.Toast
import android.content.Intent
import android.view.View


class MainActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun Click1(v: View) {
        startService(Intent(baseContext, MyService::class.java))
    }

    fun Click2(v: View) {
        if (MyService.isRunning) {
            stopService(Intent(baseContext, MyService::class.java))
        } else {
            Toast.makeText(this, "Already stopped", Toast.LENGTH_LONG).show()
        }
    }

    fun Click3(v: View) {
        // Service s = new MyService();
        Toast.makeText(this, "Running: " + MyService.isRunning,
                Toast.LENGTH_LONG).show()
    }


}
