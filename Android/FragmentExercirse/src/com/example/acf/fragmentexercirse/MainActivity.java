package com.example.acf.fragmentexercirse;

import android.app.Activity;
import android.app.FragmentManager;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

public class MainActivity extends Activity implements FragmentA.Communicator { //extends ActionBarActivity 
	
	FragmentManager manager;
	FragmentA fragmentA;
	FragmentB fragmentB;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		manager = getFragmentManager();
		fragmentA = (FragmentA) manager.findFragmentById(R.id.fragment1);
		fragmentA.setCommunicator(this);

	
	}

	public void onResume()
	{
		super.onResume();
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
	

	@Override
	public void changeText(String  selectItem) {
		fragmentB = (FragmentB) manager.findFragmentById(R.id.fragment2);
		if(fragmentB == null)
		{
			Intent intent = new Intent(MainActivity.this, WebActivity.class);
			intent.putExtra("URL", selectItem);
			startActivity(intent);
		}
		else
		{
			fragmentB.changeText(selectItem);
		}
			
		
	}

	
}
