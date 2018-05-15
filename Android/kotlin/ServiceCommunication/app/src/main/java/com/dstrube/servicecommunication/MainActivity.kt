package com.dstrube.servicecommunication

import android.app.ListActivity
import android.os.Bundle
import android.view.View
import android.widget.ArrayAdapter
import android.widget.Toast
import android.content.ComponentName
import android.content.Context
import android.os.IBinder
import android.content.ServiceConnection
import android.content.Intent


class MainActivity : ListActivity() {

    private var localWorldService: LocalWordService? = null
    private var adapter: ArrayAdapter<String>? = null
    private var wordList: ArrayList<String>? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        wordList = ArrayList()
        adapter = ArrayAdapter(this,
                android.R.layout.simple_list_item_1, android.R.id.text1,
                wordList)
        listAdapter = adapter
    }

    override fun onResume() {
        super.onPause()//kotlin complains that this should be onResume, but it doesn't really seem necessary
        val i = Intent(this, LocalWordService::class.java)
        bindService(i, mConnection, Context.BIND_AUTO_CREATE)

        startService(i)
    }

    override fun onPause() {
        super.onPause()
        unbindService(mConnection)
    }

    fun showServiceData(view: View) {
        if (localWorldService != null) {
            Toast.makeText(this,
                    "Number of elements # " + localWorldService?.wordList?.size,
                    Toast.LENGTH_SHORT).show()
            wordList?.clear()
            wordList?.addAll(localWorldService?.wordList as MutableCollection<String>)
            adapter?.notifyDataSetChanged()
        }
    }

    private val mConnection = object : ServiceConnection {

        override fun onServiceConnected(className: ComponentName, binder: IBinder) {
            localWorldService = (binder as LocalWordService.MyBinder).service
            Toast.makeText(this@MainActivity, "Connected", Toast.LENGTH_SHORT).show()
        }

        override fun onServiceDisconnected(className: ComponentName) {
            localWorldService = null
        }
    }
}
