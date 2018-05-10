package com.dstrube.simplenotification

import android.app.Activity
import android.app.Notification
import android.os.Bundle
//import android.app.Notification.FLAG_AUTO_CANCEL
//import com.sun.tools.javac.tree.TreeInfo.flags
//import android.content.Context.NOTIFICATION_SERVICE
import android.app.NotificationManager
//import com.dstrube.simplenotification.R.mipmap.ic_launcher
//import jdk.nashorn.internal.objects.NativeFunction.call
//import android.app.Notification.BigTextStyle
import android.media.RingtoneManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.view.View


class MainActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun createNotification(view: View) {
        // Prepare intent which is triggered if the
        // notification is selected
        val intent = Intent(this, NotificationReceiverActivity::class.java)
        val pIntent = PendingIntent.getActivity(this, 0, intent, 0)

        // Build notification
        // Actions are just fake
        val soundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)//TYPE_NOTIFICATION);

        val noti = Notification.Builder(this)
                .setTicker("New Mail!")
                .setContentTitle("New mail from " + "test@gmail.com")
                .setContentText("Android allows to put notification into ...").setSmallIcon(R.drawable.ic_launcher)
                .setContentIntent(pIntent)
                //TODO Detect size of screen and wrap as needed
                .setStyle(Notification.BigTextStyle().bigText("Android allows users to put notification " +
                        "into the titlebar of your application. The user can expand the notification bar and, " +
                        "by selecting the notification, the user can trigger another activity."))
                .addAction(R.drawable.call, "Call", pIntent)
                .setSound(soundUri)
                .addAction(R.drawable.ic_launcher, "More", pIntent)
                .addAction(R.drawable.ic_launcher, "And more", pIntent).build()

        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        // hide the notification after its selected

        noti.flags = noti.flags or Notification.FLAG_AUTO_CANCEL

        notificationManager.notify(0, noti)

    }
}
