package com.dstrube.testbinder

import android.app.Service
import android.widget.Toast
import android.os.Looper
import android.content.Intent
import android.os.Handler
import android.os.IBinder
import android.os.RemoteException


class ClientAidl : Service() {

    private val binder0 = object : IMather.Stub() {

        @Throws(RemoteException::class)
        fun divide(a: Int, b: Int): String {
            val result = a.toFloat() / b.toFloat()
            val handler = Handler(Looper.getMainLooper())
            handler.post(Runnable {
                //					Toast.makeText(getApplicationContext(), a+ " / "+b+" = "+result, Toast.LENGTH_LONG).show();
            })
            return result.toString()
        }

        @Throws(RemoteException::class)
        fun add(a: Int, b: Int): String {
            val result = a + b
            val handler = Handler(Looper.getMainLooper())
            handler.post(Runnable {
                //					Toast.makeText(getApplicationContext(), a+ " + "+b+" = "+result, Toast.LENGTH_LONG).show();
            })
            return result.toString()
        }
    }

    private val binder = object : IMultiplier.Stub() {

        @Throws(RemoteException::class)
        fun multiply(a: Int, b: Int): String {
            val result = a * b
            val handler = Handler(Looper.getMainLooper())
            handler.post(Runnable {
                Toast.makeText(applicationContext, a.toString() + " * " + b + "= " + result, Toast.LENGTH_SHORT).show() })
            return "Hello"
        }
    }

    override fun onBind(intent: Intent): IBinder {
        return binder0
    }

}