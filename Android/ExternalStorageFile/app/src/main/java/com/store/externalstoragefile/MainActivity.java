package com.store.externalstoragefile;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.Random;

//import org.apache.http.util.ByteArrayBuffer;
//replace with ByteArrayOutputStream
//https://stackoverflow.com/questions/32138739/bytearraybuffer-missing-in-sdk23

import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Environment;
import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;

public class MainActivity extends Activity {
    ImageView imageView;
    Context context;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        imageView = findViewById(R.id.imageView1);
    }

    @Override
    protected void onResume() {
        super.onResume();
        context = this;
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    public void downloadImage(View v) {
        new SaveWallpaperAsyncTask()
                .execute("http://www.theandroidinvasion.com/wp-content/uploads/2012/05/Google_Android.png");
    }

    private class SaveWallpaperAsyncTask extends
            AsyncTask<String, Void, String> {
        private String downloadUrl;
        private String filePath;
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
//		ByteArrayBuffer baf = new ByteArrayBuffer(5000);

        @Override
        protected String doInBackground(String... params) {
            downloadUrl = params[0];
            String URL = "path/of/remote/image";
            Log.i("SaveWallpaperAsyncTask", "SinglePageImageURL = " + URL);

            checkExternalMedia();
            saveWallpaper(URL);
            return "Executed";
        }

        @Override
        protected void onPostExecute(String result) {
            Bitmap bitmap = BitmapFactory.decodeFile(filePath);
            imageView.setImageBitmap(bitmap);
        }

        @Override
        protected void onPreExecute() {
        }

        @Override
        protected void onProgressUpdate(Void... values) {
        }

        private void saveWallpaper(String urlString) {

            try {

                /* First Download A image file from internet */
                final URL url = new URL(downloadUrl); // you can write here any link
                /* Open a connection to that URL. */
                final URLConnection ucon = url.openConnection();

                /*
                 * Define InputStreams to read from the URLConnection.
                 */
                final InputStream is = ucon.getInputStream();
                final BufferedInputStream bis = new BufferedInputStream(is);

                /*
                 * Read bytes to the Buffer until there is nothing more to
                 * read(-1).
                 */

//				int current = 0;
//
//				while ((current = bis.read()) != -1) {
//					baf.append((byte) current);
//				}
                //We create an array of bytes
                final byte[] data = new byte[50];
                int current = 0;

                while ((current = bis.read(data, 0, data.length)) != -1) {
                    byteArrayOutputStream.write(data, 0, current);
                }

            } catch (IOException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }

            Log.i("SaveWallpaperAsyncTask", "Entered at saveWallpaper method");
            final String root = Environment.getExternalStorageDirectory().toString();
            final File myDir = new File(root + "/saved_images");
            if (!myDir.mkdirs()) {
                Toast.makeText(context, "Make dir failed", Toast.LENGTH_SHORT).show();
                return;
            }
            final Random generator = new Random();
            int n = 10000;
            n = generator.nextInt(n);
            final String fname = "Image-" + n + ".jpg";
            final File file = new File(myDir, fname);

            System.out.println("File Absolute Path *** " + file.getAbsolutePath());
            filePath = file.getAbsolutePath();
            if (file.exists())
                if (!file.delete()) {
                    Toast.makeText(context, "File delete failed", Toast.LENGTH_SHORT).show();
                    return;
                }

            try {
                FileOutputStream out = new FileOutputStream(file);

//				out.write(baf.toByteArray());
                out.write(byteArrayOutputStream.toByteArray());

                out.flush();
                out.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    private void checkExternalMedia() {

        boolean mExternalStorageAvailable;
        boolean mExternalStorageWriteable;
        String state = Environment.getExternalStorageState();

        if (Environment.MEDIA_MOUNTED.equals(state)) {
            // Can read and write the media
            mExternalStorageAvailable = mExternalStorageWriteable = true;
        } else if (Environment.MEDIA_MOUNTED_READ_ONLY.equals(state)) {
            // Can only read the media
            mExternalStorageAvailable = true;
            mExternalStorageWriteable = false;
        } else {
            // Can't read or write
            mExternalStorageAvailable = mExternalStorageWriteable = false;
        }

        Log.i("SDCARD SAMPLE", "External Media: readable="
                + mExternalStorageAvailable + " writable="
                + mExternalStorageWriteable);
    }

}
