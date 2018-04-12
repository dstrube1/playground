package com.dstrube.myapplication;

import android.util.Log;

/**
 * Created by dstrubex on 6/29/15.
 */
public class MyRunnable implements Runnable {

    private String mName;

    public MyRunnable(String name) {
        mName = name;
    }

    @Override
    public void run() {

        int countDown = 10;

        while (countDown-- > 0) {
            Log.i("MyRunnable", "Running " + mName + " " + countDown);

            MyLocalRunnable myLocalRunnable = new MyLocalRunnable("yo " + countDown);
            new Thread(myLocalRunnable).start();
        }
    }

    private class MyLocalRunnable implements Runnable {
        private String mName;

        public MyLocalRunnable(String name) {
            mName = name;
        }

        @Override
        public void run() {
            Log.i("MyLocalRunnable", "Running " + mName);
        }
    }
}
