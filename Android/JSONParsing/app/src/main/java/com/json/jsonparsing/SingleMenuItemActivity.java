package com.json.jsonparsing;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class SingleMenuItemActivity extends Activity {

    // JSON node keys
    private static final String TAG_NAME = "name";
    private static final String TAG_EMAIL = "email";
    private static final String TAG_PHONE_MOBILE = "mobile";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.single_list_item); //single_list_item here, list_item in MainActivity

        // getting intent data
        Intent in = getIntent();

        // Get JSON values from previous intent
        String name = in.getStringExtra(TAG_NAME);
        String cost = in.getStringExtra(TAG_EMAIL);
        String description = in.getStringExtra(TAG_PHONE_MOBILE);

        // Displaying all values on the screen
        TextView lblName = findViewById(R.id.name_label);
        TextView lblCost = findViewById(R.id.email_label);
        TextView lblDesc = findViewById(R.id.mobile_label);

        lblName.setText(name);
        lblCost.setText(cost);
        lblDesc.setText(description);
    }
}
