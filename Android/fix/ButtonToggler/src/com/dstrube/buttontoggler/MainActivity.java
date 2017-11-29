package com.dstrube.buttontoggler;

import android.support.v7.app.ActionBarActivity;
//import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.annotation.SuppressLint;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;
//import android.os.Build;
import android.widget.ToggleButton;
import android.view.View.OnClickListener;

//////////////////
/* 
* Button Toggler
* just a button
* if button is ON, click it, goes to OFF with Toast that says OFF;
* vice versa
*/
//////////////////

public class MainActivity extends ActionBarActivity {

	private ToggleButton toggleButton1;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.container, new PlaceholderFragment())
                    .commit();
        }
        
    }
    @Override
    protected void onResume() {
    	super.onResume();
    	
    	addListenerOnButton();
    }


    private void addListenerOnButton() {
    	toggleButton1 = (ToggleButton)findViewById(R.id.toggleButton1);
    	toggleButton1.setOnClickListener(new OnClickListener(){
    		@SuppressLint("NewApi") @Override
			public void onClick(View view){
//    			if ("ON" == toggleButton1.getText()){
//    				Toast.makeText(getApplicationContext(), "Button is ON", Toast.LENGTH_SHORT).show();
//    			}
//    			else {
//    				Toast.makeText(getApplicationContext(), "Button is OFF", Toast.LENGTH_LONG).show();
//    			}
    			//isChecked, isPressed = always true
    			//isSelected, isActivated = always false
    			Toast.makeText(getApplicationContext(), "Button is "+toggleButton1.getText(), Toast.LENGTH_SHORT).show();
    		}
    	});
		
	}


	@Override
    public boolean onCreateOptionsMenu(Menu menu) {
        
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

        public PlaceholderFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_main, container, false);
            return rootView;
        }
    }

}
