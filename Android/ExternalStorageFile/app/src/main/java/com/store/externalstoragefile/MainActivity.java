package com.store.externalstoragefile;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.Random;

import org.apache.http.util.ByteArrayBuffer;

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

public class MainActivity extends Activity {
	ImageView imageView;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		imageView = (ImageView) findViewById(R.id.imageView1);
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
		ByteArrayBuffer baf = new ByteArrayBuffer(5000);

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
				URL url = new URL(downloadUrl); // you can write here any link
				/* Open a connection to that URL. */
				URLConnection ucon = url.openConnection();

				/*
				 * Define InputStreams to read from the URLConnection.
				 */
				InputStream is = ucon.getInputStream();
				BufferedInputStream bis = new BufferedInputStream(is);

				/*
				 * Read bytes to the Buffer until there is nothing more to
				 * read(-1).
				 */

				int current = 0;

				while ((current = bis.read()) != -1) {
					baf.append((byte) current);
				}
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			Log.i("SaveWallpaperAsyncTask", "Entered at saveWallpaper method");
			String root = Environment.getExternalStorageDirectory().toString();
			File myDir = new File(root + "/saved_images");
			myDir.mkdirs();
			Random generator = new Random();
			int n = 10000;
			n = generator.nextInt(n);
			String fname = "Image-" + n + ".jpg";
			File file = new File(myDir, fname);
			
			System.out.println("File Absolute Path *** " + file.getAbsolutePath());
			filePath = file.getAbsolutePath();
			if (file.exists())
				file.delete();

			try {
				FileOutputStream out = new FileOutputStream(file);

				out.write(baf.toByteArray());

				out.flush();
				out.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	private void checkExternalMedia() {

		boolean mExternalStorageAvailable = false;
		boolean mExternalStorageWriteable = false;
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
