package com.intent.intentservicedownload;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
//import android.net.Uri;
import android.os.Bundle;
//import android.os.Handler;
//import android.os.Message;
//import android.os.Messenger;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {
	private TextView textView;
	
	  private BroadcastReceiver receiver = new BroadcastReceiver() {
	    @Override
	    public void onReceive(Context context, Intent intent) {
	      Bundle bundle = intent.getExtras();
	      if (bundle != null) {
	        String string = bundle.getString(DownloadService.FILEPATH);
	        int resultCode = bundle.getInt(DownloadService.RESULT);
	        if (resultCode == RESULT_OK) {
	          Toast.makeText(MainActivity.this,
	              "Download complete. Download URI: " + string,
	              Toast.LENGTH_LONG).show();
	          textView.setText("Download done");
	        } else {
	          Toast.makeText(MainActivity.this, "Download failed",
	              Toast.LENGTH_LONG).show();
	          textView.setText("Download failed");
	        }
	      }
	    }
	  };

	  @Override
	  public void onCreate(Bundle savedInstanceState) {
	    super.onCreate(savedInstanceState);
	    setContentView(R.layout.activity_main);
	    textView = findViewById(R.id.status);
	  }

	  @Override
	  protected void onResume() {
	    super.onResume();
	    registerReceiver(receiver, new IntentFilter(DownloadService.NOTIFICATION));
	  }
	  
	  @Override
	  protected void onPause() {
	    super.onPause();
	    unregisterReceiver(receiver);
	  }

  public void onClick(View view) {
	    Intent intent = new Intent(this, DownloadService.class);
	    // add info for the service which file to download and where to store
	    intent.putExtra(DownloadService.FILENAME, "index1.html");
	    intent.putExtra(DownloadService.URL,"http://www.vogella.com/index.html");
	    startService(intent);
	    textView.setText("Service started");
  }
} 