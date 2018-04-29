package com.dstrube.xmlparsingtest.view

import android.widget.TextView
import android.content.Intent.getIntent
import android.content.Intent
import android.os.Bundle
import android.app.Activity
import com.dstrube.xmlparsingtest.R


class SingleMenuItemActivity : Activity() {

    // XML node keys
    private val KEY_NAME = "name"
    private val KEY_COST = "cost"
    private val KEY_DESC = "description"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.single_list_item)

        // getting intent data
        val `in` = intent //here's how to name a variable after a keyword :-p

        // Get XML values from previous intent
        val name = `in`.getStringExtra(KEY_NAME)
        val cost = `in`.getStringExtra(KEY_COST)
        val description = `in`.getStringExtra(KEY_DESC)

        // Displaying all values on the screen
        val lblName = findViewById(R.id.name_label) //as TextView
        val lblCost = findViewById(R.id.cost_label) //as TextView
        val lblDesc = findViewById(R.id.description_label) //as TextView

        lblName.text = name
        lblCost.text = cost
        lblDesc.text = description
    }
}