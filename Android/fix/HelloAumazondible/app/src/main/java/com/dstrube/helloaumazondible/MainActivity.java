package com.dstrube.helloaumazondible;

import android.app.Activity;
import android.graphics.Point;
import android.os.Bundle;
import android.view.Display;
import android.widget.GridView;

public class MainActivity extends Activity {

    private MyAdapter adapter;
    private MyDataSource dataSource;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //singleton initialization of my data source
        //we don't want more than one of these running around
        dataSource = MyDataSource.getInstance();
        //get the data
        dataSource.getMoreData();

        //the adapter used for the gridview
        adapter = new MyAdapter(this, dataSource, getWindowXSize());
        //the gridview
        GridView gridView = findViewById(R.id.gridView);
        gridView.setOnScrollListener(adapter);
        gridView.setAdapter(adapter);
    }

    /**
     * Called by the adapter initializer, this returns the x size of the screen
     * @return x size of the window
     */
    public int getWindowXSize(){
        Display display = getWindowManager().getDefaultDisplay();
        Point size = new Point();
        display.getSize(size);
        return size.x;
    }
}
