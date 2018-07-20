package com.dstrube.intentservicetest;

import android.app.Activity;
//import android.app.ActionBar;
import android.app.Fragment;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
//import android.os.Handler;
//import android.os.Message;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.TextView;
//import android.widget.Toast;
//import android.os.Build;

public class MainActivity extends Activity {

    // private MyBroadcastReceiver receiver;
    private TextView textView;

    private BroadcastReceiver receiver = new BroadcastReceiver() {

        @Override
        public void onReceive(Context context, Intent intent) {

            int result = intent.getIntExtra("result", 0);
//			if (textView == null) {
//				textView = (TextView) findViewById(R.id.textView1);
//			}

            textView.setText(Integer.toString(result));

        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (savedInstanceState == null) {
            getFragmentManager().beginTransaction()
                    .add(R.id.container, new PlaceholderFragment()).commit();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        // IntentFilter filter = new
        // IntentFilter(MyIntentService.MESSAGE_PROCESSED);
        // filter.addCategory(Intent.CATEGORY_DEFAULT);
        // receiver = new MyBroadcastReceiver();

        textView = (TextView) findViewById(R.id.textView1);

        registerReceiver(receiver, new IntentFilter(
                MyIntentService.MESSAGE_PROCESSED));
    }

    public void Click(View v) {
        EditText t1 = findViewById(R.id.editText1);
        EditText t2 = findViewById(R.id.editText2);
        String text1 = t1.getText().toString();
        String text2 = t2.getText().toString();
        Intent intent = new Intent(this, MyIntentService.class);
        intent.putExtra("text1", text1);
        intent.putExtra("text2", text2);
        startService(intent);
    }

    // private Handler handler = new Handler(){
    // public void handleMessage(Message message){
    // Toast.makeText(getApplicationContext(), message.toString(),
    // Toast.LENGTH_LONG).show();
    // };
    // };

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
            View rootView = inflater.inflate(R.layout.fragment_main, container,
                    false);
            return rootView;
        }
    }

}
