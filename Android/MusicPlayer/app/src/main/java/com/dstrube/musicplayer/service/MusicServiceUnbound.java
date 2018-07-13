package com.dstrube.musicplayer.service;

import java.io.IOException;

import android.app.Service;
import android.content.Intent;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnPreparedListener;
import android.os.IBinder;

public class MusicServiceUnbound extends Service {

    public static boolean isRunning = false;
    private MediaPlayer mediaPlayer;

    /**
     * This is half of what makes this service unbounded
     */
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    /**
     * Handles the calls to start the player service
     * Param Intent intent: used to get the url of the song
     * Param int flags: unused
     * Param int startId: unused
     */
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        // final String url = "http://licensing.glowingpigs.com/Audio/10.mp3";

        if (isRunning) {
//			Toast.makeText(this, "Already started", Toast.LENGTH_LONG).show();
        } else {
//			Toast.makeText(this, "Unbound music service started",
//					Toast.LENGTH_LONG).show();
            isRunning = true;
        }

        if (mediaPlayer == null) {
            mediaPlayer = new MediaPlayer();

            try {
                mediaPlayer.setDataSource(intent.getStringExtra("url"));
                mediaPlayer
                        .setOnPreparedListener(new MediaPlayerPreparedListener());
                mediaPlayer.prepare();
            } catch (IllegalArgumentException | SecurityException | IllegalStateException | IOException e) {
                e.printStackTrace();
            }
        }

        /**
         * This is half of what makes this service unbounded
         */
        return START_STICKY;
    }

    /**
     * Handles the media player being prepared
     *
     * @author david.strube
     */
    private class MediaPlayerPreparedListener implements OnPreparedListener {

        @Override
        public void onPrepared(MediaPlayer mp) {
            //Toast.makeText(getApplicationContext(), "Media player prepared.",
            //	Toast.LENGTH_LONG).show();
            if (!mp.isPlaying()) {
                mp.start();
            }
        }
    }

    /**
     * Handles the calls to stop the player service
     */
    @Override
    public void onDestroy() {
        super.onDestroy();
        isRunning = false;
//		Toast.makeText(this, "Unbound music service destroyed",
//				Toast.LENGTH_LONG).show();

        if (mediaPlayer == null || !mediaPlayer.isPlaying()) {
            // do nothing
            return;
        }

        if (mediaPlayer != null) {
            mediaPlayer.stop();
        }
    }
}
