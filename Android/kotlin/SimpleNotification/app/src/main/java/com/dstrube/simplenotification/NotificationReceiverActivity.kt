package com.dstrube.simplenotification

import android.os.Bundle
import android.app.Activity


class NotificationReceiverActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.notification_alert)
    }
}