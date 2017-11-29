package com.dstrube.dbutiltestsstandalone;

import java.util.ArrayList;
import java.util.Hashtable;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class Utils extends SQLiteOpenHelper {

	private ArrayList<String> tableNames;
	private ArrayList<TableColumnList> tableColumnLists;

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
		// verify this doesn't break
		// db.close();
		// verified - that breaks.
		// not right away, but breaks selects (IllegalStateException) and
		// inserts (SQLiteDatabaseLockedException)
		Log.d("DBUtil", "at end of onCreate");

	}

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
	 * Constructor with all 4 params
	 * 
	 * @param context
	 * @param dbName
	 * @param factory
	 * @param version
	 * @throws UtilsException
	 */
	public Utils(Context context, String name, CursorFactory factory,
			int version) {
		super(context, name, factory, version);
	}

	/**
	 * Constructor with no params
	 * 
	 * @throws UtilsException
	 */
	public Utils() {
		this(null, "androidsqlite.db", null, 1);
	}

	/**
	 * Constructor with 1 param: context
	 * 
	 * @throws UtilsException
	 */
	public Utils(Context context) {
		this(context, "androidsqlite.db", null, 1);
	}

	/**
	 * Constructor with 2 params: context and dbName
	 * 
	 * @param context
	 * @param dbName
	 * @throws UtilsException
	 */
	public Utils(Context context, String dbName) {
		this(context, dbName, null, 1);
	}

	/**
	 * Constructor with 2 params: context and version
	 * 
	 * @param context
	 * @param version
	 * @throws UtilsException
	 */
	public Utils(Context context, int version) {
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
	public Utils(Context context, String dbName, int version) {
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
	// TODO: come back to this:
	/*
	 * @SuppressLint("NewApi")
	 * 
	 * @Override public String getDatabaseName() { if
	 * (android.os.Build.VERSION.SDK_INT >= 14) { //just for grins:
	 * SQLiteDatabase db = null; try { db = super.getReadableDatabase(); } catch
	 * (NullPointerException e) { // do nothing } finally { if (db != null) {
	 * db.close(); } } return super.getDatabaseName(); } else { SQLiteDatabase
	 * db = null; String path = ""; try { db = super.getReadableDatabase(); path
	 * = db.getPath();
	 * 
	 * } catch (NullPointerException e) { // do nothing } finally { if (db !=
	 * null) { db.close(); } } if (path.length() > 0) { return
	 * path.substring(path.lastIndexOf("/")); } else { return path; } } }
	 */

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
	 * Select * from TABLE_NAME Was going to call this getAllRowsForTable, but
	 * not until we need a method that actually gets all rows for All tables
	 * 
	 * @return
	 * @throws Exception
	 */
	public ArrayList<Hashtable<String, String>> getAllRows(String tableName)
			throws Exception {
		Log.d("DBUtil", "at beginning of getAllRows");
		ArrayList<Hashtable<String, String>> wordList;
		wordList = new ArrayList<Hashtable<String, String>>();
		try {
			final ArrayList<String> columnNamesForTable = getColumnNamesForTable(tableName);
			final String[] columns = columnNamesForTable
					.toArray(new String[columnNamesForTable.size()]);
			String selectQuery = "SELECT * FROM " + tableName;
			// if (this.)
			SQLiteDatabase database = this.getReadableDatabase();
			Cursor cursor = database.query(tableName, columns, null, null, "",
					"", "");
			if (cursor == null) {
				cursor = database.rawQuery(selectQuery, null);
			}
			if (cursor != null && cursor.moveToFirst()) {
				do {
					Hashtable<String, String> map = new Hashtable<String, String>();
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
			throw new Exception(e.getMessage());
		}
		Log.d("DBUtil", "at end of getAllRows");
		return wordList;
	}
}
