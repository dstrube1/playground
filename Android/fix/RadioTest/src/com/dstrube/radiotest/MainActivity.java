package com.dstrube.radiotest;

import android.support.v7.app.ActionBarActivity;
//import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Toast;
//import android.os.Build;
//import android.widget.ToggleButton;

//////////////////
/* 
 * Radio Button and Image Button test
 * uses inline button listener and xml-specified button listener
 * standard button and Image button - both go to the url of the selected radioButton
*/
//////////////////

public class MainActivity extends ActionBarActivity {

	private RadioGroup radioGroup;
	private RadioButton radioButton;
	private Button button;
	private ImageButton imageButton;
	
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
    	radioGroup = (RadioGroup)findViewById(R.id.radioGroup1);
    	button = (Button)findViewById(R.id.button1);
    	addListenerOnButton();
    }

    private void addListenerOnButton() {
    	
    	button.setOnClickListener(new OnClickListener(){
    		@Override
    		public void onClick(View v){
    			ImageClick(v);
    		}
    	});
		
	}
    public void ImageClick(View v){
    	//image button source:
    	//http://www.clker.com/cliparts/5/9/c/2/1194984395619889880earth_globe_dan_gerhrads_01.svg.med.png 
    	int selected = radioGroup.getCheckedRadioButtonId();
		radioButton = (RadioButton)findViewById(selected);
		Toast.makeText(getApplicationContext(), radioButton.getText(), Toast.LENGTH_LONG).show();
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
        
        switch (id){
        case R.id.action_settings:
        	Toast.makeText(getApplicationContext(), "Settings clicked", Toast.LENGTH_LONG).show();
        	return true;
    	default:
    		return super.onOptionsItemSelected(item);
        }
//        if (id == R.id.action_settings) {
//            return true;
//        }
//        return super.onOptionsItemSelected(item);
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
