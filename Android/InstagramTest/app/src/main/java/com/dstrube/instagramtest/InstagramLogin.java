package com.dstrube.instagramtest;

import android.util.Base64;
import android.util.Log;
import android.webkit.WebView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;


public class InstagramLogin implements Response.ErrorListener, Response.Listener<String>{

    private static final String TAG = InstagramDataSource.class.getName();
    private RequestQueue requestQueue;
    private int retries;
    private String urlString;
    private boolean loading;
//    private OnDataChangedListener onDataChangedListener;
    private static InstagramLogin singleton;

    //
    //Singleton and construct section
    //
    public static InstagramLogin getInstance(final WebView myWebView) {
        if (singleton == null) {
            singleton = new InstagramLogin("http://colorofblah.blogspot.com/", myWebView);
        }
        return singleton;
    }

    private InstagramLogin(final String redirect_uri, final WebView myWebView) {//finalString tag){
        loading = true;
        retries = 0;
        requestQueue = App.getRequestQueue();
        login(redirect_uri, myWebView);
    }

    private void login(final String redirect_uri, final WebView myWebView) {
        final String client_id = "e7ce3f1a709543c7a03313e7f2e02bb4";

        urlString = "https://api.instagram.com/oauth/authorize/?client_id={client_id}&redirect_uri={redirect_uri}&response_type=code";
        urlString = urlString.replace("{redirect_uri}", redirect_uri);
        urlString = urlString.replace("{client_id}", client_id);

        // Request a string response from the provided URL.
        StringRequest stringRequest = new StringRequest(Request.Method.GET, urlString,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        // Display the first 50 characters of the response string.
                        Log.i(TAG, "Got response : " + response.substring(0, 50));
                        Toast.makeText(App.getContext(), "Got response from login request", Toast.LENGTH_SHORT).show();
                        String encodedHtml = Base64.encodeToString(response.getBytes(),
                                Base64.NO_PADDING);
                        myWebView.loadData(encodedHtml, "text/html", "base64");

                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.e(TAG, "Login request error: " + error.getMessage());
                Toast.makeText(App.getContext(), "Error received during login request", Toast.LENGTH_SHORT).show();
            }
        });

        requestQueue.add(stringRequest);
    }

    @Override
    public void onErrorResponse(VolleyError error) {
        Log.e(TAG, "Login request error: " + error.getMessage());
    }

    @Override
    public void onResponse(String response) {
        Log.i(TAG, "Got response : " + response.substring(0, 50));
    }
}
