package com.dstrube.jsontest_postdb_prenotification.service;

import org.json.JSONArray;
import org.json.JSONException;

import com.dstrube.jsontest_postdb_prenotification.controller.MainActivity;
import com.dstrube.jsontest_postdb_prenotification.network.HttpConnectionManager;

import android.content.Context;
import android.widget.Toast;

/**
 * This is the class that downloads JSON data from a URL
 * @author david.strube
 *
 */
public class JSONParser {

//	private JSONObject jObj = null;
	private String jsonString = "";
	private String URL = "";
	
	//Constructor
	public JSONParser() {
		//make contructor with url param
	}
	
	//Constructor
	public JSONParser(String url) {
		URL = url;
	}
	
	//todo:
//    https://stackoverflow.com/questions/17379002/java-lang-runtimeexception-cant-create-handler-inside-thread-that-has-not-call

	//Input: a URL
	//Output: JSONArray
	public JSONArray getJSONFromUrl(String url, final Context ctx, final MainActivity parent) {

		if (URL == null || URL.equals("")){
			URL = url;
		}
		//return object
		JSONArray jarray = null;
		
		// Making HTTP request
		jsonString = HttpConnectionManager.Get(URL, ctx, parent);
		
		// try parse the string to a JSON object
		try {
			//kludge:
//			if (jsonString.substring(0, 1).equals("[")){
//				jsonString = "{ \"contacts\": " + jsonString + "}";
//			}
			//better:
			 jarray = new JSONArray(jsonString);
			//jObj = new JSONObject(jarray);
		} catch (final JSONException e) {

//			Log.e("JSON Parser", "Error parsing data " + e.toString());
			parent.runOnUiThread(new Runnable() {
				public void run() {
					Toast.makeText(ctx, "Error parsing data " + e.toString(),
							Toast.LENGTH_LONG).show();
				}
			});
		}
		
		// return JSONObject
		return jarray;

	}
}
