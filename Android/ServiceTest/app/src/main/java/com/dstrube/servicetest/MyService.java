package com.dstrube.servicetest;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.widget.Toast;

public class MyService extends Service {

	public static boolean isRunning = false;

	@Override
	public IBinder onBind(Intent intent) {
		return null;
	}

	@Override
	public int onStartCommand(Intent intent, int flags, int startId) {
		
		if (isRunning) {
			Toast.makeText(this, "Already started", Toast.LENGTH_LONG).show();	
		}else{
			Toast.makeText(this, "Service started", Toast.LENGTH_LONG).show();
			isRunning = true;
		}
		//once started, no harm in starting again
			return START_STICKY; // super.onStartCommand(intent, flags,
									// startId);
	}

	@Override
	public void onDestroy() {
		//NOTE: Must handle duplicate calls to destroy elsewhere
//		if (isRunning) {
			super.onDestroy();
			isRunning = false;
			Toast.makeText(this, "Service destroyed", Toast.LENGTH_LONG).show();
	//	}else{
		//	Toast.makeText(this, "Already stopped", Toast.LENGTH_LONG).show();
		//}
	}

}
