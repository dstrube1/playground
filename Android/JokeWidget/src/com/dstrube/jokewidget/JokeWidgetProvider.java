package com.dstrube.jokewidget;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
//import android.os.Bundle;
import android.widget.RemoteViews;
import android.widget.Toast;

public class JokeWidgetProvider extends AppWidgetProvider {

	@Override
	public void onUpdate(Context context, AppWidgetManager appWidgetManager,
			int[] appWidgetIds) {
		Toast.makeText(context, "JokeWidgetProvider : onUpdate begin", Toast.LENGTH_SHORT).show();
		System.out.println("JokeWidgetProvider : onUpdate begin");
//		super.onUpdate(context, appWidgetManager, appWidgetIds);
		// initializing widget layout
        RemoteViews remoteViews = new RemoteViews(context.getPackageName(),
                R.layout.widget_layout);
 
        // register for button event
        remoteViews.setOnClickPendingIntent(R.id.sync_button,
                buildButtonPendingIntent(context));
 
        // updating view with initial data
        remoteViews.setTextViewText(R.id.title, getTitle());
        remoteViews.setTextViewText(R.id.desc, getDesc());
 
        // request for widget update
        pushWidgetUpdate(context, remoteViews);
		Toast.makeText(context, "JokeWidgetProvider : onUpdate end", Toast.LENGTH_SHORT).show();
		System.out.println("onUpdate end");
	}

	public static PendingIntent buildButtonPendingIntent(Context context) {
        ++JokeWidgetReceiver.clickCount;
 
        // initiate widget update request
        Intent intent = new Intent();
        intent.setAction(WidgetUtils.WIDGET_UPDATE_ACTION);
        return PendingIntent.getBroadcast(context, 0, intent,
                PendingIntent.FLAG_UPDATE_CURRENT);
    }
	
	private CharSequence getDesc() {
        return "Sync to see some of our funniest joke collections";
    }
 
    private CharSequence getTitle() {
        return "Funny Jokes";
    }
	
	public static void pushWidgetUpdate(Context context, RemoteViews remoteViews) {
        ComponentName myWidget = new ComponentName(context,
        		JokeWidgetProvider.class);
        AppWidgetManager manager = AppWidgetManager.getInstance(context);
        manager.updateAppWidget(myWidget, remoteViews);
	}
	
//	@Override
//	public void onDeleted(Context context, int[] appWidgetIds) {
//		System.out.println("JokeWidgetProvider : onDeleted begin");
//		super.onDeleted(context, appWidgetIds);
//		System.out.println("onDeleted end");
//	}
//	@Override
//	public void onDisabled(Context context) {
//		System.out.println("JokeWidgetProvider : onDisabled begin");
//		super.onDisabled(context);
//		System.out.println("onDisabled end");
//	}
//	@Override
//	public void onEnabled(Context context) {
//		System.out.println("JokeWidgetProvider : onEnabled begin");
//		super.onEnabled(context);
//		System.out.println("onEnabled end");
//	}
	//requires API 16 or better
//	@Override
//	public void onAppWidgetOptionsChanged(Context context,
//			AppWidgetManager appWidgetManager, int appWidgetId,
//			Bundle newOptions) {
//		System.out.println("JokeWidgetProvider : onUpdate begin");
//		super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId,
//				newOptions);
//		System.out.println("onUpdate end");
//	}
}
