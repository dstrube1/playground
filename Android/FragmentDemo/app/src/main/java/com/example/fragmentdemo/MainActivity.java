package com.example.fragmentdemo;

import android.os.Bundle;
import android.app.Activity;
import android.app.FragmentManager;
import android.util.Log;

public class MainActivity extends Activity implements FragmentA.Communicator {

	FragmentManager manager;
	FragmentA fragmentA;
	FragmentB fragmentB;

	private static final String TAG = MainActivity.class.getName();
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
		manager = getFragmentManager();
		fragmentA = (FragmentA) manager.findFragmentById(R.id.fragment1);
		fragmentA.setCommunicator(this);
    }

	@Override
	public void changeText(String  selectItem) {
    	Log.i(TAG, "changeText");
		fragmentB = (FragmentB) manager.findFragmentById(R.id.fragment2);
		fragmentB.changeText(selectItem);
	}

}
