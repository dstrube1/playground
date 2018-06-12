package com.dstrube.tablayouttest;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TabHost;
import android.widget.TabHost.TabSpec;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        TabHost tabHost = new TabHost(
                //getBaseContext()
                //this
                getApplicationContext()
        );

        // Tab for Photos
        TabSpec photospec = tabHost.newTabSpec("Photos");
        photospec.setIndicator("Photos", getDrawable(R.drawable.icon_photos_tab));
        Intent photosIntent = new Intent(this, PhotosActivity.class);
        photospec.setContent(photosIntent);

        // Tab for Songs
        TabSpec songspec = tabHost.newTabSpec("Songs");
        // setting Title and Icon for the Tab
        songspec.setIndicator("Songs", getDrawable(R.drawable.icon_songs_tab));
        Intent songsIntent = new Intent(this, SongsActivity.class);
        songspec.setContent(songsIntent);

        // Tab for Videos
        TabHost.TabSpec videospec = tabHost.newTabSpec("Videos");
        videospec.setIndicator("Videos", getDrawable(R.drawable.icon_videos_tab));
        Intent videosIntent = new Intent(this, VideosActivity.class);
        videospec.setContent(videosIntent);

        //TODO keeps breaking here:
        // Adding all TabSpec to TabHost
        tabHost.addTab(photospec); // Adding photos tab
        tabHost.addTab(songspec); // Adding songs tab
        tabHost.addTab(videospec); // Adding videos tab

    }
}
