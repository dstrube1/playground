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
	       TextView tv=findViewById(R.id.txtView);
	       ImageView iv=findViewById(R.id.imgView);
	        tv.setOnClickListener(new View.OnClickListener() {
	        	
				
				public void onClick(View v) {
					// TODO Auto-generated method stub
				
					ImageView iv=findViewById(R.id.imgView);
					iv.setVisibility(View.VISIBLE);
					v.setVisibility(View.GONE);
						
				}
			});
	        
	        iv.setOnClickListener(new View.OnClickListener() {
				
				public void onClick(View v) {
					// TODO Auto-generated method stub
					TextView tv=findViewById(R.id.txtView);
					tv.setVisibility(View.VISIBLE);
					v.setVisibility(View.GONE);
				}
			});
	    }
}
