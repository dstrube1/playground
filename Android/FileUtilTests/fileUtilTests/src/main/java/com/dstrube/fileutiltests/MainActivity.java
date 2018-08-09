package com.dstrube.fileutiltests;

import java.io.File;
import java.util.ArrayList;

import android.app.Activity;
import android.os.Bundle;
import android.os.Environment;
import android.widget.TextView;

public class MainActivity extends Activity {

    private TextView textView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textView = findViewById(R.id.textView);

//		ArrayList<String> allExternal = Utils.allExternal(10, null);
//		int count = 0;
//		for (String file : allExternal) {
//			count++;
//			textView.setText(textView.getText() + "\n" + file);
//			if (count >= 10)
//				break;
//		}
//		ArrayList<String> allInternal = Utils.allInternal(10, null);
//		for (String file : allInternal) {
//			textView.setText(textView.getText() + "\n" + file);
//		}

        ArrayList<String> allInternal0 =
                getFiles(10, Environment.getDataDirectory().toString(), null, null);
        for (String file : allInternal0) {
            textView.setText(textView.getText() + "\n" + file);
        }

        ArrayList<String> allExternal0 =
                getFiles(10, Environment.getExternalStorageDirectory().toString(), null,
                        null);
        for (String file : allExternal0) {
            textView.setText(textView.getText() + "\n" + file);
        }
    }

    private static ArrayList<String> getFiles(int top, String path,
                                              ArrayList<String> list, ArrayList<String> extensions) throws NullPointerException {
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
