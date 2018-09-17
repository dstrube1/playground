package com.dstrube.filelistertest.controller;

import android.app.Activity;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.widget.ListView;

import com.dstrube.filelistertest.R;
import com.dstrube.filelistertest.model.MyFile;
import com.dstrube.filelistertest.view.CustomAdapter;

import com.dstrube.fileutil.*;

import java.io.File;
import java.util.ArrayList;

public class MainActivity extends Activity {

    private static final String TAG = MainActivity.class.getName();

    ArrayList<MyFile> myFiles;
    ListView listView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    private void populateMyFiles(String path) {
        try {
            File dir = new File(path);
            if (!dir.isHidden()) { // if it wants to be left alone, leave it alone
                File[] files = dir.listFiles();
                if (files == null) {
                    Log.e(TAG, "List of files is null");
                    return;
                }
                for (File file : files) {
                    if (file.isDirectory()) {
                        populateMyFiles(file.getPath());
                    }
//                        if (file.isDirectory()){
//                            continue;
//                        }
                        if (file.getPath().endsWith(".apk")
                                || file.getPath().endsWith(".odex")
                                || file.getPath().endsWith(".so")
                                || !file.getPath().contains(".")){
                            continue;
                        }
//                    if (file.getPath().endsWith(".jpg") || file.getPath().endsWith(".png")) {

                        Log.d(TAG, "file: " + file.getPath());
                        MyFile myFile = new MyFile(file.getName(),
                                file.getAbsolutePath(), file.isDirectory(),
                                file.lastModified(),file.length());
                        myFiles.add(myFile);
//                    }
                }
            }
        } catch (NullPointerException e) {
            Log.e(TAG, "NullPointerException at " + path);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();

        final String[] roots = {
                Environment.getExternalStorageDirectory().toString(),   //list = null
                Environment.getDataDirectory().toString(),              //list = null
                Environment.getDownloadCacheDirectory().toString(),     //list = null
                Environment.getRootDirectory().toString(),
//                Environment.getExternalStoragePublicDirectory("type?").toString()
        };
        final ArrayList<String>extensions = new ArrayList<>();
        extensions.add(".sh");
        final ArrayList<String> rootsExt = Utils.allExternal(extensions);
        final ArrayList<String> rootsInt = Utils.allInternal(extensions);

        // String state = Environment.getExternalStorageState();
        // Environment.MEDIA_MOUNTED_READ_ONLY or Environment.MEDIA_MOUNTED
        // (writable)
        // Toast.makeText(getApplicationContext(), "root = " + root,
        // Toast.LENGTH_LONG).show();

        myFiles = new ArrayList<>();
        for (String root : roots) {
            populateMyFiles(root);
        }
        listView = findViewById(R.id.listView);
        CustomAdapter adapter = new CustomAdapter(this, myFiles);
        listView.setAdapter(adapter);

    }


}
