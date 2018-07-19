package com.clopton.itent;

import java.util.ArrayList;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;

public class MainActivity extends Activity {

    ArrayList<Employee> emp;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        Button startBtn = findViewById(R.id.button1);
        emp = new ArrayList<>();
        Employee fred = new Employee("Peter Parker", "PP@gmail.com", "5551234567");
        emp.add(fred);

        fred = new Employee("Sam Spade", "SS@gmail.com", "555-123-7890");
        emp.add(fred);
        fred = new Employee("Clark Kent", "CK@gmail.com", "555-124-1230");
        emp.add(fred);
        fred = new Employee("Nancy Drew", "ND@gmail.com", "555-124-7891");
        emp.add(fred);
        fred = new Employee("Fenton Hardy", "FH@gmail.com", "555-124-1235");
        emp.add(fred);
        fred = new Employee("Diane Prince", "DP@gmail.com", "555-124-5896");
        emp.add(fred);
        fred = new Employee("Burce Wayne", "BW@gmail.com", "555-124-1287");
        emp.add(fred);
        fred = new Employee("Dick Tracy", "DT@gmail.com", "555-124-8521");
        emp.add(fred);
        fred = new Employee("Sherlock Holmes", "SH@gmail.com", "555-129-1111");
        emp.add(fred);
        fred = new Employee("Hal Jorden", "HJ@gmail.com", "555-129-2222");
        emp.add(fred);
        startBtn.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub
                Intent i = new Intent(MainActivity.this, Report.class);
                i.putExtra("james", emp);
                startActivity(i);
            }
        });
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);


        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;


        }
        return super.onOptionsItemSelected(item);
    }


}
