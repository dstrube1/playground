package com.test.custonlistview;

import android.os.Bundle;
import android.app.Activity;
import com.test.customList.service.MusicAsyncTask;

public class MainActivity extends Activity {

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		MusicAsyncTask rest = new MusicAsyncTask(this);
		rest.execute(new String[] { "getMusic" });
	}
}