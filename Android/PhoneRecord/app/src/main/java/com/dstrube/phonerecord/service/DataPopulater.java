package com.dstrube.phonerecord.service;

import java.util.HashMap;

import android.content.Context;

import com.dstrube.phonerecord.R;
import com.dstrube.phonerecord.controller.DBController;

public class DataPopulater {
	private DBController dbController;
	private Context context;

	public DataPopulater(
			DBController dbController, Context context) {
		this.dbController = dbController;
		this.context = context;
	}
	public void populateDB(HashMap<String, String> datum){
		if (datum != null){
		// adding each child node to HashMap key => value
			dbController.insertRow(datum);
			return;
		}
		
		//the above is how it will work in time;
		//for now, we're hardcoding this stuff
		//TODO: take this out once we get past this.
		// creating a new single-row HashMap that will represent a row
		// in the ListView
		String[]columns = context.getResources().getStringArray(
				R.array.column_names);
		HashMap<String, String> map = new HashMap<>();
		// adding each child node to HashMap key => value
		map.put(columns[0], "1");
		map.put(columns[1], "770-401-1542");
		map.put(columns[2], "David Strube");
		map.put(columns[3], "2014-04-30 18:07");
		map.put(columns[4], "33.986234");
		map.put(columns[5], "-84.202446");
		dbController.insertRow(map);
		
		map = new HashMap<>();
		map.put(columns[0], "2");
		map.put(columns[1], "817-939-5121");
		map.put(columns[2], "James Clopton");
		map.put(columns[3], "2014-04-30 18:13");
		map.put(columns[4], "33.986234");
		map.put(columns[5], "-84.202446");
		dbController.insertRow(map);
		
		map = new HashMap<>();
		map.put(columns[0], "3");
		map.put(columns[1], "423-502-8132");
		map.put(columns[2], "Kyle Penland");
		map.put(columns[3], "2014-04-30 18:17");
		map.put(columns[4], "33.986234");
		map.put(columns[5], "-84.202446");
		dbController.insertRow(map);
		
		map = new HashMap<>();
		map.put(columns[0], "4");
		map.put(columns[1], "920-539-3458");
		map.put(columns[2], "Yang Gu");
		map.put(columns[3], "2014-04-30 18:23");
		map.put(columns[4], "33.986234");
		map.put(columns[5], "-84.202446");
		
		dbController.insertRow(map);
	}
}
