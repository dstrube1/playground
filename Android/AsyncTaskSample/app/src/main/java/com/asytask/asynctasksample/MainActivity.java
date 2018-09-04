package com.asytask.asynctasksample;

import java.util.Random;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {

    public static final String TAG = MainActivity.class.getSimpleName();

    public static final long PASSWORD = 42; //3542; //12345;

    TextView tv1;
    TextView tv2;
    Button btn;
    Context context;

    int progressIncrement = 10;

    ProgressDialog progressDialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tv1 = findViewById(R.id.textView1);
        tv2 = findViewById(R.id.textView2);
        btn = findViewById(R.id.button1);
        context = this;
    }

    public void setAttempt(View v) {

        final long PUBLISH_RATE = 1000;
        final long RANGE = 10000;

        new PasswordGuesserTask().execute(RANGE, PUBLISH_RATE);

    }


    public void testProgress(View v) {

        progressDialog = new ProgressDialog(v.getContext());

        new ProgressTaskTest().execute();

    }

    private void displayProgress(String message) {
        tv1.setText(message);
    }

    private void displayToast(String message) {
        Toast.makeText(context, message, Toast.LENGTH_LONG).show();
        progressDialog.cancel();
    }

    private void displayAnswer(String msg) {
        tv2.setText(msg);
    }

    /*
     *  1. Long:  type of reference(s) pass to the doInBackground()
     *  2. String: Type of reference pass to onProgressUpdate()
     *  3. Long: Type of reference returned by doInBackground()
     *
     */

    private class PasswordGuesserTask extends AsyncTask<Long, String, Long> {
        //1: params type: what you pass to the AsyncTask
        //2: progress type: passed to onProgressUpdate(), if applicable
        //3: result type: what returns doInBackground()

        @Override
        protected Long doInBackground(Long... params) {
            long count = 0;
            long guess = 0;
            Random rand = new Random();//0); //was unseeded; seeded, 3542 comes up fast
            while (guess != PASSWORD) {
                Log.d("Tag", "THERERERER " + "-- " + guess);
                guess = Math.abs(rand.nextLong()) % params[0];
                count++;
                if (count % params[1] == 0) {
                    publishProgress("Guessed this many times: " + count, "Last Guess # " + guess);
                }
            }
            return guess;
        }


        @Override
        protected void onProgressUpdate(String... values) {
            super.onProgressUpdate(values);
            displayProgress(values[0]);
            displayAnswer(values[1]);
        }


        @Override
        protected void onPostExecute(Long result) {
            super.onPostExecute(result);
            displayAnswer(tv1.getText().toString());
            displayProgress("DONE!!   Found " + result);
        }

    }


    /*
     *  1. Long:  type of reference(s) pass to the doInBackgroung()
     *  2. String: Type of reference pass to onProgressUpdate()
     *  3. Long: Type of reference returned by doInBackground()
     *
     */
    private class ProgressTaskTest extends AsyncTask<Context, Integer, String> {

        @Override
        protected void onPreExecute() {

            progressDialog.setCancelable(true);
            progressDialog.setMessage("Download in progress..");
            progressDialog.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
            progressDialog.setProgress(0);
            progressDialog.setMax(100);
            progressDialog.show();


        }

        @Override
        protected String doInBackground(Context... params) {

            for (int i = 0; i < 100; i += progressIncrement) {
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {

                    e.printStackTrace();
                }

                publishProgress(progressIncrement);
            }

            return "Download Completed";

        }


        @Override
        protected void onProgressUpdate(Integer... values) {
            super.onProgressUpdate(values);
            progressDialog.incrementProgressBy(progressIncrement);
        }


        @Override
        protected void onPostExecute(String result) {
            displayToast(result);
        }

    }

}
