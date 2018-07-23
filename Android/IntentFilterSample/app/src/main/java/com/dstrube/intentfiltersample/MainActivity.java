package com.dstrube.intentfiltersample;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.widget.TextView;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

//////////////////
/*
 * IntentFilterSample
 * Sets this as an option for default URL viewer
 * This is one of the sample codes provided by Nirmal.
 */
//////////////////
public class MainActivity extends Activity {

    private static final String TAG = MainActivity.class.getName();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Uri web = Uri.parse("http://www.google.com");
        Intent i = new Intent(Intent.ACTION_VIEW, web);
        startActivity(Intent.createChooser(i, "Choose Program"));

        // To keep this example simple, we allow network access
        // in the user interface thread
        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder()
                .permitAll().build();
        StrictMode.setThreadPolicy(policy);

        setContentView(R.layout.activity_main);


    }

    @Override
    protected void onResume() {
        super.onResume();

        Intent intent = getIntent();
        TextView text = findViewById(R.id.textView);
        // To get the action of the intent use
        String action = intent.getAction();
        try {
            if (action != null && !action.equals(Intent.ACTION_VIEW) && !action.equals(Intent.ACTION_MAIN)) {
                throw new RuntimeException("Should not happen - intent action not equals(Intent.ACTION_VIEW); instead it is: " + action);
            }
            // To get the data use
            Uri data = intent.getData();
            if (data == null) {
                final String error = "Null data";
                text.setText(error);
                Log.e(TAG, error);
                return;
            }
            URL url;
            url = new URL(data.getScheme(), data.getHost(), data.getPath());
            BufferedReader rd = new BufferedReader(new InputStreamReader(url.openStream()));
            String line;
            while ((line = rd.readLine()) != null) {
                text.append(line);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
