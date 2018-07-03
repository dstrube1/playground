package com.dstrube.payrange.util;

import android.app.Activity;
import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.util.Log;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.dstrube.payrange.controller.MainActivity;
import com.dstrube.payrange.view.SplashActivity;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.ref.WeakReference;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Random;

import javax.net.ssl.HttpsURLConnection;

/**
 *
 */
public class Randomizer {

    //static context = memory leak
//    private static Context mContext;
    // Weak references will still allow the Activity to be garbage-collected
    private static WeakReference<Activity> weakActivity;

    private static final String RANDOMS_URL_BEGIN = "https://www.random.org/integers/?num=";
    private static final String RANDOMS_URL_END = "&min=30&max=100&col=1&base=10&format=plain&rnd=new";
    private static ArrayList<Integer> mRandoms;

    ///private constructor - this class is not initializable. only 1 public static method
    private Randomizer() {
    }

    public static void randomize(Activity myActivity){
        weakActivity = new WeakReference<>(myActivity);
        mRandoms = new ArrayList<>();
        new GetRandomTask().execute();
    }

    private static class GetRandomTask extends AsyncTask<Void, Void, Integer> {

        private final String TAG = GetRandomTask.class.getSimpleName();

        @Override
        protected Integer doInBackground(final Void... params) {
            Random random = new Random();
            final int backgroundGetRandom = random.nextInt(5) + 5;

            final Activity activity = weakActivity.get();
            if (activity == null
                    || activity.isFinishing()
                    || activity.isDestroyed()) {
                // activity is no longer valid, don't do anything!
                return null;
            }

            //Make sure we have connectivity
            ConnectivityManager connMgr =
                    (ConnectivityManager) activity.getSystemService(Context.CONNECTIVITY_SERVICE);
            NetworkInfo activeInfo = connMgr.getActiveNetworkInfo();
            if (activeInfo != null && activeInfo.isConnected()) {

                RequestQueue queue = Volley.newRequestQueue(activity);
                // Request a string response from the provided URL.
                StringRequest stringRequest = new StringRequest(Request.Method.GET, RANDOMS_URL_BEGIN +
                        (MainActivity.NUMBER_OF_BLE_SIGNALS * backgroundGetRandom) + RANDOMS_URL_END,
                        new Response.Listener<String>() {
                            @Override
                            public void onResponse(final String response) {
                                boolean firstIntSet = false;
                                int firstInt = 0;
                                for (String inputLine : response.split("\n")) {
                                    if (!firstIntSet) {
                                        firstInt = Integer.parseInt(inputLine);
                                        firstIntSet = true;
                                    }
                                    mRandoms.add(Integer.parseInt(inputLine));
                                }
                                Log.i(TAG, "First int = " + firstInt);
                                Toast.makeText(activity, "First int = " + firstInt, Toast.LENGTH_LONG).show();
                                MainActivity.setMachines(backgroundGetRandom, mRandoms);

                            }
                        }, new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(final VolleyError error) {
                        Log.e(TAG, "VolleyError");
                        Toast.makeText(activity, "VolleyError", Toast.LENGTH_SHORT).show();
                    }
                });
                // Add the request to the RequestQueue.
                queue.add(stringRequest);

            } else {
                Log.e(TAG, "No connectivity.");
            }

            return backgroundGetRandom;
        }

