package com.dstrube.testfragmentactivity;

import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.dstrube.testfragmentactivity.Utils.Utils;

public class MainActivity extends AppCompatActivity
implements BlankFragment.OnFragmentInteractionListener{

    private final static String TAG = MainActivity.class.getName();
    private static  int clickCount;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
        setContentView(R.layout.activity_main);
    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
        FragmentManager manager = getFragmentManager();
        FragmentTransaction transaction = manager.beginTransaction();
        transaction.replace(R.id.main_content, BlankFragment.newInstance("",""));//new BlankFragment());
        transaction.commit();
//        Log.i(TAG,"Finishing goes to onPause, onStop, then onDestroy.");
//        finish();
    }

    @Override
    protected void onPause() {
        super.onPause();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    @Override
    protected void onStop() {
        super.onStop();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    @Override
    protected void onRestart() {
        super.onRestart();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    @Override
    public void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    @Override
    protected void onDestroy() {
        //This never hits?
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
        super.onDestroy();
    }

    @Override
    public void onFragmentInteraction(Uri uri){
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    public void buttonClick(View view) {
        Toast.makeText(this, "button click " + clickCount++, Toast.LENGTH_SHORT).show();
    }

}
