package com.example.fragmentdemo.fragmentexercirse;

import android.app.Activity;
import android.app.FragmentManager;
import android.content.Intent;
import android.os.Bundle;

import com.example.fragmentdemo.R;

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

    public void onResume() {
        super.onResume();
    }

    @Override
    public void changeText(String selectItem) {
        fragmentB = (FragmentB) manager.findFragmentById(R.id.fragment2);
        if (fragmentB == null) {
            Intent intent = new Intent(MainActivity.this, WebActivity.class);
            intent.putExtra("URL", selectItem);
            startActivity(intent);
        } else {
            fragmentB.changeText(selectItem);
        }
    }
}
