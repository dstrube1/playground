package com.clopton.itent;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import android.app.Activity;
import android.os.Bundle;
import android.os.Parcelable;
import android.view.Menu;
import android.widget.ListView;
import android.widget.SimpleAdapter;

public class Report extends Activity{
	
	@Override
	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		setContentView(R.layout.report);
		ListView lv= (ListView)findViewById(R.id.listview);
		  
	        // create the grid item mapping
	        String[] from = new String[] {"rowid", "name", "mail", "phone"};
	        int[] to = new int[] { R.id.item1, R.id.item2, R.id.item3, R.id.item4 };
	        ArrayList emp1 =  getIntent().getParcelableArrayListExtra("james");
	        // prepare the list of all records
	        List<HashMap<String, String>> fillMaps = new ArrayList<HashMap<String, String>>();
	        
	        for(int i = 0; i < 10; i++){
	        	Employee emp =  (Employee) emp1.get(i);
	            HashMap<String, String> map = new HashMap<String, String>();
	            map.put("rowid", "" + i);
	            map.put("name", emp.getName());
	            map.put("mail", emp.getMail());
	            map.put("phone", emp.getPhone());
	            fillMaps.add(map);
	        }
	 
	        // fill in the grid_item layout
	        SimpleAdapter adapter = new SimpleAdapter(this, fillMaps, R.layout.grid_view, from, to);
	        lv.setAdapter(adapter);
	}
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

}