        /**
         * if we want to use JSON and an API key
         *
         * @return background random int
         */
        private int jsonMethod() {
            int backgroundGetRandom = 0;

            //https://api.random.org/json-rpc/1/
            final String KEY = "364d4d65-c4bb-4fc2-9316-f6aed33838d2";
            final String INVOKE_URL = "https://api.random.org/json-rpc/1/invoke";
            final String METHOD_NAME = "generateSignedIntegers";
            final int MIN = 5;
            final int MAX = 10;

            try {
                JSONObject jsonIn = new JSONObject("{\"jsonrpc\":\"2.0\",\"method\":\"" +
                        METHOD_NAME + "\",\"params\":{\"apiKey\":\"" + KEY + "\",\"n\":1," +
                        "\"min\":" + MIN + ",\"max\":" + MAX + "}, \"id\":0}");

                HttpsURLConnection con = (HttpsURLConnection) new URL(INVOKE_URL).openConnection();
                con.setConnectTimeout(SplashActivity.SPLASH_TIME_OUT);

                // headers
                con.setRequestMethod("POST");
                con.setRequestProperty("Content-Type", "application/json");

                // send JSON
                con.setDoOutput(true);
                DataOutputStream dos = new DataOutputStream(con.getOutputStream());
                dos.writeBytes(jsonIn.toString());
                dos.flush();
                dos.close();

                // check response
                int responseCode = con.getResponseCode();

                // return JSON...
                if (responseCode == HttpsURLConnection.HTTP_OK) {
                    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                    String inputLine;
                    StringBuilder response = new StringBuilder();

                    while ((inputLine = in.readLine()) != null) {
                        response.append(inputLine);
                    }
                    in.close();

                    JSONObject jsonOut = new JSONObject(response.toString());

                    backgroundGetRandom = jsonOut.getJSONObject("result").getJSONObject("random").getJSONArray("data").getInt(0);
                    Log.i(TAG, "random = " + backgroundGetRandom);

                    final int requestsLeft = jsonOut.getJSONObject("result").getInt("requestsLeft");
                    Log.i(TAG, requestsLeft + " requests left!");

                    if (requestsLeft < 100) {
                        Log.w(TAG, "Warning, only " + requestsLeft + " requests left!");
                    }

                } else {
                    Log.e(TAG, "NOT HTTP_OK");
                }

            } catch (MalformedURLException mue) {
                Log.e(TAG, "MalformedURLException 1");
            } catch (IOException ioe) {
                Log.e(TAG, "IOException 1");
            } catch (JSONException je) {
                Log.e(TAG, "JSONException 1");
            }

            return backgroundGetRandom;
        }

        /**
         * If we want to use a non-volley method of getting randoms from random.org
         *
         * @param backgroundGetRandom
         */
        private void nonVolleyMethod(final int backgroundGetRandom) {
            try {
                HttpsURLConnection con = (HttpsURLConnection) new URL(RANDOMS_URL_BEGIN +
                        (MainActivity.NUMBER_OF_BLE_SIGNALS * backgroundGetRandom) + RANDOMS_URL_END).openConnection();
                con.setConnectTimeout(SplashActivity.SPLASH_TIME_OUT);

                // headers
                con.setRequestMethod("GET");
                con.setRequestProperty("Content-Type", "text/html");

                // check response
                int responseCode = con.getResponseCode();
                if (responseCode == HttpsURLConnection.HTTP_OK) {
                    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                    String inputLine;
                    StringBuffer response = new StringBuffer();

                    while ((inputLine = in.readLine()) != null) {
                        mRandoms.add(Integer.parseInt(inputLine));
                        response.append(inputLine);
                    }
                    in.close();

                    response.toString();
                } else {
                    Log.e(TAG, "NOT HTTP_OK");
                }
            } catch (MalformedURLException mue) {
                Log.e(TAG, "MalformedURLException 2");
            } catch (IOException ioe) {
                Log.e(TAG, "IOException 2");
            }
        }

        @Override
        protected void onPostExecute(final Integer postExecuteRandom) {
            if (postExecuteRandom <= 0) {
                Log.e(TAG, "Invalid random value");

                final Activity activity = weakActivity.get();
                if (activity == null
                        || activity.isFinishing()
                        || activity.isDestroyed()) {
                    // activity is no longer valid, don't do anything!
                    return;
                }

                Toast.makeText(activity, "Invalid random value: " + postExecuteRandom, Toast.LENGTH_LONG).show();
            }
        }
    }
}
