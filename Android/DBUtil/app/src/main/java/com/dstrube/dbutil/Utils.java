package com.dstrube.dbutil;

import java.util.ArrayList;
import java.util.Hashtable;
//import java.util.HashMap;
//import java.util.Set;

import android.annotation.SuppressLint;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.util.Log;

public class Utils extends SQLiteOpenHelper {

	/**
	 * This would be an excellent candidate for Android Test Suite, except for
	 * the fact that it's a library project. Must be tested in a testing
	 * application. :(
	 */

	private ArrayList<String> tableNames;
	// Hashtable is thread-safe, synchronized, no nulls allowed, but slow
	// HashMap is fast, but not thread safe, and order not guaranteed
	private ArrayList<TableColumnList> tableColumnLists;

	/**
	 * Constructor with all 4 params
	 * 
	 * @param context
	 * @param dbName
	 * @param factory
	 * @param version
	 * @throws UtilsException
	 */
	public Utils(Context context, String dbName, CursorFactory factory,
			int version) throws UtilsException {
		super(context, dbName, factory, version);
		// if (context == null) {
		// throw new UtilsException("Null context in contructor.");
		// }
		// if (dbName == null || dbName.length() == 0) {
		// throw new UtilsException(
		// "Null or empty database name in contructor.");
		// }
		// if (factory == null) {
		// throw new UtilsException("Null cursor factory in contructor.");
		// }
		// if (version <= 0) {
		// throw new UtilsException("Invalid version in contructor.");
		// }
	}

	/**
	 * Constructor with no params
	 * 
	 * @throws UtilsException
	 */
	public Utils() throws UtilsException {
		this(null, "androidsqlite.db", null, 1);
	}

	/**
	 * Constructor with 1 param: context
	 * 
	 * @throws UtilsException
	 */
	public Utils(Context context) throws UtilsException {
		this(context, "androidsqlite.db", null, 1);
	}

	/**
	 * Constructor with 2 params: context and dbName
	 * 
	 * @param context
	 * @param dbName
	 * @throws UtilsException
	 */
	public Utils(Context context, String dbName) throws UtilsException {
		this(context, dbName, null, 1);
	}

	/**
	 * Constructor with 2 params: context and version
	 * 
	 * @param context
	 * @param version
	 * @throws UtilsException
	 */
	public Utils(Context context, int version) throws UtilsException {
		this(context, "androidsqlite.db", null, version);
	}

	/**
	 * Constructor with 3 params
	 * 
	 * @param context
	 * @param dbName
	 * @param version
	 * @throws UtilsException
	 */
	public Utils(Context context, String dbName, int version)
			throws UtilsException {
		this(context, dbName, null, version);
	}

	public void setTableNames(ArrayList<String> tableNames) {
		this.tableNames = tableNames;
	}

	public ArrayList<String> getTableNames() {
		return tableNames;
	}

	public void setColumns(ArrayList<TableColumnList> tableColumnLists) {
		this.tableColumnLists = tableColumnLists;
	}

	// public only for testing
	public ArrayList<TableColumnList> getColumns() {
		return tableColumnLists;
	}

	// public only for testing
	public ArrayList<String> getColumnNamesForTable(String tableName) {
		for (TableColumnList columnList : tableColumnLists) {
			if (columnList.getTableName().equals(tableName)) {
				return columnList.getColumnNames();
			}
		}
		return null;
	}

	// public only for testing
	public ArrayList<String> getColumnDatatypesForTable(String tableName) {
		for (TableColumnList columnList : tableColumnLists) {
			if (columnList.getTableName().equals(tableName)) {
				// Log.d("DBUtil - getColumnDatatypesForTable",
				// "at end of getColumnDatatypesForTable");
				return columnList.getColumnDataTypes();
			}
		}
		return null;
	}

