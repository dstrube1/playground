package com.dstrube.testautocomplete;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Toast;

//////////////////
/*
 * TestAutoComplete
 * The String[] array is the source of autocomplete options
 */
//////////////////
public class MainActivity extends AppCompatActivity {

    String[] array = {"New York", "New Hampshire", "New Jersey", "New Mexico", "New Georgia"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    protected void onResume() {
        try {
            super.onResume();
            AutoCompleteTextView autoCompleteTextView = findViewById(R.id.autoCompleteTextView1);
            ArrayAdapter adapter = new ArrayAdapter<>(this, android.R.layout.select_dialog_item, array);
            autoCompleteTextView.setThreshold(1);
            autoCompleteTextView.setAdapter(adapter);
        } catch (Exception e) {
            Toast.makeText(getApplicationContext(), "Error: " + e.toString(), Toast.LENGTH_LONG).show();
        }
    }
}
