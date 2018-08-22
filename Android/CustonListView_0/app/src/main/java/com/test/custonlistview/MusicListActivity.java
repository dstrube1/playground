package com.test.custonlistview;

import java.util.ArrayList;
//import java.util.HashMap;

import com.test.customList.network.MusicVO;
import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.AdapterView.OnItemClickListener;

public class MusicListActivity extends Activity {

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.music_list_activity);
		ListView list =  findViewById(R.id.list);

		Bundle extras = getIntent().getExtras();
		ArrayList<MusicVO> arrayList = extras.getParcelableArrayList("arraylist");

		if (arrayList != null) {

			LazyAdapter adapter = new LazyAdapter(this, arrayList);
			
			list.setAdapter(adapter);

		}

		// Click event for single list row
		list.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
			}
		});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// getMenuInflater().inflate(R.menu.activity_food, menu);
		return true;
	}
}