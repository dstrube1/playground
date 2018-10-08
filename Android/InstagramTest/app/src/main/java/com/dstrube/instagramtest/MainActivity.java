package com.dstrube.instagramtest;

import android.graphics.Point;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Display;
import android.widget.GridView;


public class MainActivity extends AppCompatActivity {
    InstagramLogin instagramLogin;
//    InstagramDataSource instagramDataSource;
//    InstagramAdapter instagramAdapter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
//        instagramDataSource = InstagramDataSource.getInstance();
//        instagramDataSource.getMoreData();
        instagramLogin = InstagramLogin.getInstance();

//        instagramAdapter = new InstagramAdapter(this, instagramDataSource, getScreenWindow());
//        GridView gridView = findViewById(R.id.gridView);
//        gridView.setOnScrollListener(instagramAdapter);
//        gridView.setAdapter(instagramAdapter);
    }

//    public int getScreenWindow(){
//        Display display = getWindowManager().getDefaultDisplay();
//        Point size = new Point();
//        display.getSize(size);
//        return size.x;
//    }
}
