package com.example.instagram;

//import android.app.Activity;
import android.graphics.Point;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.Display;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.GridView;

public class MainActivity extends ActionBarActivity {
	InstagramDataSource instagramDataSource;
	InstagramAdapter instagramAdapter;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
        
        instagramDataSource = InstagramDataSource.getInstance();
        instagramDataSource.getMoreData();
        
        instagramAdapter = new InstagramAdapter(this, instagramDataSource, getScreenWindow());
        GridView gridView = (GridView) findViewById(R.id.gridView);
        gridView.setOnScrollListener(instagramAdapter);
        gridView.setAdapter(instagramAdapter);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}
	
	public int getScreenWindow(){
		Display display = getWindowManager().getDefaultDisplay();
		Point size = new Point();
		display.getSize(size);
		return size.x;
	}
}
