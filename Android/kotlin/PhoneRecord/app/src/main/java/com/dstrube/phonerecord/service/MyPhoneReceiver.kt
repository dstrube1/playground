package com.dstrube.phonerecord.service

import android.annotation.SuppressLint
import android.content.Intent
import android.telephony.TelephonyManager
import android.content.BroadcastReceiver
import android.content.Context
import com.dstrube.phonerecord.R
import java.text.SimpleDateFormat
import java.util.*


class MyPhoneReceiver : BroadcastReceiver() {

    private val callerName: String = "Pudding Tame"

    private val dateTime: String
        @SuppressLint("SimpleDateFormat")
        get() {
            val dateFormat = SimpleDateFormat("yyyy-MM-dd HH:mm")
            return dateFormat.format(Calendar.getInstance().time)
        }

    override fun onReceive(context: Context, intent: Intent) {
        val extras = intent.extras
        if (extras != null) {
            val state = extras.getString(TelephonyManager.EXTRA_STATE)
            if (state == TelephonyManager.EXTRA_STATE_RINGING) {

                val phoneNumber = extras
                        .getString(TelephonyManager.EXTRA_INCOMING_NUMBER)
                val callerName = callerName
                val dateTime = dateTime
                val latitude = getLat(context)
                val longitude = getLng(context)

                val columns = context.resources.getStringArray(
                        R.array.column_names)

                val datum = HashMap<String, String>()

                val rand = Random()

                datum[columns[0]] = (rand.nextInt().toString())
                datum[columns[1]] = phoneNumber
                datum[columns[2]] = callerName
                datum[columns[3]] = dateTime
                datum[columns[4]] = latitude
                datum[columns[5]] = longitude

                // A custom Intent that will used as another Broadcast
                val newIntent = Intent("PhoneRecord.intent.MAIN").putExtra(
                        "datum", datum)

                context.sendBroadcast(newIntent)
            }
        }
    }

    private fun getLat(context: Context): String {
        //		gps = new GPSTracker(context);
        //		if (!gps.canGetLocation()) {
        return "33.986234"
        //		}
        //		double latitude = gps.getLatitude();
        //		return String.valueOf(latitude);
    }

    private fun getLng(context: Context): String {
        //		gps = new GPSTracker(context);
        //		if (!gps.canGetLocation()) {
        return "-84.202446"
        //		}
        //		double longitude = gps.getLongitude();
        //		return String.valueOf(longitude);
    }

}
