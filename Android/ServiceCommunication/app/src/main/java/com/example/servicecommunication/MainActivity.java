package com.example.servicecommunication;

import java.util.ArrayList;
import java.util.List;

import android.app.ListActivity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Toast;

public class MainActivity extends ListActivity {
	
	private LocalWordService localWorldService;

	/** Called when the activity is first created. */

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		wordList = new ArrayList<>();
		adapter = new ArrayAdapter<>(this,
				android.R.layout.simple_list_item_1, android.R.id.text1,
				wordList);
		setListAdapter(adapter);

	}

	@Override
	protected void onResume() {
		super.onResume();
		Intent i = new Intent (this, LocalWordService.class);
		bindService(i, mConnection,Context.BIND_AUTO_CREATE);
		
		startService(i);
	}

	@Override
	protected void onPause() {
		super.onPause();
		unbindService(mConnection);
	}

	private ServiceConnection mConnection = new ServiceConnection() {

		public void onServiceConnected(ComponentName className, IBinder binder) {
			localWorldService = ((LocalWordService.MyBinder) binder).getService();
			Toast.makeText(MainActivity.this, "Connected", Toast.LENGTH_SHORT).show();
		}

		public void onServiceDisconnected(ComponentName className) {
			localWorldService = null;
		}
	};
	
	private ArrayAdapter<String> adapter;
	private List<String> wordList;

	public void showServiceData(View view) {
		if (localWorldService != null) {
			Toast.makeText(this,
					"Number of elements # "
							+ localWorldService.getWordList().size(),
					Toast.LENGTH_SHORT).show();
			wordList.clear();
			wordList.addAll(localWorldService.getWordList());
			adapter.notifyDataSetChanged();
		}
	}
}