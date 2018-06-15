package com.sms.smsbroadcastreceiver;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import android.app.ListActivity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;

public class SmsReceiverListActivity extends ListActivity {

	private BroadcastReceiver mIntentReceiver;
	private SimpleAdapter listAdapter ;
	private ArrayList<Map<String, String>> list = new ArrayList<>() ;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_sms_receiver_list);
		   //setContentView(R.layout.main);
	       // setListAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, DayOfWeek));
		 	Map<String, String> hm = new HashMap<>();
		 	hm.put("number", "908XXXX");
		 	hm.put("msg", "A Test Message");
		 	list.add(hm);
		 
		 
		    // Create and populate a List of planet names.
		    String[] planets = new String[] { "Mercury"};  
		    ArrayList<String> planetList = new ArrayList<>(Arrays.asList(planets));

		    // Create ArrayAdapter using the planet list.
//		    listAdapter = new ArrayAdapter<>(this, R.layout.list_row, planetList);
		    
		    
		    final String[] fromMapKey = new String[] {"number", "msg"};
		    final int[] toLayoutId = new int[] {android.R.id.text1, android.R.id.text2};
		    


		    listAdapter =  new SimpleAdapter(this, list,
		                             android.R.layout.simple_list_item_2,
		                             fromMapKey, toLayoutId);


		ListView listView = getListView();
		 	listView.setAdapter(listAdapter);
	}

	@Override
	protected void onResume() {
		super.onResume();

		IntentFilter intentFilter = new IntentFilter("SmsMessage.intent.MAIN");
		
		mIntentReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context context, Intent intent) {
				String msg = intent.getStringExtra("get_msg");

				// Process the sms format and extract body &amp; phoneNumber
				msg = msg.replace("\n", "");
				String body = msg.substring(msg.lastIndexOf(":") + 1,
						msg.length());
				String pNumber = msg.substring(0, msg.lastIndexOf(":"));
				//listAdapter.clear();
				//listAdapter.add(body);
				
				// Add it to the list or do whatever you wish to
			 	Map<String, String> hm = new HashMap<String, String>();
			 	hm.put("number", pNumber);
			 	hm.put("msg", body);
			 	list.add(hm);
			    
			    listAdapter.notifyDataSetChanged();
				System.out.println("RECEIVED ::: " + msg);
			}
		};
		
		
		this.registerReceiver(mIntentReceiver, intentFilter);
	}

	@Override
	protected void onPause() {

		super.onPause();
		this.unregisterReceiver(this.mIntentReceiver);
	}

}