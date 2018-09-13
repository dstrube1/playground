package com.dstrube.intenttest2;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import android.support.v7.app.ActionBarActivity;
//import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import android.os.Parcelable;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.Toast;
//import android.os.Build;

public class Screen2 extends ActionBarActivity {

	private Intent intent;
	private ArrayList<Parcelable> employeeList_P;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_screen2);

		if (savedInstanceState == null) {
			getSupportFragmentManager().beginTransaction()
					.add(R.id.container, new PlaceholderFragment()).commit();
		}
		intent = getIntent();
	}

//	@Override
	protected void onResume_S() {
		super.onResume();
		ListView lv= (ListView)findViewById(R.id.listview);
        String[] from = new String[] {"rowid", "name", "mail", "phone"};
//        int[] to = new int[] { R.id.item1, R.id.item2, R.id.item3, R.id.item4 };
        ArrayList emp1 =  intent.getParcelableArrayListExtra("employees");

	}
	
	@Override
	protected void onResume() {
		super.onResume();
		ListView listView = (ListView)findViewById(R.id.listview);
		
		Bundle extras = getIntent().getExtras();
		ArrayList<Employee_P> arraylist = extras.getParcelableArrayList("employees");

		if (arraylist != null) {

			MyAdapter adapter = new MyAdapter(this, arraylist);
			
			listView.setAdapter(adapter);

		}
		// employeeList = intent.getParcelableArrayListExtra("employees");

	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {

		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.screen2, menu);
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
			View rootView = inflater.inflate(R.layout.fragment_screen2,
					container, false);
			return rootView;
		}
	}

}
