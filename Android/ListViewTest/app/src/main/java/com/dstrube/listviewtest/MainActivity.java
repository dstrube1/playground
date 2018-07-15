package com.dstrube.listviewtest;

import java.util.ArrayList;
import java.util.Arrays;

import android.app.Activity;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;

//////////////////
/* 
* ListViewTest
* Simeple text List view: planets
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
		// TODO Auto-generated method stub
		super.onResume();
		ListView mainListView = findViewById(R.id.mainListView);
		
		String[] planets = new String[] { "Mercury", "Venus", "Earth", "Mars",
				"Jupiter", "Saturn", "Uranus", "Neptune" };
		
		ArrayList<String> planetList = new ArrayList<>(Arrays.asList(planets));
		
//		planetList.addAll(Arrays.asList(planets));
		
		ArrayAdapter<String> listAdapter = new ArrayAdapter<>(this,
				R.layout.simplerow, planetList);
		listAdapter.add("Ceres");
		listAdapter.add("Pluto");
		listAdapter.add("Haumea");
		listAdapter.add("Makemake");
		listAdapter.add("Eris");
		mainListView.setAdapter(listAdapter);
		listAdapter.add("Vulcan");
		listAdapter.add("Kling");
		listAdapter.add("Kobold");
		listAdapter.notifyDataSetChanged();
		
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
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
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
			View rootView = inflater.inflate(R.layout.fragment_main, container,
					false);
			return rootView;
		}
	}

}
