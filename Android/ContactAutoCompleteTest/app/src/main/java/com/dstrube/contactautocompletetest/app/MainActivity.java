package com.dstrube.contactautocompletetest.app;

import android.app.Activity;
import android.content.ContentResolver;
import android.database.Cursor;
import android.os.Bundle;
import android.provider.ContactsContract;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Toast;

import java.util.ArrayList;

public class MainActivity extends Activity {

    private AutoCompleteTextView actV;
    private ArrayAdapter<String> adapter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        actV = findViewById(R.id.autoCompleteTextView1);

        // from
        // http://androidexample.com/Show_Phone_Contacts_In_AutoComplete_Suggestions_-_Android_Example/index.php?view=article_discription&aid=106
        // Create adapter
        adapter = new ArrayAdapter<>(this,
                android.R.layout.simple_dropdown_item_1line,
                new ArrayList<String>());

        readContactData();

        actV.setThreshold(1);
        actV.setAdapter(adapter);
    }

    private void readContactData() {
        String phoneNumber = "";
        ContentResolver cr = getBaseContext().getContentResolver();

        // Query to get contact name

        Cursor cur = cr.query(ContactsContract.Contacts.CONTENT_URI, null,
                null, null, null);

        if (cur != null && cur.getCount() <= 0) {
            // we're done here.
            Toast.makeText(getApplicationContext(), "No contacts found",
                    Toast.LENGTH_LONG).show();
            cur.close();
            return;
        }

        int k = 0;
        String name;

        if (cur != null) {
            while (cur.moveToNext()) {
                String id = cur.getString(cur
                        .getColumnIndex(ContactsContract.Contacts._ID));
                name = cur.getString(cur
                        .getColumnIndex(ContactsContract.Contacts.DISPLAY_NAME));

                if (Integer
                        .parseInt(cur.getString(cur
                                .getColumnIndex(ContactsContract.Contacts.HAS_PHONE_NUMBER))) <= 0) {
                    continue;
                }
                // Create query to get phone number by contact id
                Cursor pCur = cr.query(
                        ContactsContract.CommonDataKinds.Phone.CONTENT_URI, null,
                        ContactsContract.CommonDataKinds.Phone.CONTACT_ID + " = ?",
                        new String[] { id }, null);
                int j = 0;
                if (pCur != null) {
                    while (pCur.moveToNext()) {
                        // Sometimes get multiple data
                        if (j == 0) {
                            // Get Phone number
                            phoneNumber = ""
                                    + pCur.getString(pCur
                                    .getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));

                            // Add contacts names to adapter
                            adapter.add(name);

                            // Add ArrayList names to adapter
                            // phoneValueArr.add(phoneNumber.toString());
                            // nameValueArr.add(name.toString());

                            j++;
                            k++;
                        }
                    }
                    pCur.close();
                }
            }
        }
    }
}
