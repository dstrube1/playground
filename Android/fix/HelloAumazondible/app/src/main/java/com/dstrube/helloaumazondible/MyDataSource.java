package com.dstrube.helloaumazondible;

import android.content.Context;
import android.util.Log;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

public class MyDataSource implements Response.ErrorListener,
        Response.Listener<JSONObject> {
    private RequestQueue requestQueue;
    private ArrayList<String> imagesUrls;
    private int retries;
    private String url;
    private boolean loading;
    private OnDataChangedListener onDataChangedListener;
    private static MyDataSource singleton;
    private final String CLIENT_ID = "e7ce3f1a709543c7a03313e7f2e02bb4";
    private final String TAG = "selfie";


    //TODO: perhaps use of volatile here for threading concerns?
    public static MyDataSource getInstance() {
        if (singleton == null)
            singleton = new MyDataSource();
        return singleton;
    }

    // Singleton pattern requires private constructor
    private MyDataSource() {
        imagesUrls = new ArrayList<>();
        loading = true;
        retries = 0;
        requestQueue = MyApplication.getRequestQueue();
        prepareUrlString();
    }

    public interface OnDataChangedListener {
        public void onDataChanged();
    }

    private void prepareUrlString() {
        url = "https://api.instagram.com/v1/tags/{tag}/media/recent/?client_id={client_id}";
        url = url.replace("{tag}", TAG);
        url = url.replace("{client_id}", CLIENT_ID);
    }

    @Override
    public void onResponse(JSONObject response) {
        retries = 0;
        Log.d("Instagram", "Beginning of onResponse; getMoreData request done");
        try {
            JSONObject pagination = response.getJSONObject("pagination");
            url = pagination.getString("next_url"); // replace the old URL
            // to gather more
            // data
            JSONArray data = response.getJSONArray("data");
            int length = data.length();
            for (int i = 0; i < length; i++) {
                imagesUrls.add(getImgUrlFromJsonObject(data.getJSONObject(i)));
            }
            loading = false;
            onDataChangedListener.onDataChanged();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /*TODO:
old url that might not even be valid anymore:
https://api.instagram.com/v1/tags/selfie/media/recent/?client_id=e7ce3f1a709543c7a03313e7f2e02bb4

example authentication url:
https://api.instagram.com/oauth/authorize/?client_id=e7ce3f1a709543c7a03313e7f2e02bb4&redirect_uri=http://colorofblah.blogspot.com/&response_type=code

1- see if instagramTest runs / gives warning about App not being registered in the manifest
2- read up:
https://www.instagram.com/developer/
*/

    @Override
    public void onErrorResponse(VolleyError error) {
        retries++;
        if (retries > 5)
            return;
        Log.e("Instagram", "Attempt " + retries + " getMoreData request "
                + error.getMessage());
        getMoreData(); // retry request if fail
    }

    //input = response
    private String getImgUrlFromJsonObject(JSONObject jsonObject)
            throws Exception {
        jsonObject = jsonObject.getJSONObject("images");
        jsonObject = jsonObject.getJSONObject("low_resolution");
        return jsonObject.getString("url");
    }

    public void getMoreData() {
        Log.d("Instagram", "getMoreData\nurl: " + url);
        loading = true;
        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest(Request.Method.GET,
                url, null, this, this);
        if (requestQueue != null)
            requestQueue.add(jsonObjectRequest);
    }

    public ArrayList<String> getImagesUrls() {
        return imagesUrls;
    }

    public void setOnDataChangedListener(
            OnDataChangedListener onDataChangedListener) {
        this.onDataChangedListener = onDataChangedListener;
    }

    public boolean isLoading() {
        return loading;
    }
}
