package com.dstrube.phonerecord.controller

import android.app.ListActivity
import android.os.Bundle
import com.dstrube.phonerecord.R
import android.content.Intent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.IntentFilter
import com.dstrube.phonerecord.view.CustomAdapter
import com.dstrube.phonerecord.service.DataPopulater



class MainActivity : ListActivity() {

    private var dbController: DBController? = null
    private var populater: DataPopulater? = null
    private var list: ArrayList<HashMap<String, String>>? = null
    private var adapter: CustomAdapter? = null
    private var intentReceiver: BroadcastReceiver? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        dbController = DBController(this)

        populater = DataPopulater(dbController!!, applicationContext)

        for (row in dbController!!.allRows) {
            dbController!!.deleteRow(row["callId"]!!)
        }
        populater!!.populateDB(null)
        list = ArrayList()
        list = dbController!!.allRows
        if (list!!.isEmpty()) {
            populater!!.populateDB(null)
        } else {
            val allColumns = resources.getStringArray(
                    R.array.column_names)
            val columns = arrayOf(allColumns[1], allColumns[2], allColumns[3])
            adapter = CustomAdapter(this, list!!, R.layout.list_item,
                    columns, intArrayOf(R.id.phoneNumber, R.id.callerName, R.id.dateTime))

            listAdapter = adapter
        }
    }

    override fun onResume() {
        super.onResume()

        val intentFilter = IntentFilter("PhoneRecord.intent.MAIN")

        intentReceiver = object : BroadcastReceiver() {

            override fun onReceive(context: Context, intent: Intent) {

                @Suppress("UNCHECKED_CAST")
                val datum = intent.getSerializableExtra("datum") as HashMap<String, String>
                populater!!.populateDB(datum)
                list!!.add(datum)
                adapter!!.notifyDataSetChanged()
            }

        }
        this.registerReceiver(intentReceiver, intentFilter)
    }

}
