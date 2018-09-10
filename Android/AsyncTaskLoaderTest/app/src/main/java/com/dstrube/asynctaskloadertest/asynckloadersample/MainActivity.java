package com.dstrube.asynctaskloadertest.asynckloadersample;

import android.app.Activity;
import android.os.Bundle;

import com.dstrube.asynctaskloadertest.R;
//import android.support.v4.app.FragmentActivity;
//import android.support.v4.app.FragmentManager;

public class MainActivity  extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // to give support on lower android version, we are not calling getFragmentManager()
//        FragmentManager fm = getSupportFragmentManager();
//
//        // Create the list fragment and add it as our sole content.
//        if (fm.findFragmentById(android.R.id.content) == null) {
//            DataListFragment list = new DataListFragment();
//
//
//            fm.beginTransaction().add(android.R.id.content, list).commit();
        }
    }
