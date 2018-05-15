package com.dstrube.servicecommunication

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.os.Binder
import java.util.*


class LocalWordService : Service() {
    private val mBinder = MyBinder()
    private val list = ArrayList<String>()

    val wordList: ArrayList<String>
        get() {

            if (list.size == 0) {
                list.add("Linux - Static")
                list.add("Android - Static")
                list.add("iPhone - Static")
                list.add("Windows7 - Static")
                return list
            } else {
                return list
            }
        }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {

        val random = Random()
        if (random.nextBoolean()) {
            list.add("Linux")
        }
        if (random.nextBoolean()) {
            list.add("Android")
        }
        if (random.nextBoolean()) {
            list.add("iPhone")
        }
        if (random.nextBoolean()) {
            list.add("Windows7")
        }
        if (list.size >= 20) {
            list.removeAt(0)
        }
        return Service.START_NOT_STICKY
    }

    override fun onBind(arg0: Intent): IBinder {
        return mBinder
    }

    inner class MyBinder : Binder() {
        internal val service: LocalWordService
            get() = this@LocalWordService
    }

}