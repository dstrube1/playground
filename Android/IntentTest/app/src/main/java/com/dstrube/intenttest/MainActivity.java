package com.dstrube.intenttest;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import java.util.ArrayList;

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
                Intent i = new Intent(MainActivity.this, ReportActivity.class);
                i.putExtra("james", emp);
                startActivity(i);
            }
        });
    }
}
