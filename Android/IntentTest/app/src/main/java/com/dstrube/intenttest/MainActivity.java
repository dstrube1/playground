package com.dstrube.intenttest;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import java.util.ArrayList;

public class MainActivity extends Activity {

    ArrayList<Employee> employees;
    ArrayList<Employee_P> employees_P;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        String[] names = getResources().getStringArray(R.array.employee_names);
        //{"Peter Parker", "Sam Spade", "Clark Kent", "Nancy Drew", "Fenton Hardy", "Diane Prince", "Bruce Wayne", "Dick Tracy", "Sherlock Holmes", "Hal Jordan"};
        String[] emails = getResources().getStringArray(R.array.employee_email_addresses);
        //{"PP@gmail.com", "SS@gmail.com", "CK@gmail.com", "ND@gmail.com", "FH@gmail.com", "DP@gmail.com", "BW@gmail.com", "DT@gmail.com", "SH@gmail.com", "HJ@gmail.com"};
        String[] phones = getResources().getStringArray(R.array.employee_phone_numbers);
        //{"5551234567", "555-123-7890", "555-124-1230", "555-124-7891", "555-124-1235", "555-124-5896", "555-124-1287", "555-124-8521", "555-129-1111", "555-129-2222"};

        employees = new ArrayList<>();
        employees_P = new ArrayList<>();
        for (int i = 0; i < names.length; i++) {
            Employee employee = new Employee(names[i], emails[i], phones[i]);
            employees.add(employee);
            Employee_P employee_p = new Employee_P(names[i], emails[i], phones[i]);
            employees_P.add(employee_p);
        }

        final Button employeesSerializableButton = findViewById(R.id.employeesSerializableButton);
        employeesSerializableButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity.this, ReportActivity.class);
                intent.putExtra("james", employees);
                startActivity(intent);
            }
        });
        final Button employeesParcelableButton = findViewById(R.id.employeesParcelableButton);
        employeesParcelableButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity.this, ReportParcelableActivity.class);
                intent.putExtra("james_P", employees_P);
                startActivity(intent);
            }
        });
    }
}
