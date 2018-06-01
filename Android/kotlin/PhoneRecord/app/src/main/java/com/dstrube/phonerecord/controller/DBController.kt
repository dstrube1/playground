package com.dstrube.phonerecord.controller

import android.database.sqlite.SQLiteDatabase
import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteOpenHelper
import com.dstrube.phonerecord.R


class DBController
/**
 * Constructor
 *
 * @param context
 */
(context: Context) : SQLiteOpenHelper(context, "phoneRecord.db", null, 1) {

    // table name
    private val TABLE_NAME = "phoneRecord"
    private val columnNames: Array<String>
    private val columns = HashMap<String, String>()

    /**
     * Select * from TABLE_NAME
     *
     * @return
     */
    // map.put("employeeId", cursor.getString(0));
    // TODO: make sure this doesn't break anything:
    val allRows: ArrayList<HashMap<String, String>>
        get() {
            val wordList: ArrayList<HashMap<String, String>> = ArrayList()
            val selectQuery = "SELECT  * FROM $TABLE_NAME"
            val database = this.writableDatabase
            val cursor = database.rawQuery(selectQuery, null)
            if (cursor.moveToFirst()) {
                do {
                    val map = HashMap<String, String>()
                    for (i in columnNames.indices) {
                        map[columnNames[i]] = cursor.getString(i)
                    }

                    wordList.add(map)
                } while (cursor.moveToNext())
            }
            cursor.close()
            database.close()
            return wordList
        }

    init {
        columnNames = context.resources.getStringArray(
                R.array.column_names)
        val columnTypes = context.resources.getStringArray(
                R.array.column_types)
        for (i in columnNames.indices) {
            columns[columnNames[i]] = columnTypes[i]
        }
    }

    /**
     * Create the database
     */
    override fun onCreate(db: SQLiteDatabase) {
        // TODO: test this carefully on first run
        var query = "CREATE TABLE $TABLE_NAME ( "
        for (i in columnNames.indices) {
            query += columnNames[i] + " " + columns[columnNames[i]]
            if (i < columnNames.size - 1) { // not sure about this
                query += ", "
            }
        }
        query += ")"
        db.execSQL(query)
    }

    /**
     * Upgrade the database
     */
    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
        val query = "DROP TABLE IF EXISTS $TABLE_NAME"
        db.execSQL(query)
        onCreate(db)
    }

    /**
     * Insert row
     *
     * @param queryValues
     */
    fun insertRow(queryValues: HashMap<String, String>) {
        val database = this.writableDatabase
        val values = ContentValues()
        // id insert?
        for (column in columnNames) {
            values.put(column, queryValues[column])
        }
        // values.put("callId", queryValues.get("callId"));
        //
        // values.put("phoneNumber", queryValues.get("phoneNumber"));
        // values.put("callerName", queryValues.get("callerName"));
        // values.put("callDateTime", queryValues.get("callDateTime"));
        // values.put("latitude", queryValues.get("latitude"));
        // values.put("longitude", queryValues.get("longitude"));
        val insertRowId = database.insert(TABLE_NAME, null, values)

        if (insertRowId.toInt() != -1) {
            println("Successfully inserted row into $TABLE_NAME")
        }

        database.close()
    }

    /**
     * Update row
     *
     * @param queryValues
     * @return
     */
    fun updateRow(queryValues: HashMap<String, String>): Int {
        val database = this.writableDatabase
        val values = ContentValues()

        // starting with 1 to exclude id
        for (i in 1 until columnNames.size) {
            values.put(columnNames[i],
                    queryValues[columns[columnNames[i]]])
        }
        // values.put("phoneNumber", queryValues.get("phoneNumber"));
        // values.put("callerName", queryValues.get("callerName"));
        // values.put("callDateTime", queryValues.get("callDateTime"));
        // values.put("latitude", queryValues.get("latitude"));
        // values.put("longitude", queryValues.get("longitude"));
        return database.update(TABLE_NAME, values, columnNames[0] + " = ?",
                arrayOf("1"))
        // anyway to try / finally database.close(); ?
    }

    /**
     * Delete row
     *
     * @param id
     */
    fun deleteRow(id: String) {

        val database = this.writableDatabase
        val deleteQuery = ("DELETE FROM " + TABLE_NAME + " where "
                + columnNames[0] + "='" + id + "'")// single ticks? isn't that
        // String whereas primary
        // key was specified as
        // integer above?
        database.execSQL(deleteQuery)
        // TODO: make sure this doesn't break anything:
        database.close()
    }

    /**
     * Select * from TABLE_NAME where PRIMARY KEY=id
     *
     * @param id
     * @return
     */
    fun getRow(id: String): HashMap<String, String> {
        val wordList = HashMap<String, String>()
        val database = this.readableDatabase
        val selectQuery = ("SELECT * FROM " + TABLE_NAME + " where "
                + columnNames[0] + "='" + id + "'")
        val cursor = database.rawQuery(selectQuery, null)
        if (cursor.moveToFirst()) {
            do {
                for (i in 1 until columnNames.size) {
                    wordList[columnNames[i]] = cursor.getString(i)
                }
                // wordList.put("firstName", cursor.getString(1));

            } while (cursor.moveToNext())
        }
        // TODO: make sure this doesn't break anything:
        cursor.close()
        database.close()
        return wordList
    }

}
