package com.dstrube.jsontest.controller;

import java.util.ArrayList;
import java.util.HashMap;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
//import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;
//import android.util.Log;

public class DBController extends SQLiteOpenHelper {

	//table name
	private static final String TABLE_NAME = "employee";

	/**
	 * Constructor
	 * @param context
	 */
	public DBController(Context context) {
		super(context, "androidsqlite.db", null, 1);
	}

	/**
	 * Create the database
	 */
	@Override
	public void onCreate(SQLiteDatabase db) {
		String query;
		query = "CREATE TABLE "+TABLE_NAME+" ( employeeId INTEGER PRIMARY KEY, firstName TEXT,  "
				+ "lastName TEXT, title TEXT, officePhone TEXT, cellPhone  TEXT, "
				+ "email TEXT, managerId INTEGER, department TEXT, city TEXT, thumbUrl TEXT, reportCount INTEGER)";
		db.execSQL(query);
	}

	/**
	 * Upgrade the database
	 */
	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		String query;
		query = "DROP TABLE IF EXISTS "+TABLE_NAME;
		db.execSQL(query);
		onCreate(db);
	}

	/**
	 * Insert row
	 * @param queryValues
	 */
	public void insertEmployee(HashMap<String, String> queryValues) {
		SQLiteDatabase database = this.getWritableDatabase();
		ContentValues values = new ContentValues();
		// id insert?
		values.put("employeeId", queryValues.get("employeeId"));

		values.put("firstName", queryValues.get("firstName"));
		values.put("lastName", queryValues.get("lastName"));
		values.put("title", queryValues.get("title"));
		values.put("officePhone", queryValues.get("officePhone"));
		values.put("cellPhone", queryValues.get("cellPhone"));
		values.put("email", queryValues.get("email"));
		values.put("managerId", queryValues.get("managerId"));
		values.put("department", queryValues.get("department"));
		values.put("city", queryValues.get("city"));
		values.put("thumbUrl", queryValues.get("thumbUrl"));
		values.put("reportCount", queryValues.get("reportCount"));

		long insertRowId = database.insert(TABLE_NAME, null, values);

		if (insertRowId != -1) {
			System.out.println("Successfully inserted row into "+TABLE_NAME);
		}

		database.close();
	}

	/**
	 * Update row
	 * @param queryValues
	 * @return
	 */
	public int updateEmployee(HashMap<String, String> queryValues) {
		SQLiteDatabase database = this.getWritableDatabase();
		ContentValues values = new ContentValues();

		values.put("firstName", queryValues.get("firstName"));
		values.put("lastName", queryValues.get("lastName"));
		values.put("title", queryValues.get("title"));
		values.put("officePhone", queryValues.get("officePhone"));
		values.put("cellPhone", queryValues.get("cellPhone"));
		values.put("email", queryValues.get("email"));
		values.put("managerId", queryValues.get("managerId"));
		values.put("department", queryValues.get("department"));
		values.put("city", queryValues.get("city"));
		values.put("thumbUrl", queryValues.get("thumbUrl"));
		values.put("reportCount", queryValues.get("reportCount"));

		return database.update(TABLE_NAME, values, "employeeId" + " = ?",
				new String[] { "1" });
	}
	
	/**
	 * Delete row
	 * @param id
	 */
	public void deleteEmployee(String id) {
	    
	    SQLiteDatabase database = this.getWritableDatabase();  
	    String deleteQuery = "DELETE FROM "+TABLE_NAME+" where employeeId='"+ id +"'"; 
	    database.execSQL(deleteQuery);
	  }
	
	/**
	 * Select * from employee
	 * @return
	 */
	public ArrayList<HashMap<String, String>> getAllEmployees() {
	    ArrayList<HashMap<String, String>> wordList;
	    wordList = new ArrayList<HashMap<String, String>>();
	    String selectQuery = "SELECT  * FROM employee";
	    SQLiteDatabase database = this.getWritableDatabase();
	    Cursor cursor = database.rawQuery(selectQuery, null);
	    if (cursor.moveToFirst()) {
	      do {
	        HashMap<String, String> map = new HashMap<String, String>();
	        map.put("employeeId", cursor.getString(0));
	        map.put("firstName", cursor.getString(1));
	        map.put("lastName", cursor.getString(2));
	        map.put("title", cursor.getString(3));
	        map.put("officePhone", cursor.getString(4));
	        map.put("cellPhone", cursor.getString(5));
	        map.put("email", cursor.getString(6));
	        map.put("managerId", cursor.getString(7));
	        map.put("department", cursor.getString(8));
	        map.put("city", cursor.getString(9));
	        map.put("thumbUrl", cursor.getString(10));
	        map.put("reportCount", cursor.getString(11));

	        
	        wordList.add(map);
	      } while (cursor.moveToNext());
	    }
	    return wordList;
	  }
	 
	/**
	 * Select * from employee where employeeid=id
	 * @param id
	 * @return
	 */
	  public HashMap<String, String> getEmployeeInfo(String id) {
	    HashMap<String, String> wordList = new HashMap<String, String>();
	    SQLiteDatabase database = this.getReadableDatabase();
	    String selectQuery = "SELECT * FROM employee where employeeId='"+id+"'";
	    Cursor cursor = database.rawQuery(selectQuery, null);
	    if (cursor.moveToFirst()) {
	      do {
	    	  wordList.put("firstName", cursor.getString(1));
	    	  wordList.put("lastName", cursor.getString(2));
	    	  wordList.put("title", cursor.getString(3));
	    	  wordList.put("officePhone", cursor.getString(4));
	    	  wordList.put("cellPhone", cursor.getString(5));
	    	  wordList.put("email", cursor.getString(6));
	    	  wordList.put("managerId", cursor.getString(7));
	    	  wordList.put("department", cursor.getString(8));
	    	  wordList.put("city", cursor.getString(9));
	    	  wordList.put("thumbUrl", cursor.getString(10));
	    	  wordList.put("reportCount", cursor.getString(11));

	      } while (cursor.moveToNext());
	    }           
	    return wordList;
	  } 
}
