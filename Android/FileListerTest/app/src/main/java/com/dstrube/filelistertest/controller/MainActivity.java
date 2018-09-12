package com.dstrube.filelistertest.controller;

import android.app.Activity;
import android.os.Bundle;
import android.os.Environment;
import android.widget.ListView;

import com.dstrube.filelistertest.R;
import com.dstrube.filelistertest.model.MyFile;
import com.dstrube.filelistertest.view.CustomAdapter;

import java.io.File;
import java.util.ArrayList;

public class MainActivity extends Activity {

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
                    if (file.getPath().endsWith(".jpg") || file.getPath().endsWith(".png")) {

                        System.out.println("file: " + file.getPath());
                        MyFile myFile = new MyFile(file.getName(),
                                file.getAbsolutePath(), file.isDirectory(),
                                file.lastModified());
                        myFiles.add(myFile);
                    }
                }
            }
        } catch (NullPointerException e) {
            System.out.println("NullPointerException at " + path);
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

        myFiles = new ArrayList<>();
        populateMyFiles(root);
        if (myFiles.size() == 0) {
            populateMyFiles(Environment.getDataDirectory().toString());
        }
        if (myFiles.size() == 0) {
            populateMyFiles(Environment.getRootDirectory().toString());
        }
        listView = findViewById(R.id.listView);
        CustomAdapter adapter = new CustomAdapter(this, myFiles);
        listView.setAdapter(adapter);

    }


}
