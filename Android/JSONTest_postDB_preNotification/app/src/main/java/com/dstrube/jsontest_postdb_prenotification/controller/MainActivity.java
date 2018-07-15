package com.dstrube.jsontest_postdb_prenotification.controller;

import android.app.ListActivity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.dstrube.jsontest_postdb_prenotification.R;
import com.dstrube.jsontest_postdb_prenotification.service.JSONParser;
import com.dstrube.jsontest_postdb_prenotification.view.CustomAdapter;
import com.dstrube.jsontest_postdb_prenotification.view.SingleMenuItemActivity;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;

public class MainActivity extends ListActivity {

    //db controller:
    DBController controller = new DBController(this);
    final String url = "http://learnresfull-restcall.rhcloud.com/restaurent";

    //these tags are both the tags in the JSON, and (for the most part) used to distinguish the ListView and database columns
    // final String TAG_ROOT = "contacts";
    final String TAG_ID = "id";
    //	public final String TAG_NAME = "name";
    public final String TAG_LASTNAME = "lastName";
    public final String TAG_FIRSTNAME = "firstName";
    public final String TAG_EMAIL = "email";
    public final String TAG_TITLE = "title";
    public final String TAG_OFFICE_PHONE = "officePhone";
    public final String TAG_CELL_PHONE = "cellPhone";
    public final String TAG_MANAGER_ID = "managerId";
    public final String TAG_DEPARTMENT = "department";
    public final String TAG_CITY = "city";
    public final String TAG_THUMB_URL = "imageDownloadPath";
    public final String TAG_REPORT_COUNT = "reportCount";

    ArrayList<HashMap<String, String>> contactList;
    JSONParser parser;
    // JSONObject json;
    JSONArray contacts = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // ArrayList of Hashmaps for ListView
        contactList = new ArrayList<>();

        // Creating JSON Parser instance
        parser = new JSONParser();

    }

    /**
     * Getting things set up and running
     */
    @Override
    protected void onResume() {
        super.onResume();
        ArrayList<HashMap<String, String>> employeeList = controller
                .getAllEmployees();
        if (employeeList.size() == 0) {
            // Doing the network call that gets the data and subsequently
            // populates the list
            new NetworkJSONCall().execute();
        } else {
            populateListFromDB();
        }
    }

    /**
     * If database has data
     */
    private void populateListFromDB() {
        for (HashMap<String, String> employee : controller.getAllEmployees()) {
            contactList.add(employee);
        }
        setAdapterAndListener();
    }

    /**
     * Called from either populateDB or populateFromJSON
     */
    private void setAdapterAndListener() {
        CustomAdapter adapter = new CustomAdapter(this, contactList,
                R.layout.list_item, new String[]{TAG_FIRSTNAME, TAG_LASTNAME, TAG_EMAIL,
                TAG_TITLE, TAG_THUMB_URL}, new int[]{R.id.fName, R.id.lName, R.id.email, //
                R.id.title, R.id.thumb});//

        setListAdapter(adapter);

        // selecting single ListView item
        ListView lv = getListView();

        // Launching new screen on Selecting Single ListItem
        lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view,
                                    int position, long id) {
                // getting values from selected ListItem
                String firstName = ((TextView) view.findViewById(R.id.fName))
                        .getText().toString();
                String lastName = ((TextView) view.findViewById(R.id.lName))
                        .getText().toString();
                String email = ((TextView) view.findViewById(R.id.email))
                        .getText().toString();
                String title = ((TextView) view.findViewById(R.id.title))
                        .getText().toString();
                // Starting new intent
                Intent in = new Intent(getApplicationContext(),
                        SingleMenuItemActivity.class);
                in.putExtra(TAG_FIRSTNAME, firstName);
                in.putExtra(TAG_LASTNAME, lastName);
                in.putExtra(TAG_EMAIL, email);
                in.putExtra(TAG_TITLE, title);
                startActivity(in);
            }
        });
    }

    /**
     * If database has no data, get the data, put it in the database, then display it
     */
    private void populateListFromJSON() {
        // Getting Root Array
        try {

            // On second thought, let's let the JSONParser just return a JSON
            // array instead of a JSON Object
            // contacts = json.getJSONArray(TAG_ROOT);

            if (contacts != null)
                // looping through All Contacts
                for (int i = 0; i < contacts.length(); i++) {
                    JSONObject c = contacts.getJSONObject(i);

                    // Storing each json item in variable
                    String id = c.getString(TAG_ID);
                    String lastName = c.getString(TAG_LASTNAME);
                    String firstName = c.getString(TAG_FIRSTNAME);
                    String email = c.getString(TAG_EMAIL);
                    String title = c.getString(TAG_TITLE);
                    String officePhone = c.getString(TAG_OFFICE_PHONE);
                    String cellPhone = c.getString(TAG_CELL_PHONE);
                    String managerId = c.getString(TAG_MANAGER_ID);
                    String department = c.getString(TAG_DEPARTMENT);
                    String city = c.getString(TAG_CITY);
                    String thumbUrl = c.getString(TAG_THUMB_URL);
                    String reportCount = c.getString(TAG_REPORT_COUNT);


                    // creating a new single-row HashMap that will represent a row
                    // in the ListView
                    HashMap<String, String> map = new HashMap<String, String>();
                    // adding each child node to HashMap key => value
                    map.put(TAG_ID, id);
                    map.put(TAG_FIRSTNAME, firstName);
                    map.put(TAG_LASTNAME, lastName);
                    map.put(TAG_EMAIL, email);
                    map.put(TAG_TITLE, title);
                    map.put(TAG_OFFICE_PHONE, officePhone);
                    map.put(TAG_CELL_PHONE, cellPhone);
                    map.put(TAG_MANAGER_ID, managerId);
                    map.put(TAG_DEPARTMENT, department);
                    map.put(TAG_CITY, city);
                    //using hard coded string here because it's not called "thumbUrl" in the JSON,
                    //but needs to be called theat when put in this map so that it's recognized when inserting into the database
                    map.put("thumbUrl", thumbUrl);
                    map.put(TAG_REPORT_COUNT, reportCount);

                    // adding HashList to ArrayList
                    contactList.add(map);

                    //and populate the database while we're at it
                    controller.insertEmployee(map);

                }
            Toast.makeText(getApplicationContext(), "Data is now in the database.", Toast.LENGTH_SHORT).show();
        } catch (JSONException e) {
            // e.printStackTrace();
            Toast.makeText(MainActivity.this, e.toString(), Toast.LENGTH_LONG)
                    .show();
        }

        // next, putting parsed JSON data into ListView
        // ListAdapter adapter = new SimpleAdapter(this, contactList,
        // R.layout.list_item, new String[] { TAG_NAME, TAG_EMAIL,
        // TAG_TITLE }, new int[] { R.id.name, R.id.email,
        // R.id.title });
        setAdapterAndListener();
    }

    /**
     * Default
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    /**
     * Default
     */
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

    /**
     * The start of the JSON Network call
     *
     * @author david.strube
     */
    private class NetworkJSONCall extends AsyncTask<Void, Void, Void> {

        @Override
        protected Void doInBackground(Void... params) {
            contacts = parser.getJSONFromUrl(url, MainActivity.this, MainActivity.this);
            // json =

            return null;
        }

        @Override
        protected void onPostExecute(Void result) {

            populateListFromJSON();
        }

    }
}