	/*
	 * This didn't become available until API 14, Ice cream sandwich :(
	 * http://developer
	 * .android.com/reference/android/database/sqlite/SQLiteOpenHelper
	 * .html#getDatabaseName()
	 * http://en.wikipedia.org/wiki/Android_version_history
	 */
	@SuppressLint("NewApi")
	@Override
	public String getDatabaseName() {
		if (android.os.Build.VERSION.SDK_INT >= 14) {
			// just for grins:
			SQLiteDatabase db = null;
			try {
				db = super.getReadableDatabase();
			} catch (NullPointerException e) {
				// do nothing
			} finally {
				if (db != null) {
					db.close();
				}
			}
			return super.getDatabaseName();
		} else {
			SQLiteDatabase db = null;
			String path = "";
			try {
				db = super.getReadableDatabase();
				path = db.getPath();

			} catch (NullPointerException e) {
				// do nothing
			} finally {
				if (db != null) {
					db.close();
				}
			}
			if (path.length() > 0) {
				return path.substring(path.lastIndexOf("/"));
			} else {
				return path;
			}
		}
	}

	/**
	 * Create the database
	 */
	@Override
	public void onCreate(SQLiteDatabase db) {
		Log.d("DBUtil", "at beginning of onCreate");
		StringBuilder query = new StringBuilder();
		for (String tableName : tableNames) {
			final ArrayList<String> columnNamesForTable = getColumnNamesForTable(tableName);
			final ArrayList<String> columnDatatypesForTable = getColumnDatatypesForTable(tableName);
			if (columnNamesForTable.size() != columnDatatypesForTable.size()) {
				return;
			}
			query.append("CREATE TABLE IF NOT EXISTS " + tableName + " ( ");
			for (int i = 0; i < columnNamesForTable.size(); i++) {
				query.append(columnNamesForTable.get(i) + " "
						+ columnDatatypesForTable.get(i) + ",");
			}
			if (query.toString().endsWith(",")) {
				query = new StringBuilder(
						query.substring(0, query.length() - 2));
				query.append("); ");
			}
		}
		db.execSQL(query.toString());
		// this breaks:
		// db.close();
		// not right away, but breaks selects (IllegalStateException) and
		// inserts (SQLiteDatabaseLockedException)
		Log.d("DBUtil", "at end of onCreate");

	}

