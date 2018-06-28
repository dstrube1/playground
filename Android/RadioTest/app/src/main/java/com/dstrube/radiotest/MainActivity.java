package com.dstrube.radiotest;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
//import android.widget.ImageButton;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    private RadioGroup radioGroup;
//    private RadioButton radioButton;
    private Button button;
//    private ImageButton imageButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    protected void onResume() {
        super.onResume();
        radioGroup = findViewById(R.id.radioGroup1);
        button = findViewById(R.id.button1);
        addListenerOnButton();
    }

    private void addListenerOnButton() {

        button.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                ImageClick(v);
            }
        });

    }
    public void ImageClick(View v){
        //image button source:
        //http://www.clker.com/cliparts/5/9/c/2/1194984395619889880earth_globe_dan_gerhrads_01.svg.med.png
        final int selected = radioGroup.getCheckedRadioButtonId();
        final RadioButton radioButton = findViewById(selected);
        Toast.makeText(getApplicationContext(), radioButton.getText(), Toast.LENGTH_LONG).show();
    }
}
