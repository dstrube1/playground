package com.dstrube.sharedpreftest;

import android.app.Activity;
import android.app.Fragment;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;

public class MainActivity extends Activity {

	EditText et;
	SharedPreferences prefs;
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (savedInstanceState == null) {
            getFragmentManager().beginTransaction()
                    .add(R.id.container, new PlaceholderFragment())
                    .commit();
        }
    }

    @Override
    protected void onResume() {
    	super.onResume();
    	
    	et = findViewById(R.id.editText1);
    	
    	prefs = getSharedPreferences("myPref", Context.MODE_PRIVATE);
    	
    	String storedPref = prefs.getString("myPref", "");
    	
    	if (storedPref.equals("")){return;}
    	
    	et.setText(storedPref);
    }
    
    public void Clear(View v){
    	SharedPreferences.Editor editor = prefs.edit();
    	editor.putString("myPref", "");
    	editor.apply();
    	et.setText("");
    	
    }
    public void Save(View v){
    	String text = et.getText().toString();
    	if (text.equals("")){
    		return;
    	}
    	SharedPreferences.Editor editor = prefs.edit();
    	editor.putString("myPref", text);
    	editor.apply();
    	
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
        return id == R.id.action_settings || super.onOptionsItemSelected(item);
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
