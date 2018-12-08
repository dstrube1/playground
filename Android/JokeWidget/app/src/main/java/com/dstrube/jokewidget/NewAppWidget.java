package com.dstrube.jokewidget;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.RemoteViews;
import android.widget.Toast;

/**
 * Implementation of App Widget functionality.
 * App Widget Configuration implemented in {@link NewAppWidgetConfigureActivity NewAppWidgetConfigureActivity}
 */
public class NewAppWidget extends AppWidgetProvider {

    static final String TAG = NewAppWidget.class.getName();

    static void updateAppWidget(Context context, AppWidgetManager appWidgetManager,
                                int appWidgetId) {

        CharSequence widgetText = NewAppWidgetConfigureActivity.loadTitlePref(context, appWidgetId);
        // Construct the RemoteViews object
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.new_app_widget);
        views.setTextViewText(R.id.appwidget_text, widgetText);

        // Instruct the widget manager to update the widget
        appWidgetManager.updateAppWidget(appWidgetId, views);
    }

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        // There may be multiple widgets active, so update all of them
//        for (int appWidgetId : appWidgetIds) {
//            updateAppWidget(context, appWidgetManager, appWidgetId);
//        }
        final String onUpdateBegin = TAG + " : onUpdate begin";
        Toast.makeText(context, onUpdateBegin, Toast.LENGTH_SHORT).show();
        System.out.println(onUpdateBegin);
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
        final String onUpdateEnd = TAG + " : onUpdate end";
        Toast.makeText(context, onUpdateEnd, Toast.LENGTH_SHORT).show();
        System.out.println(onUpdateEnd);
    }

    public static void pushWidgetUpdate(Context context, RemoteViews remoteViews) {
        ComponentName myWidget = new ComponentName(context,
                NewAppWidget.class);
        AppWidgetManager manager = AppWidgetManager.getInstance(context);
        manager.updateAppWidget(myWidget, remoteViews);
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

    @Override
    public void onDeleted(Context context, int[] appWidgetIds) {
        // When the user deletes the widget, delete the preference associated with it.
//		super.onDeleted(context, appWidgetIds);
        for (int appWidgetId : appWidgetIds) {
            NewAppWidgetConfigureActivity.deleteTitlePref(context, appWidgetId);
        }
    }

    @Override
    public void onEnabled(Context context) {
        Log.i(TAG, "onEnabled");
//		super.onEnabled(context);
        // Enter relevant functionality for when the first widget is created
    }

    @Override
    public void onDisabled(Context context) {
        Log.i(TAG, "onDisabled");
//		super.onDisabled(context);
        // Enter relevant functionality for when the last widget is disabled
    }
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

