package com.dstrube.phonerecord.view

import android.content.Context
import android.view.ViewGroup
import android.view.LayoutInflater
import android.view.View
import android.widget.SimpleAdapter
import android.widget.TextView
import com.dstrube.phonerecord.R


class CustomAdapter(private val context: Context, data: List<Map<String, *>>,
                    resource: Int, from: Array<String>, to: IntArray) : SimpleAdapter(context, data, resource, from, to) {

    private val data: ArrayList<HashMap<String, String>>
    private val inflater: LayoutInflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater

    init {
        @Suppress("UNCHECKED_CAST")
        this.data = data as ArrayList<HashMap<String, String>>
    }

    // Get count of items in the list
    override fun getCount(): Int {
        return data.size
    }

    // Get item in the list
    override fun getItem(position: Int): Any {
        return data[position]
    }

    // Get item id of item in the list
    override fun getItemId(position: Int): Long {
        return super.getItemId(position)
    }

    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View? {
        val view: View? = convertView ?: inflater.inflate(com.dstrube.phonerecord.R.layout.list_item,
                    parent, false)

        @Suppress("UNCHECKED_CAST")
        val map = getItem(position) as HashMap<String, String>
        val phoneNumberView = view?.findViewById(R.id.phoneNumber) as TextView
        val callerNameView = view.findViewById(R.id.callerName) as TextView
        val dateTimeView = view.findViewById(R.id.dateTime) as TextView

        val columns = context.resources.getStringArray(R.array.column_names)

        phoneNumberView.text = map[columns[1]]
        callerNameView.text = map[columns[2]]
        dateTimeView.text = map[columns[3]]

        return view
    }
}
