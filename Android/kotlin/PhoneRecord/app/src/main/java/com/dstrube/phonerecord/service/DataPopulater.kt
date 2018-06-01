package com.dstrube.phonerecord.service

import android.content.Context
import com.dstrube.phonerecord.R
import com.dstrube.phonerecord.controller.DBController


class DataPopulater(
        private val dbController: DBController, private val context: Context) {
    fun populateDB(datum: HashMap<String, String>?) {
        if (datum != null) {
            // adding each child node to HashMap key => value
            dbController.insertRow(datum)
            return
        }

        //the above is how it will work in time;
        //for now, we're hardcoding this stuff
        //TODO: take this out once we get past this.
        // creating a new single-row HashMap that will represent a row
        // in the ListView
        val columns = context.resources.getStringArray(
                R.array.column_names)
        var map: HashMap<String, String> = HashMap()
        // adding each child node to HashMap key => value
        map[columns[0]] = "1"
        map[columns[1]] = "770-401-1542"
        map[columns[2]] = "David Strube"
        map[columns[3]] = "2014-04-30 18:07"
        map[columns[4]] = "33.986234"
        map[columns[5]] = "-84.202446"
        dbController.insertRow(map)

        map = HashMap()
        map[columns[0]] = "2"
        map[columns[1]] = "817-939-5121"
        map[columns[2]] = "James Clopton"
        map[columns[3]] = "2014-04-30 18:13"
        map[columns[4]] = "33.986234"
        map[columns[5]] = "-84.202446"
        dbController.insertRow(map)

        map = HashMap()
        map[columns[0]] = "3"
        map[columns[1]] = "423-502-8132"
        map[columns[2]] = "Kyle Penland"
        map[columns[3]] = "2014-04-30 18:17"
        map[columns[4]] = "33.986234"
        map[columns[5]] = "-84.202446"
        dbController.insertRow(map)

        map = HashMap()
        map[columns[0]] = "4"
        map[columns[1]] = "920-539-3458"
        map[columns[2]] = "Yang Gu"
        map[columns[3]] = "2014-04-30 18:23"
        map[columns[4]] = "33.986234"
        map[columns[5]] = "-84.202446"

        dbController.insertRow(map)
    }
}
