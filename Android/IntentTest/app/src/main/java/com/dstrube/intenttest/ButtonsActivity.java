package com.dstrube.intenttest;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Bundle;
import android.telephony.TelephonyManager;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ButtonsActivity extends Activity {

    static String textRearranged;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_buttons);
    }

    @Override
    protected void onResume() {
        super.onResume();

        final Button dialer = findViewById(R.id.dialer);
        dialer.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                final TelephonyManager tMgr = (TelephonyManager) v.getContext().getSystemService(Context.TELEPHONY_SERVICE);
                //Approach 1:
//                if (checkSelfPermission(Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
//                    // Consider calling
//                    //    Activity#requestPermissions
//                    // here to request the missing permissions, and then overriding
//                    //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
//                    //                                          int[] grantResults)
//                    // to handle the case where the user grants the permission. See the documentation
//                    // for Activity#requestPermissions for more details.
//                    Toast.makeText(ButtonsActivity.this, "Unable to get phone number - 1", Toast.LENGTH_LONG).show();
//                    return;
//                }

                //Approach 2:
                try {
                    @SuppressLint("HardwareIds") final String mPhoneNumber = tMgr != null ? tMgr.getLine1Number() : "666";
                    final Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + mPhoneNumber));
                    startActivity(intent);
                } catch (SecurityException exception) {
                    Toast.makeText(v.getContext(), "Unable to get phone number. Go to app's settings to fix permissions granted", Toast.LENGTH_LONG).show();
                }
            }
        });

        final TextView textView = findViewById(R.id.textView1);
        final String rearrangeText = "Wordplay is fun but it doesn't really prove your point.";
        final String content = "'" + rearrangeText + "' with all the letters arranged alphabetically is 'X'.";
        textView.setText(content);

        final Button copy = findViewById(R.id.copyButton);
        copy.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                https://developer.android.com/guide/topics/text/copy-paste#java
                final ClipboardManager clipboard = (ClipboardManager)
                        getSystemService(Context.CLIPBOARD_SERVICE);

                final ClipData clip = ClipData.newPlainText("textRearranged", textView.getText());

                if (clipboard != null) {
                    clipboard.setPrimaryClip(clip);
                    Toast.makeText(v.getContext(), "Copied to clipboard", Toast.LENGTH_SHORT).show();
                }
                else{
                    Toast.makeText(v.getContext(), "Unable to get clipboard", Toast.LENGTH_LONG).show();
                }
            }
        });

        final Button rearrangeButton = findViewById(R.id.rearrangeButton);
        rearrangeButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final List<String> rearrangeList = new ArrayList<>();
                final String alphabet = "abcdefghijklmnopqrstuvwxyz";
                for (int i = 0; i < rearrangeText.length(); i++) {
                    final String s = Character.toString(rearrangeText.charAt(i)).toLowerCase();

                    if (alphabet.contains(s)) {
                        rearrangeList.add(s);
                    }
                }
                Collections.sort(rearrangeList);
                final StringBuilder stringBuilder = new StringBuilder();
                for(String c : rearrangeList){
                    stringBuilder.append(c);
                }
                textRearranged = stringBuilder.toString();
                final String newContent = content.replace("'X'", "'"+textRearranged+"'");
                textView.setText(newContent);
                copy.setEnabled(true);
                rearrangeButton.setEnabled(false);
            }
        });
    }
}
