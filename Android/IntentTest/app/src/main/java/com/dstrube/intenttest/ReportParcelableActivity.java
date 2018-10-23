package com.dstrube.intenttest;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Parcelable;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;

public class ReportParcelableActivity extends Activity {


    private Intent intent;
    private ArrayList<Parcelable> employeeList_P;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_report_parcelable);
        intent = getIntent();
    }

    @Override
    protected void onResume() {
        super.onResume();
        final ListView listView = findViewById(R.id.listview);

        final Bundle extras = getIntent().getExtras();
        ArrayList<Employee_P> arraylist;
        if (extras != null) {
            arraylist = extras.getParcelableArrayList("employees");
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
