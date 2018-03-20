package com.dstrube.phonerecord.controller;

import java.util.ArrayList;
import java.util.HashMap;

import com.dstrube.phonerecord.R;
import com.dstrube.phonerecord.service.DataPopulater;
import com.dstrube.phonerecord.view.CustomAdapter;

import android.app.ListActivity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;

public class MainActivity extends ListActivity {

	private DBController dbController;
	private DataPopulater populater;
	private ArrayList<HashMap<String, String>> list;
	private CustomAdapter adapter;
	private BroadcastReceiver intentReceiver;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		dbController = new DBController(this);

		populater = new DataPopulater(dbController, getApplicationContext());

		for (HashMap<String, String> row : dbController.getAllRows()) {
			dbController.deleteRow(row.get("callId"));
		}
		populater.populateDB(null);
		list = new ArrayList<>();
		list = dbController.getAllRows();
		if (list.size() == 0) {
			populater.populateDB(null);
		} else {
			String[] allColumns = getResources().getStringArray(
					R.array.column_names);
			String[] columns = new String[] { allColumns[1], allColumns[2],
					allColumns[3] };
			adapter = new CustomAdapter(this, list, R.layout.list_item,
					columns, new int[] { R.id.phoneNumber, R.id.callerName,
							R.id.dateTime });

			setListAdapter(adapter);
		}
	}

	@Override
	protected void onResume() {
		super.onResume();

		IntentFilter intentFilter = new IntentFilter("PhoneRecord.intent.MAIN");

		intentReceiver = new BroadcastReceiver() {

			@Override
			public void onReceive(Context context, Intent intent) {
				@SuppressWarnings("unchecked")
				HashMap<String, String> datum = (HashMap<String, String>) intent
						.getSerializableExtra("datum");
				populater.populateDB(datum);
				list.add(datum);
				adapter.notifyDataSetChanged();
			}

		};
		this.registerReceiver(intentReceiver, intentFilter);
	}

}
