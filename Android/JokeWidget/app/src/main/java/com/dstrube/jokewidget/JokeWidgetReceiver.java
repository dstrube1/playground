package com.dstrube.jokewidget;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.RemoteViews;
import android.widget.Toast;

//meticulously copied (and adapted) from
//http://javatechig.com/android/app-widgets-example-in-android
public class JokeWidgetReceiver extends BroadcastReceiver {

    public static int clickCount = 0;
    private String msg[] = null;

    @Override
    public void onReceive(Context context, Intent intent) {
//		Toast.makeText(context, "begin received", Toast.LENGTH_SHORT).show();
        final String action = intent.getAction();
        if (action != null && action.equals(WidgetUtils.WIDGET_UPDATE_ACTION)) {
            updateWidgetPictureAndButtonListener(context);
        } else {
            Toast.makeText(context, "Null action", Toast.LENGTH_SHORT).show();
        }
//		Toast.makeText(context, "end received", Toast.LENGTH_SHORT).show();
    }

    private void updateWidgetPictureAndButtonListener(Context context) {
        Toast.makeText(context, "begin updateWidgetPictureAndButtonListener", Toast.LENGTH_SHORT).show();
        RemoteViews remoteViews = new RemoteViews(context.getPackageName(),
                R.layout.widget_layout);

        // updating view
        remoteViews.setTextViewText(R.id.title, getTitle());
        remoteViews.setTextViewText(R.id.desc, getDesc(context));

        // re-registering for click listener
        remoteViews.setOnClickPendingIntent(R.id.sync_button,
                NewAppWidget.buildButtonPendingIntent(context));

        NewAppWidget.pushWidgetUpdate(context.getApplicationContext(),
                remoteViews);
//		Toast.makeText(context, "end updateWidgetPictureAndButtonListener", Toast.LENGTH_SHORT).show();
    }

    private String getDesc(Context context) {
        // some static jokes from xml
        msg = context.getResources().getStringArray(R.array.jokes);
        if (clickCount >= msg.length) {
            clickCount = 0;
        }
        return msg[clickCount];
    }

    private String getTitle() {
        return "Funny Jokes";
    }
}
