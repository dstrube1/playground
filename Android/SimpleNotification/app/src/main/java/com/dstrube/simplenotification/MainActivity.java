package com.dstrube.simplenotification;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.media.RingtoneManager;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void createNotification(View view) {
        // Prepare intent which is triggered if the
        // notification is selected
        Intent intent = new Intent(this, NotificationReceiverActivity.class);
        PendingIntent pIntent = PendingIntent.getActivity(this, 0, intent, 0);

        // Build notification
        // Actions are just fake
        Uri soundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM);//TYPE_NOTIFICATION);

        Notification noti = new Notification.Builder(this)
                .setTicker("New Mail!")
                .setContentTitle("New mail from " + "test@gmail.com")
                .setContentText("Android allows to put notification into ...").setSmallIcon(R.drawable.ic_launcher)
                .setContentIntent(pIntent)
                //TODO Detect size of screen and wrap as needed
                .setStyle(new Notification.BigTextStyle().bigText("Android allows users to put notification into the titlebar of your application. The user can expand the notification bar and, by selecting the notification, the user can trigger another activity."))
                .addAction(R.drawable.call, "Call", pIntent)
                .setSound(soundUri)
                .addAction(R.drawable.ic_launcher, "More", pIntent)
                .addAction(R.drawable.ic_launcher, "And more", pIntent).build();

        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        // hide the notification after its selected

        noti.flags |= Notification.FLAG_AUTO_CANCEL;

        notificationManager.notify(0, noti);

    }
}
