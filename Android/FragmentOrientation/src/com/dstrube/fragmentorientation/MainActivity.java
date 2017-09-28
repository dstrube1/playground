package com.dstrube.fragmentorientation;

import java.util.ArrayList;

import android.support.v7.app.ActionBarActivity;
//import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.content.Context;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
//import android.widget.Toast;
//import android.os.Build;

//////////////////
/* 
 * FragmentOrientation
 * Show text boxes and a button in Portrait,
 * Show a ListView of Names and Descriptions in Landscape
 */
//////////////////
public class MainActivity extends ActionBarActivity {

	private String state;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		if (savedInstanceState == null) {
			getSupportFragmentManager().beginTransaction()
					.add(R.id.container, new PlaceholderFragment()).commit();
		}
	}

	@Override
	protected void onResume() {
		super.onResume();
		ListView listView = (ListView) findViewById(R.id.listView1);
		Context ctx = getApplicationContext();
		Resources res = ctx.getResources();
		String[] names = res.getStringArray(R.array.names);
		String[] descriptions = res.getStringArray(R.array.descriptions);

		ArrayList<ListObject> list = new ArrayList<ListObject>();
		for (int i = 0; i < names.length; i++) {
			ListObject L = new ListObject(names[i], descriptions[i]);
			list.add(L);
		}

		try{
		if (list != null) {
			MyAdapter adapter = new MyAdapter(this, list);

			listView.setAdapter(adapter);
		}
		}catch(Exception e){
			//Toast.makeText(getApplicationContext(), e.toString(), Toast.LENGTH_LONG).show();
		}
	}
	
	@Override
	protected void onSaveInstanceState(Bundle outState) {
		super.onSaveInstanceState(outState);
		state = "Saving Instance..";
		System.out.println(state);
//		Toast.makeText(getApplicationContext(), state, Toast.LENGTH_SHORT).show();
	}
	@Override
	protected void onDestroy() {
		super.onDestroy();
		state = "Destroying...";
		System.out.println(state);
//		Toast.makeText(getApplicationContext(), state, Toast.LENGTH_SHORT).show();
	}
	@Override
	protected void onRestoreInstanceState(Bundle savedInstanceState) {
		super.onRestoreInstanceState(savedInstanceState);
		state = "Restoring Instance..";
		System.out.println(state);
//		Toast.makeText(getApplicationContext(), state, Toast.LENGTH_SHORT).show();	
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
