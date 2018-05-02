package com.dstrube.weblistintent.view

import android.content.Context
import com.dstrube.weblistintent.model.LinkData
import android.widget.TextView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import com.dstrube.weblistintent.R


class LinkAdapter(private val linkDataList: List<LinkData>, private val ctx: Context) : ArrayAdapter<LinkData>(ctx, R.layout.row_layout, linkDataList) {

    override fun getCount(): Int {
        return linkDataList.size
    }

    override fun getItem(position: Int): LinkData? {
        return linkDataList[position]
    }

    override fun getItemId(position: Int): Long {
        return linkDataList[position].hashCode().toLong()
    }

    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        var v = convertView
        if (convertView == null) {
            val inflater = ctx.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            v = inflater.inflate(R.layout.row_layout, null)
        }

        val linkDomainText = v!!.findViewById(R.id.domain) as TextView
        //       TextView lName = (TextView) v.findViewById(R.id.url);

        val ld = linkDataList[position]
        linkDomainText.text = ld.domain
        //       lName.setText(ld.getUrl());

        return v

    }
}