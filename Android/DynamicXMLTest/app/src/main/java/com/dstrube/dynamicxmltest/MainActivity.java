package com.dstrube.dynamicxmltest;

import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private ScrollView scrollView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        scrollView = new ScrollView(this);
        final LinearLayout linearLayout = new LinearLayout(this);
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        scrollView.addView(linearLayout);
        Button button = new Button(this);
        button.setText("Add field");
        linearLayout.addView(button);

        button.setOnClickListener(new View.OnClickListener() {
            //in order to not have to declare the index int final, and still have it be of some use,
            //declare it inside the OnClickListener declaration, but outside the function body
            int i = 0;

            @Override
            public void onClick(View v) {
                i++;
                TextView textView = new TextView(getApplicationContext());
                textView.setText("Field" + i);
                linearLayout.addView(textView);
                EditText editText = new EditText(getApplicationContext());
                editText.setText(i + "");
                editText.setTextColor(Color.GREEN);
                linearLayout.addView(editText);
            }
        });
        this.setContentView(scrollView);
    }
}
