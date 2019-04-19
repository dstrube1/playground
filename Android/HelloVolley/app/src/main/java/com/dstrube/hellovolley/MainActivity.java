package com.dstrube.hellovolley;

import android.app.Activity;
import android.arch.lifecycle.Lifecycle;
import android.arch.lifecycle.LifecycleOwner;
import android.arch.lifecycle.Observer;
import android.arch.lifecycle.ViewModelProviders;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.view.View;
import android.widget.TextView;


import org.json.JSONObject;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.dstrube.hellovolley.Model.Contact;
import com.dstrube.hellovolley.util.MyLogger;

import java.util.HashMap;
import java.util.Map;

public class MainActivity extends Activity {
    //https://developer.android.com/training/volley/index.html

    private RequestQueue queue;

    public static final String TAG = MainActivity.class.getName();
    private UserModel userModel;
    private TextView mTextView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        MyLogger.Log(MyLogger.Level.INFO, "Constructor");

        setContentView(R.layout.activity_main);

        userModel = new UserModel();

//        userModel.userLiveData.observe(new LifecycleOwner() {
//            @NonNull
//            @Override
//            public Lifecycle getLifecycle() {
//                MyLogger.Log(MyLogger.Level.INFO, "LifecycleOwner : getLifecycle");
//                return null;
//            }
//        }, new Observer<Contact>() {
//            @Override
//            public void onChanged(@Nullable Contact contact) {
//                MyLogger.Log(MyLogger.Level.INFO, "Observer : onChanged");
//            }
//        });

        mTextView = findViewById(R.id.text);


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

        // better way to do clean up:
        if (null != queue) {
            queue.cancelAll(TAG);
        }
    }

    public void buttonClick(View view) {
        try {
            // Instantiate the RequestQueue.
            queue = Volley.newRequestQueue(this);
            /*
             * take 1: http://developer.android.com/training/volley/index.html
             */
            String url0 = "http://www.google.com";

            // Request a string response from the provided URL.
            StringRequest stringRequest = new StringRequest(Request.Method.GET, url0,
                    new Response.Listener<String>() {
                        @Override
                        public void onResponse(String response) {
                            // Display the first 10 characters of the response
                            // string.
                            String text = mTextView.getText() + "Response from string request is: "
                                    + response.substring(0, 10) + "\n";
                            mTextView.setText(text);
                        }
                    }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    String text = mTextView.getText() + " string request didn't work: "
                            + "\n" + error.getMessage();
                    mTextView.setText(text);
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
            String url = "https://api.androidhive.info/contacts/";
            /* OLD: */
            JsonObjectRequest jsObjRequest = new JsonObjectRequest(Request.Method.GET, url, null,
                    new Response.Listener<JSONObject>() {

                        @Override
                        public void onResponse(JSONObject response) {
                            String text = mTextView.getText() + "Response from jsonObjectRequest => "
                                    + response.toString().substring(0, 10) + "\n";
                            mTextView.setText(text);
                            // findViewById(R.id.progressBar1).setVisibility(View.GONE);
                        }
                    }, new Response.ErrorListener() {

                @Override
                public void onErrorResponse(VolleyError error) {
                    String text = mTextView.getText() + " jsonObjectRequest didn't work!" + "\n" + error.getCause();
                    mTextView.setText(text);
                }
            });
            jsObjRequest.setTag(TAG);

            // Add the request to the RequestQueue.
            queue.add(jsObjRequest);
            /**/

            //NEW:
            /*
            final Map<String, String> params = new HashMap<>();
            CustomRequest jsObjRequest = new CustomRequest(//Request.Method.POST,
                    url, null,
                    new Response.Listener<JSONObject>() {
                        @Override
                        public void onResponse(JSONObject response) {
                            String text = mTextView.getText() + "Response from jsonObjectRequest => "
                                + response.toString().substring(0, 10) + "\n";
                            mTextView.setText(text);
                            // findViewById(R.id.progressBar1).setVisibility(View.GONE);
                        }
                    }, new Response.ErrorListener() {
                           @Override
                           public void onErrorResponse(VolleyError error) {
                               String text = mTextView.getText() + " jsonObjectRequest didn't work!" + "\n" + error.getCause();
                               mTextView.setText(text);
                            }
                    });
            jsObjRequest.setTag(TAG);
            queue.add(jsObjRequest);
                    */

        } catch (Exception e) {
            mTextView.setText(e.getMessage());
        }
    }
}
