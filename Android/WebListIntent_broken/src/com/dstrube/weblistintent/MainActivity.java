package com.dstrube.weblistintent;

//import java.util.HashMap;
//import java.util.Map;

import android.app.Activity;
//import android.app.ActionBar;
import android.app.Fragment;
import android.app.FragmentManager;
//import android.content.Context;
import android.content.Intent;
//import android.content.pm.ActivityInfo;
//import android.content.res.Configuration;
//import android.content.res.Resources;
import android.os.Bundle;
//import android.util.DisplayMetrics;
//import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
//import android.view.Surface;
import android.view.View;
import android.view.ViewGroup;
//import android.widget.AdapterView;
//import android.widget.ArrayAdapter;
//import android.os.Build;
//import android.widget.ListView;
//import android.widget.Toast;
//import android.widget.AdapterView.OnItemClickListener;

//////////////////
/* 
 * WebListIntent
 * landscape: list view on left, webview on right
 * portrait: listview on Screen 1, webview on screen 2
 * 
 * Revised and copied from Abraham's FragmentExercise, but broken- in ItemListAdapter, expected to get click event never hears it 
 */
//////////////////

public class MainActivity extends Activity implements FragmentA.Communicator {

	FragmentManager manager;
	FragmentA fragmentA;
	FragmentB fragmentB;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.activity_main);

		if (savedInstanceState == null) {
			getFragmentManager().beginTransaction()
					.add(R.id.container, new PlaceholderFragment()).commit();
		}
		
	}

	@Override
	protected void onResume() {
		super.onResume();
		
		manager = getFragmentManager();
		fragmentA = (FragmentA) manager.findFragmentById(R.id.fragment1);
		fragmentA.setCommunicator(this);
		}
	
//	@Override
//	public void onConfigurationChanged(Configuration newConfig) {
//		super.onConfigurationChanged(newConfig);
//		
//		// Checks the orientation of the screen
//	    if (newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE) {
//	        Toast.makeText(this, "landscape", Toast.LENGTH_SHORT).show();
//	    } else if (newConfig.orientation == Configuration.ORIENTATION_PORTRAIT){
//	        Toast.makeText(this, "portrait", Toast.LENGTH_SHORT).show();
//	    }
//	    else{
//	    	Toast.makeText(this, "neither landscape nor portrait", Toast.LENGTH_SHORT).show();
//	    }
//	}
//
//	public void Click(View v) {
//		Intent intent = new Intent(this, Screen2.class);
//		intent.putExtra("url", "http://www.google.com");
//		startActivity(intent);
//	}

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

	/*
//	@SuppressWarnings("unused")
//	private int getScreenOrientation() {
//	    int rotation = getWindowManager().getDefaultDisplay().getRotation();
//	    DisplayMetrics dm = new DisplayMetrics();
//	    getWindowManager().getDefaultDisplay().getMetrics(dm);
//	    int width = dm.widthPixels;
//	    int height = dm.heightPixels;
//	    int orientation;
//	    // if the device's natural orientation is portrait:
//	    if ((rotation == Surface.ROTATION_0
//	            || rotation == Surface.ROTATION_180) && height > width ||
//	        (rotation == Surface.ROTATION_90
//	            || rotation == Surface.ROTATION_270) && width > height) {
//	        switch(rotation) {
//	            case Surface.ROTATION_0:
//	                orientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT;
//	                break;
//	            case Surface.ROTATION_90:
//	                orientation = ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE;
//	                break;
//	            case Surface.ROTATION_180:
//	                orientation =
//	                    ActivityInfo.SCREEN_ORIENTATION_REVERSE_PORTRAIT;
//	                break;
//	            case Surface.ROTATION_270:
//	                orientation =
//	                    ActivityInfo.SCREEN_ORIENTATION_REVERSE_LANDSCAPE;
//	                break;
//	            default:
//	            	Toast.makeText(getApplicationContext(), "Unknown screen orientation. Defaulting to " +
//	                        "portrait.", Toast.LENGTH_LONG).show();
//	                
//	                orientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT;
//	                break;              
//	        }
//	    }
//	    // if the device's natural orientation is landscape or if the device
//	    // is square:
//	    else {
//	        switch(rotation) {
//	            case Surface.ROTATION_0:
//	                orientation = ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE;
//	                break;
//	            case Surface.ROTATION_90:
//	                orientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT;
//	                break;
//	            case Surface.ROTATION_180:
//	                orientation =
//	                    ActivityInfo.SCREEN_ORIENTATION_REVERSE_LANDSCAPE;
//	                break;
//	            case Surface.ROTATION_270:
//	                orientation =
//	                    ActivityInfo.SCREEN_ORIENTATION_REVERSE_PORTRAIT;
//	                break;
//	            default:
//	            	Toast.makeText(getApplicationContext(), "Unknown screen orientation. Defaulting to " +
//	                        "landscape.", Toast.LENGTH_LONG).show();
//	                orientation = ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE;
//	                break;              
//	        }
//	    }
//
//	    return orientation;
//	}
	*/
	/**
	 * A placeholder fragment containing a simple view.
	 */
	public static class PlaceholderFragment extends Fragment {

		public PlaceholderFragment() {
		}

		@Override
		public View onCreateView(LayoutInflater inflater, ViewGroup container,
				Bundle savedInstanceState) {
			View rootView = inflater.inflate(R.layout.fragment_a, container,
					false);
			return rootView;
		}
	}

	@Override
	public void setContent(String itemSelected) {
		fragmentB = (FragmentB) manager.findFragmentById(R.id.fragment2);
		if(fragmentB == null)
		{
			Intent intent = new Intent(MainActivity.this, Screen2.class);
			intent.putExtra("URL", itemSelected);
			startActivity(intent);
		}
		else
		{
			fragmentB.setContent(itemSelected);
		}	
		
	}

}
