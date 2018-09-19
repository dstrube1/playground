package com.dstrube.fileutil;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import android.os.Environment;
import android.util.Log;

public class Utils {
    private static final String TAG = "FileUtil";
    public static ArrayList<String> allInternal(ArrayList<String> extensions)
            throws NullPointerException {
        return allInternal(-1, extensions);
    }

    public static ArrayList<String> allInternal(int top,
                                                ArrayList<String> extensions) throws NullPointerException {

        ArrayList<String> list = new ArrayList<>();
        list = getFiles(top, Environment.getDataDirectory().toString(), list,
                extensions);
        return list;
    }

    public static ArrayList<String> allExternal(ArrayList<String> extensions)
            throws NullPointerException {
        return allExternal(-1, extensions);
    }

    public static ArrayList<String> allExternal(int top,
                                                ArrayList<String> extensions) throws NullPointerException {
        ArrayList<String> list = new ArrayList<>();
        list = getFiles(top, Environment.getExternalStorageDirectory()
                .toString(), list, extensions);
        return list;
    }

    private static ArrayList<String> getFiles(int top, String path,
                                              ArrayList<String> list, ArrayList<String> extensions)
            throws NullPointerException {
        if (list == null) {
            list = new ArrayList<>();
        }
        if (top == list.size()) {
            return list;
        }
        try {
            // System.out.println("testing "+path);
            File dir = new File(path);
            // if it's null, this won't be a happy ride.
            // if it wants to be left alone, leave it alone
            if (!dir.isHidden()) {
                for (File file : dir.listFiles()) {
                    if (top == list.size()) {
                        return list;
                    }
                    if (file.isDirectory()) {
                        // get what all is inside this folder
                        getFiles(top, file.getPath(), list, extensions);
                        // then move on, so as to not risk adding this
                        // folder to the list of photos.
                        // (I've seen folders in the Android filesystem with
                        // names like "blah.jpg".)
                        continue;
                    }
                    String fileName = file.getName().toLowerCase();
                    if (extensions != null && extensions.size() > 0) {
                        for (String extension : extensions) {
                            if (fileName.endsWith(extension)) {
                                list.add(file.getAbsolutePath());
                            }
                        }
                    } else {
                        list.add(file.getAbsolutePath());
                    }
                }
            }
        } catch (NullPointerException e) {
            System.out.println("NullPointerException at " + path);
        } catch (Exception e) {
            System.out.println("Unexpected Exception at " + path);
        }
        return list;
    }

    public static String getFileSize(String path) {
        if (path == null || path.length() == 0) {
            return "-";
        }

        final double bytesPerKB = 1024.0;
        final double bytesPerMB = bytesPerKB * bytesPerKB;
        final double bytesPerGB = bytesPerKB * bytesPerKB * bytesPerKB;

        File file = new File(path);

        double byteCount = file.length();
        if (byteCount >= bytesPerGB)
            return "" + (byteCount / bytesPerGB) + " GB";
        if (byteCount >= bytesPerMB)
            return "" + (byteCount / bytesPerMB) + " MB";
        if (byteCount >= bytesPerKB)
            return "" + (byteCount / bytesPerKB) + " KB";
        return "" + byteCount + " bytes";
    }

    public static boolean doesFileExist(String path) {
        //check for file in Downloads
        //check for file in assets
        //check for file on network
        File file = new File(path);
        return file.exists();
    }

    public boolean isFileReadable(String path) {
        File file = new File(path);
        return file.canRead();
    }

    public char[] getFirst10Chars(String path) {
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
