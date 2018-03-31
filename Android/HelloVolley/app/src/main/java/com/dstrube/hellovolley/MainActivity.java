package com.dstrube.hellovolley;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;


import org.json.JSONObject;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

public class MainActivity extends Activity {
    //https://developer.android.com/training/volley/index.html

    private StringRequest stringRequest;
    private JsonObjectRequest jsObjRequest;

    private RequestQueue queue;

    public static final String TAG = MainActivity.class.getName();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        final TextView mTextView = findViewById(R.id.text);

        try {
            // Instantiate the RequestQueue.
            queue = Volley.newRequestQueue(this);
            /*
             * take 1: http://developer.android.com/training/volley/index.html
             */
            String url0 = "http://www.google.com";

            // Request a string response from the provided URL.
            stringRequest = new StringRequest(Request.Method.GET, url0,
                    new Response.Listener<String>() {
                        @Override
                        public void onResponse(String response) {
                            // Display the first 10 characters of the response
                            // string.
                            mTextView.setText(mTextView.getText() + "Response from string request is: "
                                    + response.substring(0, 10) + "\n");
                        }
                    }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    mTextView.setText(mTextView.getText() + "string request didn't work!" + "\n");
                }
            });
            // this is so that we can cancel any errant requests at onStop more
            // easily later
            stringRequest.setTag(TAG);

            // Add the request to the RequestQueue.
            queue.add(stringRequest);

            /*
             * take 2:
             */
            // String url =
            // "https://www.googleapis.com/customsearch/v1?key=AIzaSyBmSXUzVZBKQv9FJkTpZXn0dObKgEQOIFU&cx=014099860786446192319:t5mr0xnusiy&q=AndroidDev&alt=json&searchType=image";
            // String url =
            // "http://learnresfull-restcall.rhcloud.com/restaurent";
            String url = "http://api.androidhive.info/contacts/";
            jsObjRequest = new JsonObjectRequest(Request.Method.GET, url, null,
                    new Response.Listener<JSONObject>() {

                        @Override
                        public void onResponse(JSONObject response) {
                            mTextView.setText(mTextView.getText() + "Response from jsonObjectRequest => "
                                    + response.toString().substring(0,10) + "\n");
                            // findViewById(R.id.progressBar1).setVisibility(View.GONE);
                        }
                    }, new Response.ErrorListener() {

                @Override
                public void onErrorResponse(VolleyError error) {
                    mTextView.setText(mTextView.getText() + "jsonObjectRequest didn't work!" + "\n");
                }
            });

            jsObjRequest.setTag(TAG);
            // Add the request to the RequestQueue.
            queue.add(jsObjRequest);

        } catch (Exception e) {
            mTextView.setText(e.getMessage());
        }
    }

    @Override
    protected void onStop() {
        super.onStop();
        // one way to do clean up:
        // if (null != jsObjRequest) {
        // jsObjRequest.cancel();
        // }
        // if (null != stringRequest) {
        // stringRequest.cancel();
        // }
        // better way:
        if (null != queue) {
            queue.cancelAll(TAG);
        }
    }
}
