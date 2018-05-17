package com.dstrube.sendemail

import android.app.Activity
import android.os.Bundle
import android.view.View
import android.widget.EditText
import android.widget.Toast
import android.content.Intent
//import android.support.test.espresso.matcher.ViewMatchers.isChecked
import android.widget.CheckBox


class MainActivity : Activity() {

    private var emailAddressText: EditText? = null
    private var emailBodyText: EditText? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onResume() {
        super.onResume()
        emailAddressText = findViewById(R.id.emailAddressText)
        emailBodyText = findViewById(R.id.emailBodyText)
    }

    fun Send(v: View) {
        val emailAddress = emailAddressText?.text.toString()
        val emailBody = emailBodyText?.text.toString()
        if (emailAddress == "") {
            Toast.makeText(applicationContext, "Please enter an email address", Toast.LENGTH_LONG).show()
            return
        }
        if (emailBody == "") {
            Toast.makeText(applicationContext, "Please enter an email message", Toast.LENGTH_LONG).show()
            return
        }

        val intent = Intent(Intent.ACTION_SEND)
        intent.type = "message/rfc822"
        intent.putExtra(Intent.EXTRA_EMAIL, arrayOf(emailAddress))
        intent.putExtra(Intent.EXTRA_SUBJECT, "subject of email")
        intent.putExtra(Intent.EXTRA_TEXT, emailBody)

        val checkBox = findViewById<CheckBox>(R.id.checkBox1)
        if (checkBox.isChecked) {
            intent.type = "image/png"

            val uris = ArrayList<String>()

            //TODO
            //uris.add(Uri.parse("android.resource://" + getPackageName() + "/" + R.drawable.ic_launcher));

            intent.putExtra(Intent.EXTRA_STREAM, uris)

        }

        try {
            startActivity(Intent.createChooser(intent, "Send mail..."))
        } catch (ex: android.content.ActivityNotFoundException) {
            Toast.makeText(applicationContext, "There are no email clients installed.", Toast.LENGTH_LONG).show()
        }

    }

    fun Attachment(v: View) {
        val checkBox = findViewById<CheckBox>(R.id.checkBox1)
        if (checkBox.isChecked) {
            //			Toast.makeText(getApplicationContext(), "Checked", Toast.LENGTH_SHORT).show();
        } else {
            //			Toast.makeText(getApplicationContext(), "Unchecked", Toast.LENGTH_SHORT).show();
        }
    }

}
