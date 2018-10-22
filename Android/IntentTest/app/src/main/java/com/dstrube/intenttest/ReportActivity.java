package com.dstrube.intenttest;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ReportActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        setContentView(R.layout.report);
        ListView lv= findViewById(R.id.listview);

        // create the grid item mapping
        String[] from = new String[] {"rowid", "name", "mail", "phone"};
        int[] to = new int[] { R.id.item1, R.id.item2, R.id.item3, R.id.item4 };
        ArrayList emp1 =  getIntent().getParcelableArrayListExtra("james");
        // prepare the list of all records
        List<HashMap<String, String>> fillMaps = new ArrayList<>();

        for(int i = 0; i < 10; i++){
            Employee emp =  (Employee) emp1.get(i);
            HashMap<String, String> map = new HashMap<>();
            map.put("rowid", "" + i);
            map.put("name", emp.getName());
            map.put("mail", emp.getMail());
            map.put("phone", emp.getPhone());
            fillMaps.add(map);
        }

        // fill in the grid_item layout
        SimpleAdapter adapter = new SimpleAdapter(this, fillMaps, R.layout.grid_view, from, to);
        lv.setAdapter(adapter);

        final Button goToButtonActivityButton = findViewById(R.id.goToButtonActivityButton);
        goToButtonActivityButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub
                final Intent intent = new Intent(ReportActivity.this, ButtonsActivity.class);
                startActivity(intent);
            }
        });

    }

}

