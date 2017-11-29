package com.dstrube.intenttest2;

import java.util.ArrayList;

import android.support.v7.app.ActionBarActivity;
//import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.os.Parcelable;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;

//////////////////
/* 
* IntentTest2
* two versions: 1 with Serializable, 1 with Parcelable
* both have screen 1 with 1 button
* button opens screen 2 with arrayList populated ListView, where arrayList is populated from screen 1
*/
//////////////////

public class MainActivity extends ActionBarActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		if (savedInstanceState == null) {
			getSupportFragmentManager().beginTransaction()
					.add(R.id.container, new PlaceholderFragment()).commit();
		}
	}

	public void Next(View v) {
		Intent intent = new Intent(this,Screen2.class);
		Context ctx = getApplicationContext();
    	Resources res = ctx.getResources();
    	
		String[] names = res.getStringArray(R.array.employee_names);
		String[] emailAddresses = res.getStringArray(R.array.employee_email_addresses);
		String[] phoneNumbers = res.getStringArray(R.array.employee_phone_numbers);
		
		ArrayList<Employee_P> list = new ArrayList<Employee_P>();
		Employee_P e;
		for (int i=0; i < names.length; i++){
			e = new Employee_P(names[i], emailAddresses[i], phoneNumbers[i]);
			list.add(e);
		}
		
//		intent.putExtra("names",names);
//		intent.putExtra("emailAddresses",emailAddresses);
//		intent.putExtra("phoneNumbers",phoneNumbers);
		Bundle bundle = new Bundle();
		bundle.putParcelableArrayList("employees",(ArrayList<? extends Parcelable>) list);
		intent.putExtras(bundle);
//		intent.putParcelableArrayListExtra("employees",(ArrayList<Employee_P>) list);
		
		startActivity(intent);
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
