package com.custom.customview;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;

//////////////////
/* 
* CustomView
* custom namespace in activity_main.xml; attributes defined in values/attrs.xml, used in DateView view a TypedArray
* Display a date with custom formatting
*/
//////////////////
public class MainActivity extends Activity {

	 @Override
	    protected void onCreate(Bundle savedInstanceState) {
	        super.onCreate(savedInstanceState);
	        setContentView(R.layout.activity_main);
	    }

	    @Override
	    public boolean onCreateOptionsMenu(Menu menu) {
	        // Inflate the menu; this adds items to the 
	        // action bar if it is present.
	        getMenuInflater().inflate(R.menu.main, menu);
	        return true;
	    }
}
