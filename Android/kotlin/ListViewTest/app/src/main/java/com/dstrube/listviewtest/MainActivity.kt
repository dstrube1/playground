package com.dstrube.listviewtest

import android.app.Activity
import android.os.Bundle
import android.widget.ListView
import android.widget.ArrayAdapter
import java.util.*



class MainActivity : Activity() {

    private var mainListView: ListView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onResume() {
        // TODO Auto-generated method stub
        super.onResume()
        mainListView = findViewById(R.id.mainListView)

        val planets = arrayOf("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")

        val planetList = ArrayList<String>()

        planetList.addAll(planets)//Arrays.asList(planets))

        val listAdapter = ArrayAdapter(this,
                R.layout.simplerow, planetList)
        listAdapter.add("Ceres")
        listAdapter.add("Pluto")
        listAdapter.add("Haumea")
        listAdapter.add("Makemake")
        listAdapter.add("Eris")
        mainListView?.adapter = listAdapter
        listAdapter.add("Vulcan")
        listAdapter.add("Kling")
        listAdapter.add("Kobold")
        listAdapter.notifyDataSetChanged()

    }
}
