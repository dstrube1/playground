package com.custom.dialog;

import com.samir.R;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
//import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

//////////////////
/* 
* Android Custom dialog
* click the Custom Dialog button- pops up the username and password fields; password may or may not be *s
* OK and Cancel I made, not default
* OK = Toast with username and password - clear text both
* Cancel makes the pop up disappear
*/
//////////////////

public class MainActivity extends Activity implements OnClickListener {
	EditText etSearch;
	Button btn; //, btnSearch, btnCancel;
	Dialog dialog;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		btn = findViewById(R.id.btn);
		btn.setOnClickListener(this);
	}

	protected void showCustomDialog() {

//		dialog = new Dialog(MainActivity.this,android.R.style.Theme_Translucent);
//		dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
//		dialog.setCancelable(true);
//		dialog.setContentView(R.layout.dialog);
//		etSearch = (EditText) dialog.findViewById(R.id.etsearch);
		//btnSearch = (Button) dialog.findViewById(R.id.btnsearch);
		//btnCancel = (Button) dialog.findViewById(R.id.btncancel);
		//btnSearch.setOnClickListener(this);
		//btnCancel.setOnClickListener(this);
//		dialog.show();
	}
	
	protected void showCustomDialog2() {
	  AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
	    // Get the layout inflater
	    LayoutInflater inflater = MainActivity.this.getLayoutInflater();
	    
	    
	    //View v = inflater.inflate(R.layout.dialog_signin, null);
	    //v.findViewById(R.id.username);
	    
	    // Inflate and set the layout for the dialog
	    // Pass null as the parent view because its going in the dialog layout
	    builder.setView(inflater.inflate(R.layout.dialog_signin, null))
	    // Add action buttons
	           .setPositiveButton("Sign In", new DialogInterface.OnClickListener() {
	               @Override
	               public void onClick(DialogInterface dialog, int id) {
	                   // sign in the user ...
	               }
	           })
	           .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
	               public void onClick(DialogInterface dialog, int id) {
	            	   dialog.cancel();
	               }
	           });      
	    dialog =  builder.create();
	    
	    dialog.show();
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.btn:
			//showCustomDialog();
			showCustomDialog2();
			break;
		case R.id.btnsearch:
			String search = etSearch.getText().toString().trim();
			if (TextUtils.isEmpty(search)) {
				Toast.makeText(MainActivity.this,"Searching for Nothing",Toast.LENGTH_LONG).show();
			} else {
				Toast.makeText(MainActivity.this,"Searching for " + search,Toast.LENGTH_LONG).show();
			}
			dialog.dismiss();
			break;
		case R.id.btncancel:
			dialog.dismiss();
			break;
		default:
			break;
		}

	}
}