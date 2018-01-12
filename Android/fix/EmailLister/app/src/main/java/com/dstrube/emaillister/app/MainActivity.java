package com.dstrube.emaillister.app;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.app.Activity;
import android.os.Bundle;
import android.util.Patterns;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

import java.util.ArrayList;
import java.util.regex.Pattern;


public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Pattern emailPattern = Patterns.EMAIL_ADDRESS; // API level 8+

        Account[] accounts = AccountManager.get(this).getAccounts();

//        String matches = "";

        ArrayList<String> list = new ArrayList<String>();

        for (Account account : accounts) {
            if (emailPattern.matcher(account.name).matches()) {
//            	matches += account.name + "; ";

                list.add(account.name);
            }
        }
//        Toast.makeText(getApplicationContext(), "Emails: "+matches , Toast.LENGTH_LONG).show();

        Spinner spinner = (Spinner) findViewById(R.id.spinner1);

        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item, list);

        spinner.setAdapter(adapter);
    }

}