	/**
	 * Upgrade the database
	 */
	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		Log.d("DBUtil", "at beginning of onUpgrade");
		String query;
		for (String tableName : tableNames) {
			query = "DROP TABLE IF EXISTS " + tableName;
			db.execSQL(query);
		}
		onCreate(db);
		// TODO verify this doesn't break
		db.close();
		Log.d("DBUtil", "at end of onUpgrade");
	}

	/**
	 * Insert a row
	 * 
	 * @param tableName
	 * @param queryValues
	 */
	public long insertRow(String tableName,
			Hashtable<String, String> queryValues, boolean idInsert) {
		Log.d("DBUtil", "at beginning of insertRow");
		SQLiteDatabase database = this.getWritableDatabase();
		ContentValues values = new ContentValues();

		final ArrayList<String> columnNamesForTable = getColumnNamesForTable(tableName);
		if (idInsert) {
			for (String columnName : columnNamesForTable) {
				values.put(columnName, queryValues.get(columnName));
			}
		} else {
			for (int i = 1; i < columnNamesForTable.size(); i++) {
				String columnName = columnNamesForTable.get(i);
				values.put(columnName, queryValues.get(columnName));
			}
		}
		long insertRowId = database.insert(tableName, null, values);

		if (insertRowId != -1) {
			// System.out.println("Successfully inserted row into " +
			// tableName);
		}

		// TODO: make sure this doesn't break anything:
		database.close();
		Log.d("DBUtil", "at end of insertRow");
		return insertRowId;
	}

	/**
	 * Update a row
	 * 
	 * @param queryValues
	 * @return
	 */
	/*
	 * public int updateRow(String tableName, Hashtable<String, String>
	 * queryValues) { Log.d("DBUtil", "at beginning of updateRow");
	 * SQLiteDatabase database = this.getWritableDatabase(); ContentValues
	 * values = new ContentValues(); final ArrayList<String> columnNamesForTable
	 * = getColumnNamesForTable(tableName);
	 * 
	 * for (int i = 1; i < columnNamesForTable.size(); i++) {
	 * 
	 * values.put(columnNamesForTable.get(i),
	 * queryValues.get(columnNamesForTable.get(i))); } int result =
	 * database.update(tableName, values, columnNamesForTable.get(0) + " = ?",
	 * new String[] { "1" });
	 * 
	 * // TODO: make sure this doesn't break anything: database.close();
	 * Log.d("DBUtil", "at end of updateRow"); return result; }
	 */

	/**
	 * Delete a row
	 * 
	 * @param tableName
	 * @param id
	 */
	/*
	 * public void deleteRow(String tableName, String id) { Log.d("DBUtil",
	 * "at beginning of deleteRow"); SQLiteDatabase database =
	 * this.getWritableDatabase(); final ArrayList<String> columnNamesForTable =
	 * getColumnNamesForTable(tableName); String deleteQuery = "DELETE FROM " +
	 * tableName + " where " + columnNamesForTable.get(0) + "='" + id + "'"; //
	 * single ticks? isn't that String whereas primary key was specified as //
	 * integer above? database.execSQL(deleteQuery); // TODO: make sure this
	 * doesn't break anything: database.close();
	 * 
	 * Log.d("DBUtil", "at end of deleteRow"); }
	 */

	/**
	 * Select * from TABLE_NAME Was going to call this getAllRowsForTable, but
	 * not until we need a method that actually gets all rows for All tables
	 * 
	 * @return
	 */
	public ArrayList<Hashtable<String, String>> getAllRows(String tableName)
			throws UtilsException {
		Log.d("DBUtil", "at beginning of getAllRows");
		ArrayList<Hashtable<String, String>> wordList;
		wordList = new ArrayList<>();
		try {
			final ArrayList<String> columnNamesForTable = getColumnNamesForTable(tableName);
			final String[] columns = columnNamesForTable
					.toArray(new String[columnNamesForTable.size()]);
			String selectQuery = "SELECT * FROM " + tableName;
			SQLiteDatabase database = this.getReadableDatabase();
			Cursor cursor = database.query(tableName, columns, null, null, "",
					"", "");
			if (cursor == null) {
				cursor = database.rawQuery(selectQuery, null);
			}
			if (cursor != null && cursor.moveToFirst()) {
				do {
					Hashtable<String, String> map = new Hashtable<>();
					for (int i = 0; i < columnNamesForTable.size(); i++) {
						map.put(columnNamesForTable.get(i), cursor.getString(i));
					}

					wordList.add(map);
				} while (cursor.moveToNext());
				cursor.close();
			}
			// // TODO: make sure this doesn't break anything:
			database.close();
		} catch (Exception e) {
			throw new UtilsException(e.getMessage());
		}
		Log.d("DBUtil", "at end of getAllRows");
		return wordList;
	}

	/**
	 * Select * from TABLE_NAME where PRIMARY KEY=id
	 * 
	 * @param id
	 * @return
	 */
	/*
	 * public Hashtable<String, String> getRowsById(String tableName, String id)
	 * { Log.d("DBUtil", "at beginning of getRowById"); Hashtable<String,
	 * String> wordList = new Hashtable<String, String>(); SQLiteDatabase
	 * database = this.getReadableDatabase();
	 * 
	 * final ArrayList<String> columnNamesForTable =
	 * getColumnNamesForTable(tableName);
	 * 
	 * String selectQuery = "SELECT * FROM " + tableName + " where " +
	 * columnNamesForTable.get(0) + "='" + id + "'";
	 * 
	 * Cursor cursor = database.rawQuery(selectQuery, null); if
	 * (cursor.moveToFirst()) { do { for (int i = 1; i <
	 * columnNamesForTable.size(); i++) {
	 * wordList.put(columnNamesForTable.get(i), cursor.getString(i)); }
	 * 
	 * } while (cursor.moveToNext()); } // TODO: make sure this doesn't break
	 * anything: database.close(); Log.d("DBUtil", "at end of getRowById");
	 * return wordList; }
	 */

	/**
	 * Select * from TABLE_NAME where columnName=columnValue
	 * 
	 * @param tableName
	 * @param columnName
	 * @param columnValue
	 * @return
	 */
	/*
	 * public ArrayList<Hashtable<String, String>> getRowsWhere(String
	 * tableName, String columnName, String columnValue) { Log.d("DBUtil",
	 * "at beginning of getRowsWhere"); Hashtable<String, String> wordList = new
	 * Hashtable<String, String>(); SQLiteDatabase database =
	 * this.getReadableDatabase();
	 * 
	 * final ArrayList<String> columnNamesForTable =
	 * getColumnNamesForTable(tableName); // TODO: pass in a param that
	 * indicates whether this is int or string? String selectQuery =
	 * "SELECT * FROM " + tableName + " where " + columnName + "='" +
	 * columnValue + "'";
	 * 
	 * Cursor cursor = database.rawQuery(selectQuery, null); if
	 * (cursor.moveToFirst()) { do { for (int i = 1; i <
	 * columnNamesForTable.size(); i++) {
	 * wordList.put(columnNamesForTable.get(i), cursor.getString(i)); }
	 * 
	 * } while (cursor.moveToNext()); } // TODO: make sure this doesn't break
	 * anything: database.close(); Log.d("DBUtil", "at end of getRowsWhere");
	 * return null;//wordList; }
	 */

	/*
	 * public ArrayList<Hashtable<String, String>> getRowsWhereLessThan(String
	 * tableName, String columnName, String columnValue) { Log.d("DBUtil",
	 * "at beginning of getRowsWhereLessThan"); Hashtable<String, String>
	 * wordList = new Hashtable<String, String>(); SQLiteDatabase database =
	 * this.getReadableDatabase();
	 * 
	 * final ArrayList<String> columnNamesForTable =
	 * getColumnNamesForTable(tableName); // TODO: pass in a param that
	 * indicates whether this is int or string? String selectQuery =
	 * "SELECT * FROM " + tableName + " where " + columnName + "<'" +
	 * columnValue + "'";
	 * 
	 * Cursor cursor = database.rawQuery(selectQuery, null); if
	 * (cursor.moveToFirst()) { do { for (int i = 1; i <
	 * columnNamesForTable.size(); i++) {
	 * wordList.put(columnNamesForTable.get(i), cursor.getString(i)); }
	 * 
	 * } while (cursor.moveToNext()); } // TODO: make sure this doesn't break
	 * anything: database.close(); Log.d("DBUtil",
	 * "at end of getRowsWhereLessThan"); return null;//wordList; }
	 * 
	 * public ArrayList<Hashtable<String, String>>
	 * getRowsWhereGreaterThan(String tableName, String columnName, String
	 * columnValue) { Log.d("DBUtil",
	 * "at beginning of getRowsWhereGreaterThan"); Hashtable<String, String>
	 * wordList = new Hashtable<String, String>(); SQLiteDatabase database =
	 * this.getReadableDatabase();
	 * 
	 * final ArrayList<String> columnNamesForTable =
	 * getColumnNamesForTable(tableName); // TODO: pass in a param that
	 * indicates whether this is int or string? String selectQuery =
	 * "SELECT * FROM " + tableName + " where " + columnName + ">'" +
	 * columnValue + "'";
	 * 
	 * Cursor cursor = database.rawQuery(selectQuery, null); if
	 * (cursor.moveToFirst()) { do { for (int i = 1; i <
	 * columnNamesForTable.size(); i++) {
	 * wordList.put(columnNamesForTable.get(i), cursor.getString(i)); }
	 * 
	 * } while (cursor.moveToNext()); } // TODO: make sure this doesn't break
	 * anything: database.close(); Log.d("DBUtil",
	 * "at end of getRowsWhereGreaterThan"); return null;//wordList; }
	 * 
	 * public ArrayList<Hashtable<String, String>> getRowWhereBetween(String
	 * tableName, String columnName, String columnValueLow, String
	 * columnValueHigh) { Log.d("DBUtil", "at beginning of getRowWhereBetween");
	 * Hashtable<String, String> wordList = new Hashtable<String, String>();
	 * SQLiteDatabase database = this.getReadableDatabase();
	 * 
	 * final ArrayList<String> columnNamesForTable =
	 * getColumnNamesForTable(tableName); // TODO: pass in a param that
	 * indicates whether this is int or string? String selectQuery =
	 * "SELECT * FROM " + tableName + " where " + columnName + " between '" +
	 * columnValueLow + "' and '" + columnValueHigh + "'";
	 * 
	 * Cursor cursor = database.rawQuery(selectQuery, null); if
	 * (cursor.moveToFirst()) { do { for (int i = 1; i <
	 * columnNamesForTable.size(); i++) {
	 * wordList.put(columnNamesForTable.get(i), cursor.getString(i)); }
	 * 
	 * } while (cursor.moveToNext()); } // TODO: make sure this doesn't break
	 * anything: database.close(); Log.d("DBUtil",
	 * "at end of getRowWhereBetween"); return null;//wordList; }
	 */
}
