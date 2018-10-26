package com.dstrube.intenttest;

import android.app.Activity;
import android.os.Bundle;
import android.os.Parcelable;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;

public class ReportParcelableActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_report_parcelable);
    }

    @Override
    protected void onResume() {
        super.onResume();
        final ListView listView = findViewById(R.id.listview);

        final Bundle extras = getIntent().getExtras();
        ArrayList<Employee_P> arraylist;
        if (extras != null) {
            arraylist = extras.getParcelableArrayList("james_P");//employees");
        } else {
            Toast.makeText(this, "Null extras", Toast.LENGTH_LONG).show();
            return;
        }
        if (arraylist != null) {

            MyAdapter adapter = new MyAdapter(this, arraylist);

            listView.setAdapter(adapter);

        }
        // employeeList = intent.getParcelableArrayListExtra("employees");

    }
}
