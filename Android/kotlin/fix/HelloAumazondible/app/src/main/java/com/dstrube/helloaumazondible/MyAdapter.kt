package com.dstrube.helloaumazondible

import android.content.Context
import android.view.View
import android.widget.AbsListView
import android.view.ViewGroup
import android.widget.BaseAdapter
import com.android.volley.toolbox.NetworkImageView


class MyAdapter(private val context: Context, private val dataSource: MyDataSource, private val screenSize: Int)
    : BaseAdapter(), MyDataSource.OnDataChangedListener, AbsListView.OnScrollListener {

    private val imagesUrls: ArrayList<String>?

    init {
        imagesUrls = dataSource.imagesUrls
        this.dataSource.setOnDataChangedListener(this)
    }

    fun setImageSize(networkImageView: NetworkImageView, pos: Int) {
        var size = screenSize
        if (imageIsSmall(pos))
            size = size / 2
        size = size - (size * .05).toInt()
        networkImageView.setMaxHeight(size)
        networkImageView.setMinimumHeight(size)
        networkImageView.setMinimumWidth(size)
        networkImageView.setMinimumHeight(size)
    }

    fun imageIsSmall(pos: Int): Boolean {
        //elegant, but harder to debug:
//        return if (pos % 3 == 0) false else true
        if (pos % 3 == 0){
            return false
        }
        else {
            return true
        }
    }

    //
    // Overriding adapter methods
    //
    override fun getCount(): Int {
        return imagesUrls?.size ?: 0
    }

    override fun getItem(pos: Int): Any? {
        if (imagesUrls != null) {
            return imagesUrls[pos]
        } else {
            return null
        }
    }

    override fun getItemId(pos: Int): Long {
        return 0
    }

    override fun getView(pos: Int, convertView: View?, parent: ViewGroup): View {
        // volley NetworkImageView
        val networkImageView: NetworkImageView
        if (convertView != null) {
            networkImageView = convertView as NetworkImageView
        } else {
            networkImageView = NetworkImageView(this.context)
        }
        setImageSize(networkImageView, pos)
        networkImageView.setImageUrl(imagesUrls!![pos],
                MyApplication.getImageLoader())
        return networkImageView
    }

    override fun onDataChanged() {
        notifyDataSetChanged()
    }

    override fun onScrollStateChanged(view: AbsListView, scrollState: Int) {}

    override fun onScroll(view: AbsListView, firstVisibleItem: Int,
                 visibleItemCount: Int, totalItemCount: Int) {
        val count = count
        if (count == 0) {
            return
        } else if (firstVisibleItem > count - 10 && !dataSource.isLoading) {
            dataSource.getMoreData()
        }
    }
}
