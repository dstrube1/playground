package com.dstrube.asynctaskloadertest;

import android.app.Activity;
import android.content.AsyncTaskLoader;
import android.content.Context;
import android.content.res.Resources;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.Arrays;

public class MainActivity extends Activity {

    public ListView listView;
    ArrayList<String> list = new ArrayList<>();

    ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    protected void onResume() {
        super.onResume();
        listView = findViewById(R.id.listView1);
//		adapter = new ArrayAdapter<String>(MainActivity.this,
//				android.R.layout.simple_list_item_1, android.R.id.text1, list);
//
//		listView.setAdapter(adapter);
    }

    public void Click1(View v) {
        MyObject object = new MyObject(getApplicationContext(), listView);
        new MyAsyncTask().execute(object);
    }

    public void Click2(View v){
        MyAsyncTaskLoader loader = new MyAsyncTaskLoader(getApplicationContext());
        loader.forceLoad();
    }

    private class MyAsyncTask extends
            AsyncTask<MyObject, Void, ArrayList<String>> {
        @Override
        protected ArrayList<String> doInBackground(MyObject... params) {
            Context ctx = params[0].context;

            Resources res = ctx.getResources();

            final String[] days = res.getStringArray(R.array.days);

            list = new ArrayList<>();

            list.addAll(Arrays.asList(days));

            return list;
        }

        @Override
        protected void onPostExecute(ArrayList<String> result) {
            adapter = new ArrayAdapter<>(MainActivity.this,
                    android.R.layout.simple_list_item_1, android.R.id.text1,
                    list);

            listView.setAdapter(adapter);
            // adapter.notifyDataSetChanged();
        }

    }

    private class MyAsyncTaskLoader extends AsyncTaskLoader<Object> {

        public MyAsyncTaskLoader(Context context) {
            super(context);
        }

        @Override
        protected void onStartLoading() {
            super.onStartLoading();
        }
        @Override
        protected void onStopLoading() {
            super.onStopLoading();
        }
        @Override
        protected void onReset() {
            super.onReset();
        }

        @Override
        public Object loadInBackground() {
            final String[] days = getResources().getStringArray(R.array.days);
            list = new ArrayList<>();

            for (int i = days.length-1; i >=0 ; i--) {
                list.add(days[i]);
            }
            adapter = new ArrayAdapter<>(MainActivity.this,
                    android.R.layout.simple_list_item_1, android.R.id.text1,
                    list);

            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    listView.setAdapter(adapter);
                }
            });

            return null;
        }
    }



}
