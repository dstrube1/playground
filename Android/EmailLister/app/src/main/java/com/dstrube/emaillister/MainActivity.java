package com.dstrube.emaillister;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.content.pm.PackageManager;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Patterns;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.regex.Pattern;

public class MainActivity extends AppCompatActivity {

    //https://developer.android.com/training/permissions/requesting.html
    //https://stackoverflow.com/questions/33896837/why-is-accountmanager-getcontext-getaccounts-returning-securityexception

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }

    @Override
    protected void onResume() {
        super.onResume();
        final String perm = "android.permission.GET_ACCOUNTS";
        final int check = checkSelfPermission(perm);
        if (check == PackageManager.PERMISSION_DENIED) {
            String[] perms = {perm};
            requestPermissions(perms, PackageManager.PERMISSION_GRANTED);
        } else{
            setSpinner();

        }
    }

    private  void setSpinner(){
        Pattern emailPattern = Patterns.EMAIL_ADDRESS; // API level 8+
        Account[] accounts = AccountManager.get(this).getAccounts();

        ArrayList<String> list = new ArrayList<>();

        for (Account account : accounts) {
            if (emailPattern.matcher(account.name).matches()) {

                list.add(account.name);
            }
        }

        Spinner spinner = findViewById(R.id.spinner1);

        ArrayAdapter<String> adapter = new ArrayAdapter<>(this,
                android.R.layout.simple_spinner_item, list);

        spinner.setAdapter(adapter);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           @NonNull String permissions[], @NonNull int[] grantResults) {
        if (requestCode == PackageManager.PERMISSION_GRANTED){
            //great
            setSpinner();
        }
        else {
            Toast.makeText(this, "GET_ACCOUNTS permission required", Toast.LENGTH_LONG).show();
        }
    }
}

