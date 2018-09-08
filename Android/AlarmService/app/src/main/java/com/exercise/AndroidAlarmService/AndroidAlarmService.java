package com.exercise.AndroidAlarmService;

import java.util.Calendar;

import android.app.Activity;
import android.app.AlarmManager;
import android.app.PendingIntent;
//import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
//import android.os.Vibrator;
import android.view.View;
//import android.widget.Button;
import android.widget.Toast;

public class AndroidAlarmService extends Activity {

	private PendingIntent pendingIntent;

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

	}

	public void StartAlarm(View arg0) {

		Intent myIntent = new Intent(AndroidAlarmService.this,MyAlarmService.class);
		pendingIntent = PendingIntent.getService(AndroidAlarmService.this, 0, myIntent, 0);
		
		AlarmManager alarmManager = (AlarmManager) getSystemService(ALARM_SERVICE);
		
		// Calendar takes the responsibility to initiate/ Start the service.
		// Service is not starting from the current activity
		
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(System.currentTimeMillis());
		calendar.add(Calendar.SECOND, 10);
		if (alarmManager != null) {
			alarmManager.set(AlarmManager.RTC_WAKEUP,calendar.getTimeInMillis(), pendingIntent);
		}
		Toast.makeText(AndroidAlarmService.this, "Start Alarm",Toast.LENGTH_LONG).show();
	}

	public void CancelAlarm(View arg0) {
		AlarmManager alarmManager = (AlarmManager) getSystemService(ALARM_SERVICE);
		if (alarmManager != null) {
			alarmManager.cancel(pendingIntent);
		}

		// Tell the user about what we did.
		Toast.makeText(AndroidAlarmService.this, "Cancel!",
				Toast.LENGTH_LONG).show();

	}
}