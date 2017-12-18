package com.dstrube.intentservicetest;

import android.app.IntentService;
import android.content.Intent;

public class MyIntentService extends IntentService {

	public static final String MESSAGE_PROCESSED = "com.dstrube.intentservicetest";
	
	public MyIntentService(){
		super("MyIntentService");
	}

	@Override
	protected void onHandleIntent(Intent intent) {
		String text1 = intent.getStringExtra("text1");
		String text2 = intent.getStringExtra("text2");
		int i1 = Integer.parseInt(text1);
		int i2 = Integer.parseInt(text2);
		publishResults(i1+i2);
	  }

	  private void publishResults(int result) {
	    Intent intent = new Intent(MESSAGE_PROCESSED);
	    intent.putExtra("result", result);
	    sendBroadcast(intent);
	  }

}
