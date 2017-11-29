package com.example.instagram;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

import android.util.Log;
import com.android.volley.Request.Method;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;

//
//Singleton class to handle all server calls
//
public class InstagramDataSource implements Response.ErrorListener, Response.Listener<JSONObject>{
	private RequestQueue requestQueue;
	private ArrayList<String> imagesUrls;
	private int retries;
	private String urlString;
	private boolean loading;
	private OnDataChangedListener onDataChangedListener;
	private static InstagramDataSource singleton;
	
	//
	//Singleton and construct section
	//
	public static InstagramDataSource getInstance() {
		if(singleton == null) singleton = new InstagramDataSource("selfie");
		return singleton;
    }
	
	private InstagramDataSource(String tag){
		loading = true;
		retries = 0;
		requestQueue = App.getRequestQueue();
		imagesUrls = new ArrayList<String>();
		prepareUrlString(tag);
	}
	
	private void prepareUrlString(String tag){
		String client_id = "b27c76f98abc441998ac188f7a369219";
		urlString = "https://api.instagram.com/v1/tags/{tag}/media/recent/?client_id={client_id}";
        urlString = urlString.replace("{tag}", tag);
        urlString = urlString.replace("{client_id}", client_id);
	}
	
	//
	//Methods to getMoreData
	//
	public void getMoreData(){
		Log.d("Instagram", "getMoreData\nurl: " + urlString);
		loading = true;
		JsonObjectRequest request = new JsonObjectRequest(Method.GET, urlString, null,this, this);
		requestQueue.add(request);
	}
	
	private String getImgUrlFromJsonObject(JSONObject response) throws Exception{
		response = response.getJSONObject("images");
		response = response.getJSONObject("low_resolution");
		return response.getString("url");
	}
	
	
	//
	//Methods & Interfaces by listeners
	//
	public interface OnDataChangedListener{
		public void onDataChanged();
	}
	public ArrayList<String> getImagesUrls(){
		return imagesUrls;
	}
	public void setOnDataChangedListener(OnDataChangedListener onDataChangedListener) {
		this.onDataChangedListener = onDataChangedListener;
	}
	
	
	//
	//Requests call backs
	//
	@Override
	public void onErrorResponse(VolleyError error) {
		retries ++;
		if(retries > 5) return;
		Log.e("Instagram", "Attempt " + retries + " getMoreData request " + error.getMessage());
		getMoreData(); //retry request if fail
	}
	@Override
	public void onResponse(JSONObject response) {
		retries = 0;
		Log.d("Instagram", "getMoreData request done");
		try {
			JSONObject pagination = response.getJSONObject("pagination");
			urlString = pagination.getString("next_url"); //replace the old URL to gather more data
			JSONArray data = response.getJSONArray("data");
			int length = data.length();
			for(int i = 0; i< length; i++){
				imagesUrls.add(getImgUrlFromJsonObject(data.getJSONObject(i)));
			}
			loading = false;
			onDataChangedListener.onDataChanged();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//
	//Other getters and setters
	//
	public boolean isLoading(){
		return loading;
	}
}
