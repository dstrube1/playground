package com.dstrube.filelistertest.app.controller;

import android.os.Environment;
//this is not the right fragment import:
//import android.app.Fragment;
import android.support.v4.app.Fragment;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.dstrube.filelistertest.app.R;
import com.dstrube.filelistertest.app.model.MyFile;
import com.dstrube.filelistertest.app.view.CustomAdapter;

import java.io.File;
import java.util.ArrayList;


public class MainActivity extends ActionBarActivity {

    ArrayList<MyFile> myFiles;
    ListView listView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.container, new PlaceholderFragment()).commit();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();

        String root = Environment.getExternalStorageDirectory().toString();

        // String state = Environment.getExternalStorageState();
        // Environment.MEDIA_MOUNTED_READ_ONLY or Environment.MEDIA_MOUNTED
        // (writable)
        // Toast.makeText(getApplicationContext(), "root = " + root,
        // Toast.LENGTH_LONG).show();

        myFiles = new ArrayList<MyFile>();
        populateMyFiles(root);
        if (myFiles.size() == 0){
            populateMyFiles(Environment.getDataDirectory().toString());
        }
        if (myFiles.size() == 0){
            populateMyFiles(Environment.getRootDirectory().toString());
        }
        listView = (ListView)findViewById(R.id.listView);
        CustomAdapter adapter = new CustomAdapter(this, myFiles);
        listView.setAdapter(adapter);

    }

    private void populateMyFiles(String path) {
        try {
            File dir = new File(path);
            if (dir != null) { // if it's null, this won't be a happy ride.
                if (!dir.isHidden()) { // if it wants to be left alone, leave it
                    // alone
                    for (File file : dir.listFiles()) {
                        if (file.isDirectory()) {
                            populateMyFiles(file.getPath());
                        }
//                        if (file.isDirectory()){
//                            continue;
//                        }
//                        if (file.getPath().endsWith(".apk") || file.getPath().endsWith(".odex") ){
//                            continue;
//                        }
                        if (file.getPath().endsWith(".jpg") || file.getPath().endsWith(".png") ) {

                            System.out.println("file: " + file.getPath());
                            MyFile myFile = new MyFile(file.getName(),
                                    file.getAbsolutePath(), file.isDirectory(),
                                    file.lastModified());
                            myFiles.add(myFile);
                        }
                    }
                }
            }
        } catch (NullPointerException e) {
            System.out.println("NullPointerException at " + path);
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

        public PlaceholderFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                                 Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_main, container,
                    false);
            return rootView;
        }
    }
}
