package com.dstrube.smsbroadcastreceiver

import android.content.Intent
import android.content.BroadcastReceiver
import android.content.Context
import android.telephony.SmsMessage


class SmsReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {

        val extras = intent.extras ?: return

//To display a Toast whenever there is an SMS.
        //Toast.makeText(context,"Recieved",Toast.LENGTH_LONG).show();

        val pdus = extras.get("pdus") as Array<Any>
        for (i in pdus.indices) {
            val sMessage = SmsMessage.createFromPdu(pdus[i] as ByteArray)
            val sender = sMessage.originatingAddress
            val body = sMessage.messageBody.toString()

            // A custom Intent that will used as another Broadcast
            val input = Intent("SmsMessage.intent.MAIN").putExtra("get_msg", sender + ":" + body)

            //You can place your check conditions here(on the SMS or the sender)
            //and then send another broadcast

            context.sendBroadcast(input)

            // This is used to abort the broadcast and can be used to silently
            // process incoming message and prevent it from further being
            // broadcasted. Avoid this, as this is not the way to program an app.
            // this.abortBroadcast();
        }
    }
}