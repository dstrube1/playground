package com.dstrube.payrange.view;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import com.dstrube.payrange.controller.MainActivity;
import com.dstrube.payrange.R;
import com.dstrube.payrange.util.Randomizer;

public class SplashActivity extends AppCompatActivity {

    // Splash screen timer
    public static final int SPLASH_TIME_OUT = 2000;

    private static final String TAG = SplashActivity.class.getSimpleName();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        ProgressDialog progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Welcome to Machines Magic!");
        progressDialog.setIndeterminate(true);
        progressDialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        progressDialog.show();

        Log.i(TAG, "Randomizing...");
        Randomizer.randomize(getParent());

        new Handler().postDelayed(new Runnable() {

            @Override
            public void run() {
                // This method will be executed once the timer is over
                // Start the main activity
                Log.i(TAG, "Splash timed out");
                Intent i = new Intent(SplashActivity.this, MainActivity.class);
                startActivity(i);

                // close this activity
                finish();
            }
        }, SPLASH_TIME_OUT);
    }
}
