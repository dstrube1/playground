package com.dstrube.numadder;

import android.app.Activity;
import android.app.Fragment;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.Button;
import android.widget.Toast;

//////////////////
/* 
* NumAdder
* two text inputs, a button and another text
* enter numbers in the first two, push the button, get the sum in the 3rd text
*/
//////////////////
public class MainActivity extends Activity {

	private EditText edText1, edText2, edText3;
	private static final String TAG = MainActivity.class.getName();

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
        
        addListenerOnButton();
    }

    public void myClick(View v){
    	Toast.makeText(getApplicationContext(), "Hooray! Using XML specified button listener.", Toast.LENGTH_LONG).show();
    }
    private void addListenerOnButton() {
		edText1 = findViewById(R.id.editText1);
		edText2 = findViewById(R.id.editText2);
		edText3 = findViewById(R.id.editText3);

        Button btnSum = findViewById(R.id.button1);
		btnSum.setOnClickListener(new OnClickListener(){
			
			@Override
			public void onClick(View view){
				try{
					String t1 = edText1.getText().toString();
					String t2 = edText2.getText().toString();
	//				String t3 = edText3.getText().toString();
					
					int i1 = Integer.parseInt(t1);
					int i2 = Integer.parseInt(t2);
	//				int i3 = Integer.parseInt(t3);
					
					int sum = i1 + i2;
					String t3 = Integer.toString(sum);
					edText3.setText(t3);
				}
				catch(Exception e){
					Log.e(TAG, e.getLocalizedMessage());
				}
			}
		}
				);
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
