package com.dstrube.weblistintent.view

import android.app.Activity
import com.dstrube.weblistintent.model.LinkData
import android.widget.AdapterView
import android.os.Bundle
import android.view.ViewGroup
import android.view.LayoutInflater
import android.app.Fragment
import android.view.View
import android.widget.ListView
import com.dstrube.weblistintent.R
import com.dstrube.weblistintent.controller.ChangeLinkListener


// set data here
// static{
// final Context ctx = getView().getContext();
// final Resources res = ctx.getResources();
// final String[] domains = res.getStringArray(R.array.domains);
// linkDataList.add(new LinkData("SwA",
// "http://www.survivingwithandroid.com"));
// linkDataList.add(new LinkData("Android", "http://www.android.com"));
// linkDataList.add(new LinkData("Google Mail", "http://mail.google.com"));

// }
// i don't like this way of doing it; let's avoid it if possible

class LinkListFragment : Fragment() {
    private val linkDataList = ArrayList<LinkData>()
    private var la: LinkAdapter? = null

    override fun onActivityCreated(savedInstanceState: Bundle) {
        super.onActivityCreated(savedInstanceState)
        // Here we set our custom adapter. Now we have the reference to the
        // activity
        val ctx = getView().getContext()
        val res = ctx.getResources()
        val domains = res.getStringArray(R.array.domains)
        for (i in domains.indices) {
            linkDataList.add(LinkData(domains[i], "http://www." + domains[i] + ".com"))
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup,
                     savedInstanceState: Bundle): View {
        val v = inflater.inflate(R.layout.linklist_layout, container, false)
        val lv = v.findViewById(R.id.urls) as ListView
        la = LinkAdapter(linkDataList, getActivity())
        lv.setAdapter(la)
        lv.setOnItemClickListener(object : AdapterView.OnItemClickListener {
            override fun onItemClick(parentAdapter: AdapterView<*>, view: View,
                            position: Int, id: Long) {
                val data = (la as LinkAdapter).getItem(position)
                (getActivity() as ChangeLinkListener).onLinkChange(data?.url)
            }
        })
        return v
    }

    override fun onAttach(activity: Activity) {
        // We verify that our activity implements the listener
        if (activity !is ChangeLinkListener)
            throw ClassCastException()
        super.onAttach(activity)
    }

}