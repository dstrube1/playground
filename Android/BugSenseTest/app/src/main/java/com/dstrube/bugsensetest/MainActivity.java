package com.dstrube.bugsensetest;

import java.util.HashMap;

import android.app.Activity;
//import android.app.ActionBar;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
//import android.view.Menu;
//import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
//import android.os.Build;

import com.bugsense.trace.BugSenseHandler;
import com.bugsense.trace.ExceptionCallback;

/*
 * See also:
 * https://www.bugsense.com/dashboard
 * https://www.bugsense.com/docs/android
 * https://www.bugsense.com/pricing
 */
/**
 * 
 * @author unbounded
 *
 */
public class MainActivity extends Activity implements ExceptionCallback {

	/*
	 * (non-Javadoc)
	 * @see android.app.Activity#onStart()
	 */
	@Override
	protected void onStart() {
		super.onStart();
		BugSenseHandler.startSession(MainActivity.this);
	}

	@Override
	protected void onStop() {
		super.onStop();
		BugSenseHandler.closeSession(MainActivity.this);
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		BugSenseHandler.initAndStartSession(MainActivity.this, "ef656c13");
		setContentView(R.layout.activity_main);

		if (savedInstanceState == null) {
			getFragmentManager().beginTransaction()
					.add(R.id.container, new PlaceholderFragment()).commit();
		}
	}

	@SuppressWarnings("null")
	//^This is for testing purposes. I.e., intentional
	@Override
	protected void onResume() {
		super.onResume();

		BugSenseHandler.addCrashExtraData("extra1", "ding dong");
		BugSenseHandler.addCrashExtraData("extra2", "hello");
		
		HashMap<String, String> extras = new HashMap<String, String>();
		extras.put("mapExtra1", "11");
		extras.put("mapExtra2", "2");
		BugSenseHandler.addCrashExtraMap(extras);

		BugSenseHandler.setUserIdentifier("bob");
		
		BugSenseHandler.leaveBreadcrumb("PointA");
		
		BugSenseHandler.setLogging(100);
		
		BugSenseHandler.sendEvent("event1");
		
		BugSenseHandler.setExceptionCallback(this);

		try {
			String a = null;
			a.toString();
		} catch (Exception ex) {
			ex.printStackTrace(); // in case you want to see the stacktrace in
									// your log cat output
			BugSenseHandler.sendException(ex);
			//BugSenseHandler.sendExceptionMessage("level", "second level", ex);
		}
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

	@Override
	public void lastBreath(Exception arg0) {
		BugSenseHandler.addCrashExtraData("lastBreathExtra","This is an extra from the last breath. The app has crashed.");
		
	}

}
