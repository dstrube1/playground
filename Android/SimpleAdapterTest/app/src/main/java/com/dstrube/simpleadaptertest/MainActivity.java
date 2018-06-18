package com.dstrube.simpleadaptertest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import android.app.Activity;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.SimpleAdapter;

//////////////////
/*
 * SimpleAdapterTest
 * 2014-04-09
 * Grid of numbers, x2, x3, ^2
 * Uses simple adapter with custom rows in a list view
 */
//////////////////
public class MainActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		if (savedInstanceState == null) {
			getFragmentManager().beginTransaction()
					.add(R.id.container, new PlaceholderFragment()).commit();
		}
	}

	@Override
	protected void onResume() {
		super.onResume();

		String[] from = new String[] { "row_id", "x2", "x3", "^2" };
		int[] to = new int[] { R.id.item1, R.id.item2, R.id.item3, R.id.item4 };
		List<HashMap<String, String>> fillMaps = new ArrayList<>();

		// column headers

		for (int i = 0; i < 100; i++) {
			HashMap<String, String> map = new HashMap<>();
			if (i == 0) {
				map.put(from[0], from[0]);
				map.put(from[1], from[1]);
				map.put(from[2], from[2]);
				map.put(from[3], from[3]);
			} else {
				map.put(from[0], "" + i);
				map.put(from[1], "" + i * 2);
				map.put(from[2], "" + i * 3);
				map.put(from[3], "" + (int) (Math.pow(i, 2)));
			}
			fillMaps.add(map);
		}
		SimpleAdapter adapter = new SimpleAdapter(this, fillMaps,
				R.layout.custom_row, from, to);
		ListView lv1 = findViewById(R.id.listV_main);
		lv1.setAdapter(adapter);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {

		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		return id == R.id.action_settings || super.onOptionsItemSelected(item);
	}

	/**
	 * A placeholder fragment containing a simple view.
	 */
	public static class PlaceholderFragment extends Fragment {

		public PlaceholderFragment() {
		}

		@Override
		public View onCreateView(LayoutInflater inflater, ViewGroup container,
				Bundle savedInstanceState) {
//			View rootView = inflater.inflate(R.layout.fragment_main, container,
//					false);
			return inflater.inflate(R.layout.fragment_main, container,
					false);//rootView;
		}
	}

}
