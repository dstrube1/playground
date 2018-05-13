package com.dstrube.servicetest

import android.app.Service
import android.widget.Toast
import android.content.Intent
import android.os.IBinder


class MyService : Service() {

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {

        if (isRunning) {
            Toast.makeText(this, "Already started", Toast.LENGTH_LONG).show()
        } else {
            Toast.makeText(this, "Service started", Toast.LENGTH_LONG).show()
            isRunning = true
        }
        //once started, no harm in starting again
        return START_STICKY // super.onStartCommand(intent, flags,
        // startId);
    }

    override fun onDestroy() {
        //NOTE: Must handle duplicate calls to destroy elsewhere
        //		if (isRunning) {
        super.onDestroy()
        isRunning = false
        Toast.makeText(this, "Service destroyed", Toast.LENGTH_LONG).show()
        //	}else{
        //	Toast.makeText(this, "Already stopped", Toast.LENGTH_LONG).show();
        //}
    }

    companion object {

        var isRunning = false
    }

}
