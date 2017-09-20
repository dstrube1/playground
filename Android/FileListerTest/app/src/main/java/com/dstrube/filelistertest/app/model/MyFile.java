package com.dstrube.filelistertest.app.model;

import android.annotation.SuppressLint;

import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created by unbounded on 6/9/2014.
 */
public class MyFile {
    private String name;
    private String path;
    private boolean isDir;
    private String modifiedDate;

    public MyFile() {
        name = "";
        path = "";
        isDir = false;
        modifiedDate = "";
    }

    public MyFile(String name, String path, boolean isDir, long modifiedDate) {
        this.name = name;
        this.path = path;
        this.isDir = isDir;
        setModifiedDate(modifiedDate);
    }

    @SuppressLint("SimpleDateFormat")
    private void setModifiedDate(long modifiedDate) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(modifiedDate); //long time
        this.modifiedDate = dateFormat.format(calendar.getTime());//string time

    }
    public String getName(){
        return name;
    }
    public String getPath(){
        return path;
    }
    public boolean getIsDir(){
        return isDir;
    }
    public String getModifiedDate(){
        return modifiedDate;
    }
}
