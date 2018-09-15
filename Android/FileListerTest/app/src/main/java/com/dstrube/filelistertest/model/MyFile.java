package com.dstrube.filelistertest.model;

import android.annotation.SuppressLint;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class MyFile {
    private String name;
    private String path;
    private boolean isDir;
    private String modifiedDate;

    //FileUtil fields
    private long size;

    public MyFile() {
        name = "";
        path = "";
        isDir = false;
        modifiedDate = "";
        size = 0;
    }

    public MyFile(String name, String path, boolean isDir, long modifiedDate, long size) {
        this.name = name;
        this.path = path;
        this.isDir = isDir;
        setModifiedDate(modifiedDate);
        this.size = size;
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
    public String getSize(){
        return "";
        //TODO
        /*
        private static string GetFileSize(double byteCount)
        {
            if (byteCount >= 1073741824.0)
                return $"{byteCount / 1073741824.0:##.##} GB";
            if (byteCount >= 1048576.0)
                return $"{byteCount / 1048576.0:##.##} MB";
            if (byteCount >= 1024.0)
                return $"{byteCount / 1024.0:##.##} KB";
            return $"{byteCount:##.##} bytes";
        }
        */
    }
}
