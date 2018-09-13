package com.dstrube.jsontest.controller;

import android.app.ListActivity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Looper;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.dstrube.jsontest.R;
import com.dstrube.jsontest.service.DataPopulater;
import com.dstrube.jsontest.service.JSONParser;
import com.dstrube.jsontest.view.CustomAdapter;
import com.dstrube.jsontest.view.NotificationReceiverActivity;
import com.dstrube.jsontest.view.SingleMenuItemActivity;

import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;
import java.util.HashMap;

//////////////////
/*
 * JSONTest
 * 2014-05-01: This project has gone thru multiple iterations.
 * Prior to this form, it was used with just JSON and a database component and image loader.
 * Before that, it was just JSON and an loader.
 * Now it's got JSON, an image loader, database, and Notification (plus a couple menu items: Refresh and Clean Slate).
 */
//////////////////
public class MainActivity extends ListActivity {

    // db controller:
    DBController controller = new DBController(this);
    final String url = "http://learnresfull-restcall.rhcloud.com/restaurent";

    // these tags are both the tags in the JSON, and (for the most part) used to
    // distinguish the ListView and database columns
    // final String TAG_ROOT = "contacts";
    final String TAG_ID = "id";
    // public final String TAG_NAME = "name";
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
    private ProgressDialog ringProgressDialog;
    private CustomAdapter adapter;
    private String downloadOrUpdate;

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
             //TODO 2018-03-26: The above call causes app to crash; fix has something to do with the following:
//            Looper.prepare();
            //Must come back to this later

            // ^That was before Notification integration.
            // Now we do nothing at first if the data isn't there.
            // And even if the data is there, we still give the user the option
            // to Update data
            // (instead of Get data)
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
     * If database has no data, get the data, put it in the database, then
     * display it
     */
    private void populateListFromJSON() {

        DataPopulater populater = new DataPopulater(contacts, contactList,
                controller);

        try {

            contactList = populater.populateListFromJSON();

            Toast.makeText(getApplicationContext(),
                    "Data is now in the database.", Toast.LENGTH_SHORT).show();
        } catch (JSONException e) {
            // e.printStackTrace();
            Toast.makeText(MainActivity.this, e.toString(), Toast.LENGTH_LONG)
                    .show();
        }

        setAdapterAndListener();

        ringProgressDialog.dismiss();

        addNotification();
    }

    private void addNotification() {
        Intent intent = new Intent(this, NotificationReceiverActivity.class);
        PendingIntent pIntent = PendingIntent.getActivity(this, 0, intent, 0);

        String tickerText = downloadOrUpdate + " complete!";
        String contentTitle = downloadOrUpdate
                + " of employee data is complete.";
        String contentText = contentTitle
                + " All employee data is now listed and up to date.";
        String bigText = contentText
                + " Employee data is in the database as well for faster future loading.";
        Notification notification = new Notification.Builder(this)
                .setTicker(tickerText).setContentTitle(contentTitle)
                .setContentText(contentText)
                .setSmallIcon(R.drawable.ic_launcher).setContentIntent(pIntent)
                .setStyle(new Notification.BigTextStyle().bigText(bigText))
                .build();

        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        // hide the notification after its selected

        notification.flags |= Notification.FLAG_AUTO_CANCEL;

        notificationManager.notify(0, notification);
    }

    /**
     * Called from either populateDB or populateFromJSON
     */
    private void setAdapterAndListener() {
        adapter = new CustomAdapter(this, contactList, R.layout.list_item,
                new String[] { TAG_FIRSTNAME, TAG_LASTNAME, TAG_EMAIL,
                        TAG_TITLE, TAG_THUMB_URL }, new int[] { R.id.fName,
                R.id.lName, R.id.email, //
                R.id.title, R.id.thumb });//

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
     * Default
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    /**
     * Handle action bar item clicks
     */
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        } else if (id == R.id.refresh) {
            Refresh();
            return true;
            // Toast.makeText(getApplicationContext(), "Refreshing",
            // Toast.LENGTH_SHORT).show();
        } else if (id == R.id.cleanSlate) {
            CleanSlate();
        }
        return super.onOptionsItemSelected(item);
    }

    private void Refresh() {
        String progressMessage = "";
        if (contactList == null || contactList.size() == 0) {
            progressMessage = "Downloading employee info ...";
            downloadOrUpdate = "Download";
        } else {
            progressMessage = "Updating employee info ...";
            downloadOrUpdate = "Update";
        }
        ringProgressDialog = ProgressDialog.show(MainActivity.this,
                "Please wait ...", progressMessage, true);
        ringProgressDialog.setCancelable(true);

        // maybe doesn't require thread

        // new Thread(new Runnable() {
        // @Override
        // public void run() {
        // try {
        // time consuming task:
        // Thread.sleep(3000);
        new NetworkJSONCall().execute();
        // } catch (Exception e) {
        //
        // }
        // }
        // }).start();
    }

    /**
     * The start of the JSON Network call
     *
     * @author david.strube
     *
     */
    private class NetworkJSONCall extends AsyncTask<Void, Void, Void> {

        @Override
        protected Void doInBackground(Void... params) {
            contacts = parser.getJSONFromUrl(url, MainActivity.this);
            // json =

            return null;
        }

        @Override
        protected void onPostExecute(Void result) {

            populateListFromJSON();
        }

    }

    private void CleanSlate() {
        if (contactList == null || contactList.size() == 0) {
            Toast.makeText(getApplicationContext(),
                    "Slate has already been cleaned.", Toast.LENGTH_SHORT)
                    .show();
            return;
        }
        contactList = new ArrayList<HashMap<String, String>>();
        for (HashMap<String, String> employee : controller.getAllEmployees()) {
            controller.deleteEmployee(employee.get("employeeId"));
        }

        adapter.notifyDataSetChanged();
        // something is missing here - this doesn't work ^^^

        adapter = new CustomAdapter(this, contactList, R.layout.list_item,
                new String[] { TAG_FIRSTNAME, TAG_LASTNAME, TAG_EMAIL,
                        TAG_TITLE, TAG_THUMB_URL }, new int[] { R.id.fName,
                R.id.lName, R.id.email, //
                R.id.title, R.id.thumb });//

        setListAdapter(adapter);
        Toast.makeText(getApplicationContext(), "Slate cleaned.",
                Toast.LENGTH_SHORT).show();
    }
}
