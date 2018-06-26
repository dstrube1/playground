package com.sqllite.samplesqllite;

import java.util.ArrayList;
import java.util.HashMap;
 
import android.util.Log;
 
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
 
public class DBController  extends SQLiteOpenHelper {
//  private static final String LOGCAT = null;
 
  private static final int DB_VERSION = 2;

  private static final String TABLE_NAME = "animals";
  private static final String TAG = DBController.class.getName();

  public DBController(Context applicationcontext) {
    super(applicationcontext, "androidsqlite.db", null, DB_VERSION);
    Log.d(TAG,"Created");
  }
 
  @Override
  public void onCreate(SQLiteDatabase database) {
	  Log.d("DBController - onCreate", "at beginning of onCreate");
    String query;
    query = "CREATE TABLE animals ( animalId INTEGER PRIMARY KEY, animalName TEXT, animalTallness TEXT)";
    database.execSQL(query);
    Log.d("DBController - onCreate", "at end of onCreate");
//    Log.d(LOGCAT,"animals database created Created");
  }
  
  @Override
  public void onUpgrade(SQLiteDatabase database, int version_old, int current_version) {
	  Log.d(TAG, "at beginning of onUpgrade");
    String query;
    query = "DROP TABLE IF EXISTS animals";
    database.execSQL(query);
    onCreate(database);
    Log.d(TAG, "at end of onUpgrade");
  }
 
  public void insertAnimal(HashMap<String, String> queryValues) {
	  Log.d(TAG, "at beginning of insertRow");
    SQLiteDatabase database = this.getWritableDatabase();
    ContentValues values = new ContentValues();
    values.put("animalName", queryValues.get("animalName"));
    values.put("animalTallness", queryValues.get("animalTallness"));
    
    long insertRowId = database.insert("animals", null, values);
    
    if(insertRowId != -1){
    	System.out.println("Successfully inserted row....");
    }
    
    database.close();
    Log.d(TAG, "at end of insertRow");
  }
 
  public int updateAnimal(HashMap<String, String> queryValues) {
	  Log.d(TAG, "at beginning of updateRow");
    SQLiteDatabase database = this.getWritableDatabase();  
    ContentValues values = new ContentValues();
    values.put("animalName", queryValues.get("animalName"));
    values.put("animalTallness", queryValues.get("animalTallness"));
    
    Log.d(TAG, "at end of updateRow");
    
    return database.update(TABLE_NAME, values, "animalId" + " = ?", new String[] {"1" });
  }
 
  public void deleteAnimal(String id) {
//    Log.d(LOGCAT,"delete");
	  Log.d(TAG, "at beginning of deleteAnimal");
    SQLiteDatabase database = this.getWritableDatabase();  
    String deleteQuery = "DELETE FROM  animals where animalId='"+ id +"'";
//    Log.d("query",deleteQuery);   
    database.execSQL(deleteQuery);
    
    Log.d(TAG, "at end of deleteAnimal");
  }
 
  public ArrayList<HashMap<String, String>> getAllAnimals() {
	  Log.d(TAG, "at beginning of getAllRows");
    ArrayList<HashMap<String, String>> wordList;
    wordList = new ArrayList<>();
    String selectQuery = "SELECT  * FROM animals";
    SQLiteDatabase database = this.getWritableDatabase();
    Cursor cursor = database.rawQuery(selectQuery, null);
    if (cursor.moveToFirst()) {
      do {
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("animalId", cursor.getString(0));
        map.put("animalName", cursor.getString(1));
        map.put("animalTallness", cursor.getString(2));
        
        wordList.add(map);
      } while (cursor.moveToNext());
    }
    Log.d(TAG, "at end of getAllRows");
    return wordList;
  }
 
  public HashMap<String, String> getAnimalInfo(String id) {
	  Log.d(TAG, "at beginning of getRowById");
    HashMap<String, String> wordList = new HashMap<String, String>();
    SQLiteDatabase database = this.getReadableDatabase();
    String selectQuery = "SELECT * FROM animals where animalId='"+id+"'";
    Cursor cursor = database.rawQuery(selectQuery, null);
    if (cursor.moveToFirst()) {
      do {
    	  wordList.put("animalName", cursor.getString(1));
    	  wordList.put("animalTallness", cursor.getString(2));
        
      } while (cursor.moveToNext());
    }           
    Log.d(TAG, "at end of getRowById");
    return wordList;
  } 
}