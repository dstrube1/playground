package com.dstrube.jsontest.service;

//import java.io.BufferedReader;
//import java.io.IOException;
//import java.io.InputStream;
//import java.io.InputStreamReader;
//import java.io.UnsupportedEncodingException;
//
//import org.apache.http.HttpEntity;
//import org.apache.http.HttpResponse;
//import org.apache.http.client.ClientProtocolException;
//import org.apache.http.client.methods.HttpPost;
//import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONException;
//import org.json.JSONObject;

import com.dstrube.jsontest.network.HttpConnectionManager;

import android.content.Context;
//import android.util.Log;
import android.widget.Toast;

/**
 * This is the class that downloads JSON data from a URL
 * @author david.strube
 *
 */
public class JSONParser_0 {

//	private JSONObject jObj = null;
	private String jsonString = "";
	private String URL = "";
	
	//Constructor
	public JSONParser_0() {
		//make contructor with url param
	}
	
	//Constructor
	public JSONParser_0(String url) {
		URL = url;
	}
	
	

	//Input: a URL
	//Output: JSONArray
	public JSONArray getJSONFromUrl(String url, Context ctx) {

		if (URL == null || URL.equals("")){
			URL = url;
		}
		//return object
		JSONArray jarray = null;
		
		// Making HTTP request
		jsonString = HttpConnectionManager.Get(URL, ctx);
		
		// try parse the string to a JSON object
		try {
			//kludge:
//			if (jsonString.substring(0, 1).equals("[")){
//				jsonString = "{ \"contacts\": " + jsonString + "}";
//			}
			//better:
			 jarray = new JSONArray(jsonString);
			//jObj = new JSONObject(jarray);
		} catch (JSONException e) {
			Toast.makeText(ctx, "Error parsing data " + e.toString(),
					Toast.LENGTH_LONG).show();
//			Log.e("JSON Parser", "Error parsing data " + e.toString());
		}
		
		// return JSONObject
		return jarray;

	}
}
