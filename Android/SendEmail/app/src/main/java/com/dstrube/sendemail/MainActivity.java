package com.dstrube.sendemail;

import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Toast;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    private EditText emailAddressText, emailBodyText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    protected void onResume() {
        super.onResume();
        emailAddressText = findViewById(R.id.emailAddressText);
        emailBodyText = findViewById(R.id.emailBodyText);
    }

    public void Send(View v){
        String emailAddress = emailAddressText.getText().toString();
        String emailBody = emailBodyText.getText().toString();
        if (emailAddress.equals("")){
            Toast.makeText(getApplicationContext(), "Please enter an email address", Toast.LENGTH_LONG).show();
            return;
        }
        if (emailBody.equals("")){
            Toast.makeText(getApplicationContext(), "Please enter an email message", Toast.LENGTH_LONG).show();
            return;
        }

        Intent intent = new Intent(Intent.ACTION_SEND);
        intent.setType("message/rfc822");
        intent.putExtra(Intent.EXTRA_EMAIL  , new String[]{emailAddress});
        intent.putExtra(Intent.EXTRA_SUBJECT, "subject of email");
        intent.putExtra(Intent.EXTRA_TEXT   , emailBody);

        CheckBox checkBox = findViewById(R.id.checkBox1);
        if (checkBox.isChecked()){
            intent.setType("image/png");

            ArrayList<Uri> uris = new ArrayList<>();

            //TODO
            //uris.add(Uri.parse("android.resource://" + getPackageName() + "/" + R.drawable.ic_launcher));

            intent.putExtra(Intent.EXTRA_STREAM, uris);

        }

        try {
            startActivity(Intent.createChooser(intent, "Send mail..."));
        } catch (android.content.ActivityNotFoundException ex) {
            Toast.makeText(getApplicationContext(), "There are no email clients installed.", Toast.LENGTH_LONG).show();
        }
    }

    public void Attachment(View v){
        CheckBox checkBox = findViewById(R.id.checkBox1);
        if (checkBox.isChecked()){
//			Toast.makeText(getApplicationContext(), "Checked", Toast.LENGTH_SHORT).show();
        }else{
//			Toast.makeText(getApplicationContext(), "Unchecked", Toast.LENGTH_SHORT).show();
        }
    }
}
