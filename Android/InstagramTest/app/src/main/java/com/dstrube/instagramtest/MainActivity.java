package com.dstrube.instagramtest;

import android.graphics.Point;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Display;
import android.widget.GridView;

/*
* TODO: FIX THIS:
* Error:Execution failed for task ':app:transformDexArchiveWithExternalLibsDexMergerForDebug'.
> com.android.builder.dexing.DexArchiveMergerException: Unable to merge dex
* */

public class MainActivity extends AppCompatActivity {
    InstagramDataSource instagramDataSource;
    InstagramAdapter instagramAdapter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        instagramDataSource = InstagramDataSource.getInstance();
        instagramDataSource.getMoreData();

        instagramAdapter = new InstagramAdapter(this, instagramDataSource, getScreenWindow());
        GridView gridView = findViewById(R.id.gridView);
        gridView.setOnScrollListener(instagramAdapter);
        gridView.setAdapter(instagramAdapter);
    }

    public int getScreenWindow(){
        Display display = getWindowManager().getDefaultDisplay();
        Point size = new Point();
        display.getSize(size);
        return size.x;
    }
}
