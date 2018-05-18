package com.dstrube.savedinstancestatetest;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    TextView roleText;
    EditText editText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        roleText = findViewById(R.id.roleText);
        editText = findViewById(R.id.editText1);
    }

    public void Click(View v){
        final String text = editText.getText().toString();
        final String role = "Role: " + text;
        roleText.setText(role);
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        outState.putString("role", roleText.getText().toString());
        super.onSaveInstanceState(outState);
    }

    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);
        final String role = savedInstanceState.getString("role");
        //Comment out this line and the magic breaks:
        roleText.setText(role);
        Toast.makeText(getApplicationContext(), "Role restored", Toast.LENGTH_SHORT).show();

    }

}
