package com.dstrube.intenttest;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import java.util.ArrayList;

public class MainActivity extends Activity {

    ArrayList<Employee> employees;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        final Button startBtn = findViewById(R.id.button1);
        employees = new ArrayList<>();
        Employee employee = new Employee("Peter Parker", "PP@gmail.com", "5551234567");
        employees.add(employee);

        employee = new Employee("Sam Spade", "SS@gmail.com", "555-123-7890");
        employees.add(employee);
        employee = new Employee("Clark Kent", "CK@gmail.com", "555-124-1230");
        employees.add(employee);
        employee = new Employee("Nancy Drew", "ND@gmail.com", "555-124-7891");
        employees.add(employee);
        employee = new Employee("Fenton Hardy", "FH@gmail.com", "555-124-1235");
        employees.add(employee);
        employee = new Employee("Diane Prince", "DP@gmail.com", "555-124-5896");
        employees.add(employee);
        employee = new Employee("Burce Wayne", "BW@gmail.com", "555-124-1287");
        employees.add(employee);
        employee = new Employee("Dick Tracy", "DT@gmail.com", "555-124-8521");
        employees.add(employee);
        employee = new Employee("Sherlock Holmes", "SH@gmail.com", "555-129-1111");
        employees.add(employee);
        employee = new Employee("Hal Jordan", "HJ@gmail.com", "555-129-2222");
        employees.add(employee);
        startBtn.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub
                Intent i = new Intent(MainActivity.this, ReportActivity.class);
                i.putExtra("james", employees);
                startActivity(i);
            }
        });
    }
}
