package com.dstrube.myapplication;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.IBinder;
import android.os.Vibrator;
import android.util.Log;
import android.widget.Toast;

public class MyAlarmService extends Service {

    private static final String TAG = MyAlarmService.class.getSimpleName();

    private boolean isStarted = false;

    @Override
    public void onCreate() {
        Log.i(TAG, "MyAlarmService.onCreate()");
        Toast.makeText(this, "MyAlarmService.onCreate()", Toast.LENGTH_SHORT)
                .show();
    }

    @Override
    public IBinder onBind(Intent intent) {
        Log.i(TAG, "MyAlarmService.onBind()");
        Toast.makeText(this, "MyAlarmService.onBind()", Toast.LENGTH_SHORT)
                .show();
        return null;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.i(TAG, "MyAlarmService.onDestroy()");
        Toast.makeText(this, "MyAlarmService.onDestroy()", Toast.LENGTH_SHORT)
                .show();
        isStarted = false;
    }

    //Deprecated
//    @Override
//    public void onStart(Intent intent, int startId) {
//        super.onStart(intent, startId);
//        Toast.makeText(this, "MyAlarmService.onStart()", Toast.LENGTH_LONG).show();
//        Vibrator vibrator = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
//        vibrator.vibrate(500);
//    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
//        if (! isStarted) {
            Log.i(TAG, "Starting Vibrate");
            Toast.makeText(this, "Starting Vibrate", Toast.LENGTH_SHORT)
                    .show();
            Vibrator vibrator = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
            vibrator.vibrate(500);
            isStarted = true;
//        } else {
//            Log.w(TAG, "Try to start an already started service");
//        }

        return START_STICKY;

    }

    @Override
    public boolean onUnbind(Intent intent) {
        Log.i(TAG, "MyAlarmService.onUnbind()");
        Toast.makeText(this, "MyAlarmService.onUnbind()", Toast.LENGTH_LONG)
                .show();
        return super.onUnbind(intent);
    }

    //constructor is useful only for the following point...
    public MyAlarmService(){}
    //this doesn't work:
    public void stop(){
        Log.i(TAG, "Stopping as requested...");
        super.onDestroy();
    }
}