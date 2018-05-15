package com.dstrube.sendsms

import android.app.Activity
import android.os.Bundle
import android.widget.Toast
import android.widget.EditText
import android.content.pm.PackageManager
//import android.support.annotation.NonNull
import android.telephony.SmsManager
import android.view.View


class MainActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onResume() {
        super.onResume()
        val perm = "android.permission.SEND_SMS"
        val check = checkSelfPermission(perm)
        if (check == PackageManager.PERMISSION_DENIED) {
            val perms = arrayOf(perm)
            requestPermissions(perms, PackageManager.PERMISSION_GRANTED)
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        //super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == PackageManager.PERMISSION_GRANTED) {
            //great
        } else {
            Toast.makeText(this, "SEND_SMS permission required", Toast.LENGTH_LONG).show()
        }
    }

    fun Send(v: View) {
        val phoneText = findViewById<EditText>(R.id.phone)
        val messageText = findViewById<EditText>(R.id.message)
        val phone = phoneText.text.toString()
        val message = messageText.text.toString()
        if (phone == "") {
            Toast.makeText(applicationContext,
                    "Please enter a phone number", Toast.LENGTH_LONG).show()
            return
        }
        if (message == "") {
            Toast.makeText(applicationContext, "Please enter a message",
                    Toast.LENGTH_LONG).show()
            return
        }

        try {
            val manager = SmsManager.getDefault()
            manager.sendTextMessage(phone, null, message, null, null)
            Toast.makeText(applicationContext, "SMS Sent!",
                    Toast.LENGTH_LONG).show()
        } catch (e: Exception) {
            Toast.makeText(applicationContext,
                    "SMS failed, please try again later!", Toast.LENGTH_LONG)
                    .show()
            e.printStackTrace()
        }

    }
}
