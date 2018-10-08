package com.dstrube.instagramtest;

import android.util.Log;

import com.android.volley.Request;
import com.android.volley.Request.Method;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

public class InstagramDataSource implements Response.ErrorListener, Response.Listener<JSONObject> {
    private static final String TAG = InstagramDataSource.class.getName();
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
        if (singleton == null) {
            singleton = new InstagramDataSource("http://colorofblah.blogspot.com/");
        }
        return singleton;
    }

    private InstagramDataSource(final String redirect_uri) {//finalString tag){
        loading = true;
        retries = 0;
        requestQueue = App.getRequestQueue();
        imagesUrls = new ArrayList<>();
        prepareUrlString(redirect_uri);
    }

    /*

     * */
    private void prepareUrlString(final String redirect_uri) {
        final String client_id = "e7ce3f1a709543c7a03313e7f2e02bb4";
        urlString = "https://api.instagram.com/oauth/authorize/?client_id={client_id}&redirect_uri={redirect_uri}&response_type=code";
        urlString = urlString.replace("{redirect_uri}", redirect_uri);
        urlString = urlString.replace("{client_id}", client_id);

    }

    //
    //Methods to getMoreData
    //
    public void getMoreData() {
        Log.d("Instagram", "getMoreData\nurl: " + urlString);
        loading = true;
        JsonObjectRequest request = new JsonObjectRequest(Method.GET, urlString, null, this, this);
        requestQueue.add(request);
    }

    private String getImgUrlFromJsonObject(JSONObject response) throws Exception {
        response = response.getJSONObject("images");
        response = response.getJSONObject("low_resolution");
        return response.getString("url");
    }

    //
    //Methods & Interfaces by listeners
    //
    public interface OnDataChangedListener {
        public void onDataChanged();
    }

    public ArrayList<String> getImagesUrls() {
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
        retries++;
        if (retries > 5) {
            Log.e("Instagram", "Attempt " + retries + " getMoreData request " + error.getMessage());
            return;
        }
        Log.w("Instagram", "Attempt " + retries + " getMoreData request " + error.getMessage());
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
            for (int i = 0; i < length; i++) {
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
    public boolean isLoading() {
        return loading;
    }

}
