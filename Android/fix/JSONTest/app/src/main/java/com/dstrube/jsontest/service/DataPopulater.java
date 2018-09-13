package com.dstrube.jsontest.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.dstrube.jsontest.controller.DBController;

public class DataPopulater {

	private JSONArray contacts;
	private ArrayList<HashMap<String, String>> contactList;
	private DBController dbController;
	private final String TAG_ID = "id";
	// public final String TAG_NAME = "name";
	private final String TAG_LASTNAME = "lastName";
	private final String TAG_FIRSTNAME = "firstName";
	private final String TAG_EMAIL = "email";
	private final String TAG_TITLE = "title";
	private final String TAG_OFFICE_PHONE = "officePhone";
	private final String TAG_CELL_PHONE = "cellPhone";
	private final String TAG_MANAGER_ID = "managerId";
	private final String TAG_DEPARTMENT = "department";
	private final String TAG_CITY = "city";
	private final String TAG_THUMB_URL = "imageDownloadPath";
	private final String TAG_REPORT_COUNT = "reportCount";

	public DataPopulater(JSONArray contacts, ArrayList<HashMap<String, String>> contactList, DBController dbController) {
		setJSONArray(contacts);
		setContactList(contactList);
		setDBController(dbController);
	}

	private void setJSONArray(JSONArray contacts) {
		this.contacts = contacts;
	}

	private void setContactList(ArrayList<HashMap<String, String>> contactList) {
		this.contactList = contactList;
	}

	private void setDBController(DBController dbController) {
		this.dbController = dbController;
	}

	public ArrayList<HashMap<String, String>> populateListFromJSON() throws JSONException {
		try {

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
				// using hard coded string here because it's not called
				// "thumbUrl" in the JSON,
				// but needs to be called that when put in this map so that
				// it's recognized when inserting into the database
				map.put("thumbUrl", thumbUrl);
				map.put(TAG_REPORT_COUNT, reportCount);

				// adding HashList to ArrayList
				contactList.add(map);

				// and populate the database while we're at it
				dbController.insertEmployee(map);
			}
			// Toast.makeText(getApplicationContext(),
			// "Data is now in the database.", Toast.LENGTH_SHORT).show();
		} catch (JSONException e) {
			e.printStackTrace();
			// Toast.makeText(MainActivity.this, e.toString(),
			// Toast.LENGTH_LONG)
			// .show();
			throw e;
		}
		return contactList;

	}
}
