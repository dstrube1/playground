package com.dstrube.currentweather.service;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class JSONParser {
    private static final String TAG = JSONParser.class.getName();

    //Constructor
    public JSONParser() {
    }

    //Input: a URL
    //Output: JSONObject
    public JSONObject getJSONFromUrl(final String urlParam, final Context context) {
        //old:
        //getClass().getEnclosingMethod().getName()
        //new:
        final StackTraceElement[] trace0 = new Exception().getStackTrace();
        final String methodName = trace0[0].getMethodName();

        final ConnectivityManager connMgr = (ConnectivityManager)
                context.getSystemService(Context.CONNECTIVITY_SERVICE);
        final NetworkInfo networkInfo;
        if (connMgr != null) {
            networkInfo = connMgr.getActiveNetworkInfo();
            if (networkInfo == null || !networkInfo.isConnected()) {
                Log.e(TAG, methodName + ": No network connectivity");
                return null;
            }
        }else {
            Log.e(TAG, methodName + ": Null ConnectivityManager");
            return null;
        }

        JSONObject jsonObject = null;
        String jsonString = "";

        // Making HTTP request
        try {
            final URL url = new URL(urlParam);
            final HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            try {
                final InputStream in = new BufferedInputStream(urlConnection.getInputStream());
                jsonString = readStream(in);
            } finally {
                urlConnection.disconnect();
            }
        } catch (MalformedURLException e0) {
            Log.e(TAG, methodName + ": MalformedURLException");
        } catch (IOException e1) {
            Log.e(TAG, methodName + ": IOException");
        }

        // try parse the string to a JSON object
        try {
            jsonObject = new JSONObject(jsonString);
        } catch (JSONException e) {
            Log.e(TAG, methodName + ": JSONException");
        }

        return jsonObject;
    }

    private String readStream(final InputStream in) {
        //old:
        //getClass().getEnclosingMethod().getName()
        //new:
        final StackTraceElement[] trace0 = new Exception().getStackTrace();
        final String methodName = trace0[0].getMethodName();

        BufferedReader reader = null;
        final StringBuilder response = new StringBuilder();
        try {
            reader = new BufferedReader(new InputStreamReader(in));
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
        } catch (IOException e) {
            Log.e(TAG, methodName + ": IOException while reading");
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    Log.e(TAG, methodName + ": IOException while closing");
                }
            }
        }
        return response.toString();
    }

}
