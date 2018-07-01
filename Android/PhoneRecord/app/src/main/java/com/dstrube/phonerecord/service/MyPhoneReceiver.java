package com.dstrube.phonerecord.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Random;
import com.dstrube.phonerecord.R;
import android.annotation.SuppressLint;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
//import android.provider.Contacts;
//import android.provider.Contacts.ContactMethods;
import android.telephony.TelephonyManager;

public class MyPhoneReceiver extends BroadcastReceiver {

	@Override
	public void onReceive(Context context, Intent intent) {
		Bundle extras = intent.getExtras();
		if (extras != null) {
			String state = extras.getString(TelephonyManager.EXTRA_STATE);
			if (state != null && state.equals(TelephonyManager.EXTRA_STATE_RINGING)) {

				String phoneNumber = extras
						.getString(TelephonyManager.EXTRA_INCOMING_NUMBER);
				String callerName = getCallerName();
				String dateTime = getDateTime();
				String latitude = getLat(context);
				String longitude = getLng(context);

				String[] columns = context.getResources().getStringArray(
						R.array.column_names);

				HashMap<String, String> datum = new HashMap<>();

				Random rand = new Random();

				datum.put(columns[0], String.valueOf(rand.nextInt()));
				datum.put(columns[1], phoneNumber);
				datum.put(columns[2], callerName);
				datum.put(columns[3], dateTime);
				datum.put(columns[4], latitude);
				datum.put(columns[5], longitude);

				// A custom Intent that will used as another Broadcast
				Intent in = new Intent("PhoneRecord.intent.MAIN").putExtra(
						"datum", datum);

				context.sendBroadcast(in);
			}
		}
	}

	private String getCallerName() {
		// TODO
		return "Pudding Tame";
	}

	@SuppressLint("SimpleDateFormat")
	private String getDateTime() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String now = dateFormat.format(Calendar.getInstance().getTime());
		return now;
	}

	private String getLat(Context context) {
//		gps = new GPSTracker(context);
//		if (!gps.canGetLocation()) {
			return "33.986234";
//		}
//		double latitude = gps.getLatitude();
//		return String.valueOf(latitude);
	}

	private String getLng(Context context) {
//		gps = new GPSTracker(context);
//		if (!gps.canGetLocation()) {
			return "-84.202446";
//		}
//		double longitude = gps.getLongitude();
//		return String.valueOf(longitude);
	}

}
