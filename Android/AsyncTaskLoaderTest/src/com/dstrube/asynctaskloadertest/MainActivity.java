package com.dstrube.asynctaskloadertest;

import java.util.ArrayList;

import android.app.Activity;
//import android.app.ActionBar;
import android.app.Fragment;
import android.content.AsyncTaskLoader;
import android.content.Context;
import android.content.res.Resources;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;
//import android.os.Build;

public class MainActivity extends Activity {

	public ListView listView;
	ArrayList<String> list = new ArrayList<String>();

	ArrayAdapter<String> adapter;

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
		listView = (ListView) findViewById(R.id.listView1);
//		adapter = new ArrayAdapter<String>(MainActivity.this,
//				android.R.layout.simple_list_item_1, android.R.id.text1, list);
//
//		listView.setAdapter(adapter);
	}

	public void Click1(View v) {
		MyObject object = new MyObject(getApplicationContext(), listView);
		new MyAsyncTask().execute(object);
	}
	
	public void Click2(View v){
		MyAsyncTaskLoader loader = new MyAsyncTaskLoader(getApplicationContext());
		loader.forceLoad();
	}

	private class MyAsyncTask extends
			AsyncTask<MyObject, Void, ArrayList<String>> {
		@Override
		protected ArrayList<String> doInBackground(MyObject... params) {
			Context ctx = params[0].context;

			Resources res = ctx.getResources();

			final String[] days = res.getStringArray(R.array.days);

			list = new ArrayList<String>();

			for (int i = 0; i < days.length; i++) {
				list.add(days[i]);
			}

			return list;
		}

		@Override
		protected void onPostExecute(ArrayList<String> result) {
			adapter = new ArrayAdapter<String>(MainActivity.this,
					android.R.layout.simple_list_item_1, android.R.id.text1,
					list);

			listView.setAdapter(adapter);
			// adapter.notifyDataSetChanged();
		}

	}

	private class MyAsyncTaskLoader extends AsyncTaskLoader<Object> {

		public MyAsyncTaskLoader(Context context) {
			super(context);
		}
		
		@Override
		protected void onStartLoading() {
			super.onStartLoading();
		}
		@Override
		protected void onStopLoading() {
			super.onStopLoading();
		}
		@Override
		protected void onReset() {
			super.onReset();
		}

		@Override
		public Object loadInBackground() {
			final String[] days = getResources().getStringArray(R.array.days);
			list = new ArrayList<String>();

			for (int i = days.length-1; i >=0 ; i--) {
				list.add(days[i]);
			}
			adapter = new ArrayAdapter<String>(MainActivity.this,
					android.R.layout.simple_list_item_1, android.R.id.text1,
					list);

			listView.setAdapter(adapter);
			return null;
		}
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
