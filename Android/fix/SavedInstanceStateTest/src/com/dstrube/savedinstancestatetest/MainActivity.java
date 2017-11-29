package com.dstrube.savedinstancestatetest;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {

	//WEIRD - question for stackoverflow: why does this still work 
	//even though there is an layout-land folder with a significantly different activity_main.xml?
	
	//Here's a clue: the "fool!"s (in the activity_main_land xml) aren't showing
	TextView roleText;
	EditText editText;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        roleText = (TextView) findViewById(R.id.roleText);
        editText = (EditText) findViewById(R.id.editText1);
        
    }
    
    public void Click(View v){
    	String role = roleText.getText().toString();
    	String text = editText.getText().toString();
    	role = "Role: "+text;
    	roleText.setText(role);
    }
    
    @Override
    protected void onSaveInstanceState(Bundle outState) {
    	outState.putString("role", roleText.getText().toString());
    	super.onSaveInstanceState(outState);
    }
    
    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
    	super.onRestoreInstanceState(savedInstanceState);
    	String role = savedInstanceState.getString("role");
    	//Comment out this line and the magic breaks:
    	roleText.setText(role);
    	Toast.makeText(getApplicationContext(), "Role restored", Toast.LENGTH_SHORT).show();
    	
    }
}
