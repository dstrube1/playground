package com.example.phonebroadcastreceiver;

import android.content.Intent;
import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;

public class MainActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
	}

    @Override
    protected void onResume() {
        super.onResume();
        MyPhoneReceiver receiver = new MyPhoneReceiver();
        receiver.onReceive(this, new Intent());
    }

    //	@Override
//	public boolean onCreateOptionsMenu(Menu menu) {
//		// Inflate the menu; this adds items to the action bar if it is present.
//		getMenuInflater().inflate(R.menu.main, menu);
//		return true;
//	}

}
