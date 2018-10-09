package com.dstrube.instagramtest;

import android.graphics.Point;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Display;
import android.webkit.WebView;
import android.widget.GridView;


public class MainActivity extends AppCompatActivity {
    InstagramLogin instagramLogin;
    //    InstagramDataSource instagramDataSource;
//    InstagramAdapter instagramAdapter;
    WebView myWebView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_main);
//        instagramDataSource = InstagramDataSource.getInstance();
//        instagramDataSource.getMoreData();
        myWebView = new WebView(this);
        setContentView(myWebView);
//        final String client_id = "e7ce3f1a709543c7a03313e7f2e02bb4";
//        final String redirect_uri = "http://colorofblah.blogspot.com/";
//        String urlString = "https://api.instagram.com/oauth/authorize/?client_id={client_id}&redirect_uri={redirect_uri}&response_type=code";
//        urlString = urlString.replace("{redirect_uri}", redirect_uri);
//        urlString = urlString.replace("{client_id}", client_id);
//
//        myWebView.loadUrl(urlString);//TODO This opens the page in a separate browser app; we want to stay in this app

//        instagramAdapter = new InstagramAdapter(this, instagramDataSource, getScreenWindow());
//        GridView gridView = findViewById(R.id.gridView);
//        gridView.setOnScrollListener(instagramAdapter);
//        gridView.setAdapter(instagramAdapter);
    }

    @Override
    protected void onResume() {
        super.onResume();
        instagramLogin = InstagramLogin.getInstance(myWebView);//This is no better- doesn't even open the page at all
    }

    //    public int getScreenWindow(){
//        Display display = getWindowManager().getDefaultDisplay();
//        Point size = new Point();
//        display.getSize(size);
//        return size.x;
//    }
}
