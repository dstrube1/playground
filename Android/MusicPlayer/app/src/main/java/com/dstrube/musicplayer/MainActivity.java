package com.dstrube.musicplayer;

import com.dstrube.musicplayer.service.MusicServiceBound;
import com.dstrube.musicplayer.service.MusicServiceUnbound;

import comdstrube.musicplayer.R;

import android.app.Activity;
import android.app.Fragment;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.ToggleButton;

//////////////////
/*
 * Music Player
 * Offer unbounded and bounded music player service
 * Unbounded only has start and stop, but should play even when app is closed
 * Bounded has start, stop and pause, should end when app is closed
 */
//////////////////
public class MainActivity extends Activity {

    //todo: find a non-broken mp3 url
    public final String url = "http://licensing.glowingpigs.com/Audio/10.mp3";
    private ImageButton pauseB;// , playB, stopB;
    private ToggleButton toggleB;
    private MusicServiceBound musicServiceBound;
//	private boolean isBoundServiceBound;

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
        pauseB = findViewById(R.id.pauseButton);
        // playB = findViewById(R.id.playButton);
        // stopB = findViewById(R.id.stopButton);
        toggleB = findViewById(R.id.toggleButton1);
//		isBoundServiceBound = false;
    }

    /**
     * Handler for the play button click
     *
     * @param v: unused
     */
    public void playClick(View v) {
        // Toast.makeText(getApplicationContext(), "Playing",
        // Toast.LENGTH_SHORT).show();
        if (pauseB.getVisibility() == View.GONE) {
            Intent intent = new Intent(getBaseContext(),
                    MusicServiceUnbound.class);
            intent.putExtra("url", url);
            startService(intent);
        } else {
            // if we get multiple services playing the same thing, might need to
            // do this:
            // stopService(new Intent(getBaseContext(),
            // MusicServiceUnbound.class));

            Intent intent = new Intent(this, MusicServiceBound.class);
            intent.putExtra("url", url);
            bindService(intent, mConnection, Context.BIND_AUTO_CREATE);
            startService(intent);
        }
    }

    /**
     * Handler for the stop button click
     *
     * @param v: unused
     */
    public void stopClick(View v) {
        // Toast.makeText(getApplicationContext(), "Stopping",
        // Toast.LENGTH_SHORT).show();
        if (pauseB.getVisibility() == View.GONE) {
            stopService(new Intent(getBaseContext(), MusicServiceUnbound.class));
        } else {
            musicServiceBound.stop();
            // if (isBoundServiceBound) {
            unbindService(mConnection);
            // isBoundServiceBound = false;
            // }
        }
    }

    /**
     * Handler for the toggle button click
     *
     * @param v: unused
     */
    public void toggleClick(View v) {
        if (toggleB.isChecked()) {
            pauseB.setVisibility(View.VISIBLE);
        } else {
            pauseB.setVisibility(View.GONE);
        }
    }

    /**
     * Handler for the pause button click
     *
     * @param v: unused
     */
    public void pauseClick(View v) {
        // Toast.makeText(getApplicationContext(), "Pausing",
        // Toast.LENGTH_SHORT)
        // .show();
        musicServiceBound.pause();
    }

    /**
     * ServiceConnection for the bound music service
     */
    private ServiceConnection mConnection = new ServiceConnection() {
        public void onServiceConnected(ComponentName className, IBinder binder) {

            musicServiceBound = ((MusicServiceBound.LocalBinder) binder)
                    .getService();
            // Toast.makeText(MainActivity.this, "Connected",
            // Toast.LENGTH_SHORT)
            // .show();
        }

        public void onServiceDisconnected(ComponentName className) {
            musicServiceBound = null;
        }
    };

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
