package com.dstrube.buttontoggler;

import android.annotation.SuppressLint;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;
import android.widget.ToggleButton;

public class MainActivity extends AppCompatActivity {

    private ToggleButton toggleButton1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    protected void onResume() {
        super.onResume();

        addListenerOnButton();
    }

    private void addListenerOnButton() {
        toggleButton1 = findViewById(R.id.toggleButton1);
        toggleButton1.setOnClickListener(new View.OnClickListener(){
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

}
