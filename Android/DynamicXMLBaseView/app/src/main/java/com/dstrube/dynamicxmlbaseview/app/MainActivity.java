package com.dstrube.dynamicxmlbaseview.app;

import android.app.Activity;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;


public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        // Parent layout
        LinearLayout parentLayout = findViewById(R.id.layout);

        // Layout inflater
        LayoutInflater layoutInflater = getLayoutInflater();
        View view;
        View dividerView;

        for (int i = 1; i < 101; i++){
            // Add the text layout to the parent layout
            view = layoutInflater.inflate(R.layout.newitem, parentLayout, false);

            // In order to get the view we have to use the new view with text_layout in it
            TextView textView = view.findViewById(R.id.text);
            textView.setText("Row " + i);
            textView.setPadding(10, 10, 10, 10);
            // Add the text view to the parent layout
            parentLayout.addView(textView);

            dividerView = layoutInflater.inflate(R.layout.divider, parentLayout, false);
            parentLayout.addView(dividerView);
        }
    }


}
