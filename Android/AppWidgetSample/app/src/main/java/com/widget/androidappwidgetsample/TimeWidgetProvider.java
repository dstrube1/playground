package com.widget.androidappwidgetsample;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.RemoteViews;
import android.widget.Toast;

import java.util.Arrays;

public class TimeWidgetProvider extends AppWidgetProvider {
    private static final String TAG = TimeWidgetProvider.class.getName();

    @Override
    public void onDeleted(Context context, int[] appWidgetIds) {
        Toast.makeText(context, "TimeWidgetRemoved id(s):" + Arrays.toString(appWidgetIds), Toast.LENGTH_LONG).show();
        System.out.println("Widget Id ## " + Arrays.toString(appWidgetIds));
        super.onDeleted(context, appWidgetIds);
    }


    @Override
    public void onDisabled(Context context) {
        Toast.makeText(context, "onDisabled():last widget instance removed", Toast.LENGTH_SHORT).show();
        Intent intent = new Intent(context, AlarmManagerBroadcastReceiver.class);
        PendingIntent sender = PendingIntent.getBroadcast(context, 0, intent, 0);
        AlarmManager alarmManager = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
        if (alarmManager != null) {
            alarmManager.cancel(sender);
        } else {
            Log.e(TAG, "Null AlarmManager");
        }
        super.onDisabled(context);
    }

    @Override
    public void onEnabled(Context context) {
        super.onEnabled(context);
        AlarmManager am = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
        Intent intent = new Intent(context, AlarmManagerBroadcastReceiver.class);
        PendingIntent pi = PendingIntent.getBroadcast(context, 0, intent, 0);
        // After after 3 seconds
        if (am != null) {
            am.setRepeating(AlarmManager.RTC_WAKEUP, System.currentTimeMillis() + 100 * 3, 5000, pi);
        } else {
            Log.e(TAG, "Null AlarmManager");
        }
    }

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        ComponentName thisWidget = new ComponentName(context, TimeWidgetProvider.class);
        Toast.makeText(context, "on Update widget called", Toast.LENGTH_LONG).show();
        for (int widgetId : appWidgetManager.getAppWidgetIds(thisWidget)) {

            // Get the remote views
            RemoteViews remoteViews = new RemoteViews(context.getPackageName(), R.layout.activity_android_widget);
            // Set the text with the current time.
            remoteViews.setTextViewText(R.id.tvTime, Utility.getCurrentTime("hh:mm:ss a"));
            appWidgetManager.updateAppWidget(widgetId, remoteViews);
        }
    }

    @Override
    public void onAppWidgetOptionsChanged(Context context,
                                          AppWidgetManager appWidgetManager, int appWidgetId,
                                          Bundle newOptions) {
        // Do some operation here, once you see that the widget has change its
        // size or position.
        Toast.makeText(context, "onAppWidgetOptionsChanged() called", Toast.LENGTH_SHORT).show();
    }
}