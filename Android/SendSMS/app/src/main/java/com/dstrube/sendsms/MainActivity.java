package com.dstrube.sendsms;

import android.content.pm.PackageManager;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.telephony.SmsManager;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    protected void onResume() {
        super.onResume();
        final String perm = "android.permission.SEND_SMS";
        final int check = checkSelfPermission(perm);
        if (check == PackageManager.PERMISSION_DENIED) {
            String[] perms = {perm};
            requestPermissions(perms, PackageManager.PERMISSION_GRANTED);
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        //super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == PackageManager.PERMISSION_GRANTED){
            //great
        }
        else {
            Toast.makeText(this, "SEND_SMS permission required", Toast.LENGTH_LONG).show();
        }
    }

    public void Send(View v) {
        EditText phoneText =  findViewById(R.id.phone);
        EditText messageText = findViewById(R.id.message);
        String phone = phoneText.getText().toString();
        String message = messageText.getText().toString();
        if (phone.equals("")) {
            Toast.makeText(getApplicationContext(),
                    "Please enter a phone number", Toast.LENGTH_LONG).show();
            return;
        }
        if (message.equals("")) {
            Toast.makeText(getApplicationContext(), "Please enter a message",
                    Toast.LENGTH_LONG).show();
            return;
        }

        try {
            SmsManager manager = SmsManager.getDefault();
            manager.sendTextMessage(phone, null, message, null, null);
            Toast.makeText(getApplicationContext(), "SMS Sent!",
                    Toast.LENGTH_LONG).show();
        } catch (Exception e) {
            Toast.makeText(getApplicationContext(),
                    "SMS failed, please try again later!", Toast.LENGTH_LONG)
                    .show();
            e.printStackTrace();
        }
    }
}
