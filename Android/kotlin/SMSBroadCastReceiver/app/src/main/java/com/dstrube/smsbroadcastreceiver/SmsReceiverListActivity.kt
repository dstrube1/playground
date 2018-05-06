package com.dstrube.smsbroadcastreceiver

import android.app.ListActivity
import android.os.Bundle
import android.widget.SimpleAdapter
import android.content.BroadcastReceiver
import android.content.Context
import java.util.*
import android.content.Intent
import android.content.IntentFilter






class SmsReceiverListActivity : ListActivity() {

    private var mIntentReceiver: BroadcastReceiver? = null
    private var listAdapter: SimpleAdapter? = null
    private val list = ArrayList<Map<String, String>>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sms_receiver_list)

        val hm = HashMap<String, String>()
        hm["number"] = "908XXXX"
        hm["msg"] = "A Test Message"
        list.add(hm)


        // Create and populate a List of planet names.
        val planets = arrayOf("Mercury")
        val planetList = ArrayList<String>()
        //TODO Find Kotlin equivalent of this (and not just the following workaround):
//        var planetsAsList = Arrays.asList(planets)
//        planetList.addAll(planetsAsList)
        for (i in 0 until planets.size) {
            planetList.add(planets[i])
        }

        // Create ArrayAdapter using the planet list.
        //listAdapter = new ArrayAdapter<String>(this, R.layout.list_row, planetList);

        val fromMapKey = arrayOf("number", "msg")
        val toLayoutId = intArrayOf(android.R.id.text1, android.R.id.text2)

        listAdapter = SimpleAdapter(this, list,
                android.R.layout.simple_list_item_2,
                fromMapKey, toLayoutId)

        listView.adapter = listAdapter
    }

    override fun onResume() {
        super.onResume()

        val intentFilter = IntentFilter("SmsMessage.intent.MAIN")

        mIntentReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                var msg = intent.getStringExtra("get_msg")

                // Process the sms format and extract body &amp; phoneNumber
                msg = msg.replace("\n", "")
                val body = msg.substring(msg.lastIndexOf(":") + 1,
                        msg.length)
                val pNumber = msg.substring(0, msg.lastIndexOf(":"))
                //listAdapter.clear();
                //listAdapter.add(body);

                // Add it to the list or do whatever you wish to
                val hm = HashMap<String, String>()
                hm["number"] = pNumber
                hm["msg"] = body
                list.add(hm)

                listAdapter?.notifyDataSetChanged()
                println("RECEIVED ::: $msg")
            }
        }


        this.registerReceiver(mIntentReceiver, intentFilter)
    }

    override fun onPause() {
        println("Pausing")
        super.onPause()
        this.unregisterReceiver(this.mIntentReceiver)
    }
}
