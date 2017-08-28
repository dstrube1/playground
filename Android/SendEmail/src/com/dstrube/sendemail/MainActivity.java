package com.dstrube.sendemail;

import java.util.ArrayList;

import android.support.v7.app.ActionBarActivity;
//import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Toast;
//import android.os.Build;

public class MainActivity extends ActionBarActivity {

	private EditText emailAddressText, emailBodyText;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		if (savedInstanceState == null) {
			getSupportFragmentManager().beginTransaction()
					.add(R.id.container, new PlaceholderFragment()).commit();
		}
	}

	@Override
    protected void onResume() {
    	super.onResume();
    	emailAddressText = (EditText) findViewById(R.id.emailAddressText);
    	emailBodyText = (EditText) findViewById(R.id.emailBodyText);
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

		CheckBox checkBox = (CheckBox)findViewById(R.id.checkBox1);
		if (checkBox.isChecked()){
			intent.setType("image/png");

		    ArrayList<Uri> uris = new ArrayList<Uri>();

		    uris.add(Uri.parse("android.resource://" + getPackageName() + "/" + R.drawable.ic_launcher));

		    intent.putExtra(Intent.EXTRA_STREAM, uris);

		}
		
		try {
		    startActivity(Intent.createChooser(intent, "Send mail..."));
		} catch (android.content.ActivityNotFoundException ex) {
		    Toast.makeText(getApplicationContext(), "There are no email clients installed.", Toast.LENGTH_LONG).show();
		}
	}

	public void Attachment(View v){
		CheckBox checkBox = (CheckBox)findViewById(R.id.checkBox1);
		if (checkBox.isChecked()){
//			Toast.makeText(getApplicationContext(), "Checked", Toast.LENGTH_SHORT).show();
		}else{
//			Toast.makeText(getApplicationContext(), "Unchecked", Toast.LENGTH_SHORT).show();
		}
	}
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {

		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

	/**
	 * A placeholder fragment containing a simple view.
	 */
	public static class PlaceholderFragment extends Fragment {

		public PlaceholderFragment() {
		}

		@Override
		public View onCreateView(LayoutInflater inflater, ViewGroup container,
				Bundle savedInstanceState) {
			View rootView = inflater.inflate(R.layout.fragment_main, container,
					false);
			return rootView;
		}
	}

}
