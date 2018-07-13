package com.dstrube.musicplayer.service;

import java.io.IOException;

import android.app.Service;
import android.content.Intent;
import android.media.MediaPlayer;
//import android.media.MediaPlayer.OnErrorListener;
import android.media.MediaPlayer.OnPreparedListener;
import android.os.Binder;
import android.os.IBinder;

public class MusicServiceBound extends Service {

    private final IBinder binder = new LocalBinder();

    /**
     * Binds the bounded service to its callers
     */
    public class LocalBinder extends Binder {
        public MusicServiceBound getService() {
            return MusicServiceBound.this;
        }
    }

    /**
     * Binds the bounded service to its callers
     * param Intent intent: unused; required for override
     */
    @Override
    public IBinder onBind(Intent intent) {
        return binder;
    }

    private MediaPlayer mediaPlayer;
    //	private boolean startingFromStopped = false;
    private boolean startingFromPaused = false;

    /**
     * This function handles calls to start the bounded service
     * Param Intent intent: used to get the url of the song
     * Param int flags: unused
     * Param int startId: unused
     */
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {

        try {
            if (mediaPlayer != null && !mediaPlayer.isPlaying() && startingFromPaused) {
                //Pause->Play
                mediaPlayer.start();
            } else if (mediaPlayer != null && mediaPlayer.isPlaying()) {
                //Play -> Play
                //do nothing
            } else {
                //Stop->Play OR [Nothing] -> Play
                mediaPlayer = new MediaPlayer();

                mediaPlayer.setDataSource(intent.getStringExtra("url"));
                mediaPlayer
                        .setOnPreparedListener(new MediaPlayerPreparedListener());
                // mediaPlayer.setOnErrorListener(new OnErrorListener() {
                //
                // @Override
                // public boolean onError(MediaPlayer mp, int what, int extra) {
                // return false;
                // }
                // });
                mediaPlayer.prepare();
            }
        } catch (IllegalArgumentException | SecurityException | IllegalStateException | IOException e) {
            e.printStackTrace();
        }
        return Service.START_NOT_STICKY;
    }

    /**
     * This is what happens when the MediaPlayer is ready to play
     */
    private class MediaPlayerPreparedListener implements OnPreparedListener {

        @Override
        public void onPrepared(MediaPlayer mp) {
            // Toast.makeText(getApplicationContext(), "Media player prepared.",
            // Toast.LENGTH_LONG).show();
            if (!mp.isPlaying()) {
                mp.start();
            }
        }
    }

    /**
     * Handles the calls to pause the player service
     */
    public void pause() {
        if (mediaPlayer == null || !mediaPlayer.isPlaying()) {
            return;
        }
        mediaPlayer.pause();
//		startingFromStopped = false;
        startingFromPaused = true;
    }

    /**
     * Handles the calls to stop the player service
     */
    public void stop() {
        if (mediaPlayer == null) {
            return;
        }
        mediaPlayer.stop();// this doesn't behave like normal stop- it's like
        // pause, but to start again requires prepare, not
        // start
        mediaPlayer.reset();
//		startingFromStopped = true;
        startingFromPaused = false;
    }

}
