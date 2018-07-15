package com.dstrube.jsontest_postdb_prenotification.view;

import com.dstrube.jsontest_postdb_prenotification.R;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

//This class represents the activity that is displayed when clicking on a single item from the list
public class SingleMenuItemActivity extends Activity {

	// JSON node keys
	private final String TAG_FIRSTNAME = "firstName";
	private final String TAG_LASTNAME = "lastName";
	private final String TAG_EMAIL = "email";
	private final String TAG_TITLE = "title";
	
	/**
	 * Default beginner
	 * Set things up
	 * Make it all do its thing
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
        setContentView(R.layout.single_list_item); //single_list_item here, list_item in MainActivity
        
        // getting intent data
        Intent intent = getIntent();
        
        // Get JSON values from previous intent
        String firstName = intent.getStringExtra(TAG_FIRSTNAME);
        String lastName = intent.getStringExtra(TAG_LASTNAME);
        String name = firstName + " " + lastName;
        String email = intent.getStringExtra(TAG_EMAIL);
        String title = intent.getStringExtra(TAG_TITLE);
        
        // Displaying all values on the screen
        TextView lblName = findViewById(R.id.name_label);
        TextView lblEmail = findViewById(R.id.email_label);
        TextView lblTitle = findViewById(R.id.title_label);
        
        lblName.setText(name);
        lblEmail.setText(email);
        lblTitle.setText(title);

	}

}
