package com.dstrube.filelistertest.model;

import android.annotation.SuppressLint;

import java.io.File;
import java.text.DecimalFormat;
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
        //TODO - this function has been added to FileUtils,
        //TODO but, for some unknown reason, the function is not available after re-compiling and
        //TODO re-adding the FileUtil.aar to this project

        final double bytesPerKB = 1024.0;
        final double bytesPerMB = bytesPerKB * bytesPerKB;
        final double bytesPerGB = bytesPerKB * bytesPerKB * bytesPerKB;

        final File file = new File(path);

        final double byteCount = file.length();
        final DecimalFormat df2 = new DecimalFormat(".##");
        final DecimalFormat df0 = new DecimalFormat("");
        if (byteCount >= bytesPerGB) {
            return "" + df2.format(byteCount / bytesPerGB) + " GB";
        }
        if (byteCount >= bytesPerMB) {
            return "" + df2.format(byteCount / bytesPerMB) + " MB";
        }
        if (byteCount >= bytesPerKB) {
            return "" + df2.format(byteCount / bytesPerKB) + " KB";
        }
        return "" + df0.format(byteCount) + " bytes";
    }
}
