package com.example.fragmentdemo;

import android.os.Bundle;
import android.app.Activity;
import android.app.FragmentManager;

public class MainActivity extends Activity implements FragmentA.Communicator {

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

	@Override
	public void changeText(String  selectItem) {
		fragmentB = (FragmentB) manager.findFragmentById(R.id.fragment2);
		fragmentB.changeText(selectItem);
	}

}
