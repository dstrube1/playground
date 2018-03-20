package com.dstrube.phonerecord.controller;

import java.util.ArrayList;
import java.util.HashMap;

import com.dstrube.phonerecord.R;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DBController extends SQLiteOpenHelper {

	// table name
	private final String TABLE_NAME = "phoneRecord";
	private String[] columnNames;
	private HashMap<String, String> columns = new HashMap<String, String>();

	/**
	 * Constructor
	 * 
	 * @param context
	 */
	public DBController(Context context) {
		super(context, "phoneRecord.db", null, 1);
		columnNames = context.getResources().getStringArray(
				R.array.column_names);
		String[] columnTypes = context.getResources().getStringArray(
				R.array.column_types);
		for (int i = 0; i < columnNames.length; i++) {
			columns.put(columnNames[i], columnTypes[i]);
		}
	}

	/**
	 * Create the database
	 */
	@Override
	public void onCreate(SQLiteDatabase db) {
		// TODO: test this carefully on first run
		String query;
		query = "CREATE TABLE " + TABLE_NAME + " ( ";
		for (int i = 0; i < columnNames.length; i++) {
			query += columnNames[i] + " " + columns.get(columnNames[i]);
			if (i < columnNames.length - 1) { // not sure about this
				query += ", ";
			}
		}
		query += ")";
		db.execSQL(query);
	}

	/**
	 * Upgrade the database
	 */
	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		String query;
		query = "DROP TABLE IF EXISTS " + TABLE_NAME;
		db.execSQL(query);
		onCreate(db);
	}

	/**
	 * Insert row
	 * 
	 * @param queryValues
	 */
	public void insertRow(HashMap<String, String> queryValues) {
		SQLiteDatabase database = this.getWritableDatabase();
		ContentValues values = new ContentValues();
		// id insert?
		for (String column : columnNames) {
			values.put(column, queryValues.get(column));
		}
		// values.put("callId", queryValues.get("callId"));
		//
		// values.put("phoneNumber", queryValues.get("phoneNumber"));
		// values.put("callerName", queryValues.get("callerName"));
		// values.put("callDateTime", queryValues.get("callDateTime"));
		// values.put("latitude", queryValues.get("latitude"));
		// values.put("longitude", queryValues.get("longitude"));
		long insertRowId = database.insert(TABLE_NAME, null, values);

		if (insertRowId != -1) {
			System.out.println("Successfully inserted row into " + TABLE_NAME);
		}

		database.close();
	}

	/**
	 * Update row
	 * 
	 * @param queryValues
	 * @return
	 */
	public int updateRow(HashMap<String, String> queryValues) {
		SQLiteDatabase database = this.getWritableDatabase();
		ContentValues values = new ContentValues();

		// starting with 1 to exclude id
		for (int i = 1; i < columnNames.length; i++) {
			values.put(columnNames[i],
					queryValues.get(columns.get(columnNames[i])));
		}
		// values.put("phoneNumber", queryValues.get("phoneNumber"));
		// values.put("callerName", queryValues.get("callerName"));
		// values.put("callDateTime", queryValues.get("callDateTime"));
		// values.put("latitude", queryValues.get("latitude"));
		// values.put("longitude", queryValues.get("longitude"));
		return database.update(TABLE_NAME, values, columnNames[0] + " = ?",
				new String[] { "1" });
		// anyway to try / finally database.close(); ?
	}

	/**
	 * Delete row
	 * 
	 * @param id
	 */
	public void deleteRow(String id) {

		SQLiteDatabase database = this.getWritableDatabase();
		String deleteQuery = "DELETE FROM " + TABLE_NAME + " where "
				+ columnNames[0] + "='" + id + "'";// single ticks? isn't that
													// String whereas primary
													// key was specified as
													// integer above?
		database.execSQL(deleteQuery);
		// TODO: make sure this doesn't break anything:
		database.close();
	}

	/**
	 * Select * from TABLE_NAME
	 * 
	 * @return
	 */
	public ArrayList<HashMap<String, String>> getAllRows() {
		ArrayList<HashMap<String, String>> wordList;
		wordList = new ArrayList<>();
		String selectQuery = "SELECT  * FROM " + TABLE_NAME;
		SQLiteDatabase database = this.getWritableDatabase();
		Cursor cursor = database.rawQuery(selectQuery, null);
		if (cursor.moveToFirst()) {
			do {
				HashMap<String, String> map = new HashMap<String, String>();
				for (int i = 0; i < columnNames.length; i++) {
					map.put(columnNames[i], cursor.getString(i));
				}
				// map.put("employeeId", cursor.getString(0));

				wordList.add(map);
			} while (cursor.moveToNext());
		}
		// TODO: make sure this doesn't break anything:
		database.close();
		return wordList;
	}

	/**
	 * Select * from TABLE_NAME where PRIMARY KEY=id
	 * 
	 * @param id
	 * @return
	 */
	public HashMap<String, String> getRow(String id) {
		HashMap<String, String> wordList = new HashMap<String, String>();
		SQLiteDatabase database = this.getReadableDatabase();
		String selectQuery = "SELECT * FROM " + TABLE_NAME + " where "
				+ columnNames[0] + "='" + id + "'";
		Cursor cursor = database.rawQuery(selectQuery, null);
		if (cursor.moveToFirst()) {
			do {
				for (int i = 1; i < columnNames.length; i++) {
					wordList.put(columnNames[i], cursor.getString(i));
				}
				// wordList.put("firstName", cursor.getString(1));

			} while (cursor.moveToNext());
		}
		// TODO: make sure this doesn't break anything:
		database.close();
		return wordList;
	}

}
