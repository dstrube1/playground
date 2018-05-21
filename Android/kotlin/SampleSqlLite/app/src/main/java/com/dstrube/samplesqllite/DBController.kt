package com.dstrube.samplesqllite

import android.content.Context
import android.database.sqlite.SQLiteOpenHelper
import android.database.sqlite.SQLiteDatabase
import android.util.Log
import android.content.ContentValues




class DBController (applicationContext: Context)
    : SQLiteOpenHelper(applicationContext, "androidsqlite.db", null, 1) {
    //  private static final String LOGCAT = null;

//    private val DB_VERSION = 2

    private val _tableName = "animals"

    //todo
//        Log.d("DBController constructor", "Created")

    //todo: genericize everything

    override fun onCreate(database: SQLiteDatabase) {
        Log.d("DBController - onCreate", "at beginning of onCreate")
        val query = "CREATE TABLE $_tableName ( animalId INTEGER PRIMARY KEY, animalName TEXT, animalTallness TEXT)"
        database.execSQL(query)
        Log.d("DBController - onCreate", "at end of onCreate")
        //    Log.d(LOGCAT,"animals database created Created");
    }

    override fun onUpgrade(database: SQLiteDatabase, version_old: Int, current_version: Int) {
        Log.d("DBController - onUpgrade", "at beginning of onUpgrade")
        val query = "DROP TABLE IF EXISTS $_tableName"
        database.execSQL(query)
        onCreate(database)
        Log.d("DBController - onUpgrade", "at end of onUpgrade")
    }

    fun insertAnimal(queryValues: HashMap<String, String>) {
        Log.d("DBController - insertRow", "at beginning of insertRow")
        val database = this.writableDatabase
        val values = ContentValues()
        values.put("animalName", queryValues["animalName"])
        values.put("animalTallness", queryValues["animalTallness"])

        val insertRowId = database.insert("animals", null, values)

        if (insertRowId != -1L) {
            println("Successfully inserted row....")
        }

        database.close()
        Log.d("DBController - insertRow", "at end of insertRow")
    }

    fun updateAnimal(queryValues: HashMap<String, String>): Int {
        Log.d("DBController - updateRow", "at beginning of updateRow")
        val database = this.writableDatabase
        val values = ContentValues()
        values.put("animalName", queryValues["animalName"])
        values.put("animalTallness", queryValues["animalTallness"])

        Log.d("DBController - updateRow", "at end of updateRow")

        return database.update(_tableName, values, "animalId" + " = ?", arrayOf("1"))
    }

    fun deleteAnimal(id: String) {
        //    Log.d(LOGCAT,"delete");
        Log.d("DBController - deleteAnimal", "at beginning of deleteAnimal")
        val database = this.writableDatabase
        val deleteQuery = "DELETE FROM  $_tableName where animalId='$id'"
        //    Log.d("query",deleteQuery);
        database.execSQL(deleteQuery)

        Log.d("DBController - deleteAnimal", "at end of deleteAnimal")
    }

    fun getAllAnimals(): ArrayList<HashMap<String, String>> {
        Log.d("DBController", "at beginning of getAllRows")
        val wordList: ArrayList<HashMap<String, String>> = ArrayList()
        val selectQuery = "SELECT  * FROM animals"
        val database = this.writableDatabase
        val cursor = database.rawQuery(selectQuery, null)
        if (cursor.moveToFirst()) {
            do {
                val map = HashMap<String, String>()
                map["animalId"] = cursor.getString(0)
                map["animalName"] = cursor.getString(1)
                map["animalTallness"] = cursor.getString(2)

                wordList.add(map)
            } while (cursor.moveToNext())
        }
        Log.d("DBController", "at end of getAllRows")
        return wordList
    }

    fun getAnimalInfo(id: String): HashMap<String, String> {
        Log.d("DBController", "at beginning of getRowById")
        val wordList = HashMap<String, String>()
        val database = this.readableDatabase
        val selectQuery = "SELECT * FROM animals where animalId='$id'"
        val cursor = database.rawQuery(selectQuery, null)
        if (cursor.moveToFirst()) {
            do {
                wordList["animalName"] = cursor.getString(1)
                wordList["animalTallness"] = cursor.getString(2)

            } while (cursor.moveToNext())
        }
        Log.d("DBController", "at end of getRowById")
        return wordList
    }
}