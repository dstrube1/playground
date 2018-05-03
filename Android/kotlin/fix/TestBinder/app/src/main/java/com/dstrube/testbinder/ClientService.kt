package com.dstrube.testbinder

import android.app.Service
import android.content.Intent
import android.os.*
import android.widget.Toast
import android.os.Process.myPid


class ClientService : Service() {

    private val messenger = Messenger(IncomingHandler())

    /**
     * the service receives here the messages from a remote process
     * @author ado
     */
    //TODO: should be static or leaks might occur?
    private inner class IncomingHandler : Handler() {
        override fun handleMessage(msg: Message) {
            val data = msg.data
            val title = data.getString("TITLE")
            val pid = Process.myPid()
            Toast.makeText(applicationContext, title + "\nservice pid: " + pid, Toast.LENGTH_SHORT).show()
        }
    }

    //the IBinder returned here is used by the messenger to communicate with the associated handler
    override fun onBind(arg0: Intent): IBinder {
        return messenger.binder
    }

}