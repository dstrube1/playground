package com.frame.framlayoutsample;

import android.os.Bundle;
import android.app.Activity;
//import android.view.Menu;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

public class MainActivity extends Activity {
	   /** Called when the activity is first created. */
	
	@Override
	    public void onCreate(Bundle savedInstanceState) {
	        super.onCreate(savedInstanceState);
	        setContentView(R.layout.activity_main);
	       TextView tv=(TextView)findViewById(R.id.txtView);
	       ImageView iv=(ImageView)findViewById(R.id.imgView);
	        tv.setOnClickListener(new View.OnClickListener() {
	        	
				
				public void onClick(View v) {
					// TODO Auto-generated method stub
				
					ImageView iv=(ImageView)findViewById(R.id.imgView);
					iv.setVisibility(View.VISIBLE);
					v.setVisibility(View.GONE);
						
				}
			});
	        
	        iv.setOnClickListener(new View.OnClickListener() {
				
				public void onClick(View v) {
					// TODO Auto-generated method stub
					TextView tv=(TextView)findViewById(R.id.txtView);
					tv.setVisibility(View.VISIBLE);
					v.setVisibility(View.GONE);
				}
			});
	    }
}
