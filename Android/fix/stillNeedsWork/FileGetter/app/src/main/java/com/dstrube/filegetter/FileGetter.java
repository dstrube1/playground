package com.dstrube.filegetter;

import android.util.Log;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

//TODO Use this class

public class FileGetter {
    private String path = "";
    private static final String TAG = FileGetter.class.getSimpleName();

    public FileGetter() {
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getPath() {
        return path;
    }

    public boolean doesFileExist() {
        //check for file in Downloads
        //check for file in assets
        //check for file on network
        File file = new File(path);
        return file.exists();
    }

    public boolean isFileReadable() {
        File file = new File(path);
        return file.canRead();
    }

    public char[] getFirst10Chars() {
        File file = new File(path);
        char[] chars = new char[10];
        try {
            FileReader fileReader = new FileReader(file);
            int readInt = fileReader.read(chars,0,10);
        }catch (FileNotFoundException fnfe){
            Log.e(TAG,"FileNotFoundException in getFirst10Bytes");
        }catch (IOException ioe){
            Log.e(TAG,"IOException in getFirst10Bytes");
        }
        return chars;
    }

}
