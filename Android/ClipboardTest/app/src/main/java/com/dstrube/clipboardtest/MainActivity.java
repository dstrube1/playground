package com.dstrube.clipboardtest;

import android.app.Activity;
import android.app.Fragment;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;

//////////////////
/* 
* ClipboardTest
* two text entry boxes
* two buttons
* enter text in one box, click Copy button, click Paste button, text shows in box two
*/
//////////////////
public class MainActivity extends Activity {

	//private String copyS = "", pasteS = "";
	private EditText copyText, pasteText;
	private ClipboardManager man;
	private ClipData clip;
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
		copyText = findViewById(R.id.copyText);
		pasteText = findViewById(R.id.pasteText);
		man = (ClipboardManager) getSystemService(Context.CLIPBOARD_SERVICE);
	}
	
	public void copyClick(View v){
//		man.setText(copyText.getText().toString());
		clip = ClipData.newPlainText("label",copyText.getText().toString());
		man.setPrimaryClip(clip);
	}
	public void pasteClick(View v){
//		pasteText.setText(man.getText());
		clip = man.getPrimaryClip();
		pasteText.setText(clip.getItemAt(0).coerceToText(getApplicationContext()));
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
