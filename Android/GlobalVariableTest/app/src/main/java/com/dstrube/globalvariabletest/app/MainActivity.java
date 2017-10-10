package com.dstrube.globalvariabletest.app;

import android.app.Activity;
import android.os.Bundle;
import android.os.Parcelable;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

/*
Note well: orientation change doesn't work for emulators of API 19; use API 18
 */
public class MainActivity extends Activity {

    private EditText nameText;
    private EditText emailText;
    private GlobalClass globalClass;

    // first load:
    // on create, on resume

    // orientation change:
    // on save, on create, on restore, on resume

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Toast.makeText(getApplicationContext(), "onCreate",
                Toast.LENGTH_SHORT).show();

        // String result = "not null";
        // if (savedInstanceState == null)
        // result = "null";
        // Toast.makeText(getApplicationContext(),
        // "onCreate; savedInstanceState is "+result,
        // Toast.LENGTH_SHORT).show();

        nameText = (EditText) findViewById(R.id.nameText);
        emailText = (EditText) findViewById(R.id.emailText);

        if (savedInstanceState != null) {
            // assuming that this means the EditTexts are also not null
            globalClass = // (GlobalClass) getApplicationContext();
                    (GlobalClass) savedInstanceState.getParcelable("globalClass");
            nameText.setText(globalClass.getName());
            emailText.setText(globalClass.getEmail());
        } else {
            globalClass = (GlobalClass) getApplicationContext();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();

        Toast.makeText(getApplicationContext(), "onResume",
                Toast.LENGTH_SHORT).show();

        nameText = (EditText) findViewById(R.id.nameText);
        emailText = (EditText) findViewById(R.id.emailText);

        if (globalClass != null) {

            globalClass = (GlobalClass) getApplicationContext();
            if (globalClass.getName() != null) {
                nameText.setText(globalClass.getName());
            }
            if (globalClass.getEmail() != null) {
                emailText.setText(globalClass.getEmail());
            }

        }
    }

    public void Click(View v) {
        globalClass = (GlobalClass) getApplicationContext();
        String name = nameText.getText().toString();
        String email = emailText.getText().toString();
        globalClass.setName(name);
        globalClass.setEmail(email);
        nameText.setText("");
        emailText.setText("");
        Toast.makeText(getApplicationContext(),
                "Global variables have been set.", Toast.LENGTH_LONG).show();
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
//        outState.putSerializable("globalClass", (Serializable) globalClass);
        outState.putParcelable("globalClass", (Parcelable) globalClass);
        super.onSaveInstanceState(outState);
        Toast.makeText(getApplicationContext(), "onSaveInstanceState",
                Toast.LENGTH_SHORT).show();
    }

    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);
        Toast.makeText(getApplicationContext(), "onRestoreInstanceState",
                Toast.LENGTH_SHORT).show();
    }

    // @Override
    // public void onConfigurationChanged(Configuration newConfig) {
    // super.onConfigurationChanged(newConfig);
    //
    // // Checks the orientation of the screen
    // if (newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE) {
    // Toast.makeText(this, "landscape", Toast.LENGTH_SHORT).show();
    // } else if (newConfig.orientation == Configuration.ORIENTATION_PORTRAIT) {
    // Toast.makeText(this, "portrait", Toast.LENGTH_SHORT).show();
    // } else {
    // Toast.makeText(this, "neither landscape nor portrait",
    // Toast.LENGTH_SHORT).show();
    // }
    // Toast.makeText(this, "Either way...",
    // Toast.LENGTH_SHORT).show();
    //
    // }

}
