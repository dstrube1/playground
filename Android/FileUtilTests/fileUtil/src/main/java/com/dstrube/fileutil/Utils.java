package com.dstrube.fileutil;

import java.io.File;
import java.util.ArrayList;

import android.os.Environment;

public class Utils {
    public static ArrayList<String> allInternal(ArrayList<String> extensions)
            throws NullPointerException {
        return allInternal(-1, extensions);
    }

    private static ArrayList<String> allInternal(int top,
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

    private static ArrayList<String> allExternal(int top,
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
}
