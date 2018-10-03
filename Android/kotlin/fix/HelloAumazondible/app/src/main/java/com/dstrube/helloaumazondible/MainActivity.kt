package com.dstrube.helloaumazondible

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.R.attr.x
import android.view.Display
import android.widget.GridView
import android.app.Activity
import android.graphics.Point


class MainActivity : Activity() {

    private var adapter: MyAdapter? = null
    private var dataSource: MyDataSource? = null

    /**
     * Called by the adapter initializer, this returns the x size of the screen
     * @return x size of the window
     */
    val windowXSize: Int
        get() {
            val display = windowManager.defaultDisplay
            val size = Point()
            display.getSize(size)
            return size.x
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        //singleton initialization of my data source
        //we don't want more than one of these running around
        dataSource = MyDataSource.instance
        //get the data
        dataSource!!.getMoreData()

        //the adapter used for the gridview
        adapter = MyAdapter(this, dataSource!!, windowXSize)
        //the gridview
        val gridView = findViewById(R.id.gridView) as GridView
        gridView.setOnScrollListener(adapter)
        gridView.adapter = adapter
    }
}
