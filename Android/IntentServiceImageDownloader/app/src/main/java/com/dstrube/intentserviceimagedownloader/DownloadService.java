package com.dstrube.intentserviceimagedownloader;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
//import java.net.MalformedURLException;
//import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

import android.app.Activity;
import android.app.IntentService;
//import android.app.ProgressDialog;
//import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
//import android.graphics.Bitmap;
//import android.graphics.BitmapFactory;
import android.os.Environment;
//import android.os.Handler;
import android.os.ResultReceiver;

public class DownloadService extends IntentService {

	private int result = Activity.RESULT_CANCELED;
	public static final String URL = "urlpath";
	public static final String FILENAME = "filename";
	public static final String FILEPATH = "filepath";
	public static final String RESULT = "result";
	public static final String NOTIFICATION = "com.dstrube.intentserviceimagedownloader";
	public static final int UPDATE_PROGRESS = 1;

//	public DownloadService(String name) {
//		super("DownloadService");
//	}

	public DownloadService() {
		super("DownloadService");
	}

	@Override
	protected void onHandleIntent(Intent intent) {
		final String urlPath = intent.getStringExtra(URL);
		final String fileName = intent.getStringExtra(FILENAME);
		final File output = new File(Environment.getExternalStorageDirectory(),
				fileName);
		if (output.exists()) {
			output.delete();
		}
		final ResultReceiver receiver = intent.getParcelableExtra("receiver");
		
		//Bundle bundle = intent.getExtras();

		InputStream inStream = null;
		FileOutputStream outStream = null;
		try {
			final URL url = new URL(urlPath);
			final URLConnection connection = url.openConnection();
			final int lengthOfFile = connection.getContentLength();

				inStream = url.openConnection().getInputStream();

				
				// url.openStream(); //<- bitmap call for instream; but we're not doing bitmap; we're doing file
				// Bitmap bitmap =
				// BitmapFactory.decodeStream(inStream);

				outStream = new FileOutputStream(output.getPath());
				int next = -1;

				// this is faster with a buffer
				// while ((next = inStream.read()) !=
				// -1) {
				// outStream.write(next);

			final byte[] buffer = new byte[1024];

				int total = 0;

				while ((next = inStream.read(buffer, 0, buffer.length)) != -1) {
					total += next;
					outStream.write(buffer, 0, next);
					Bundle resultData = new Bundle();
					resultData.putInt("progress", total);
					resultData.putInt("max", lengthOfFile);
					
					receiver.send(UPDATE_PROGRESS, resultData);
				}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (inStream != null) {
				try {
					inStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (outStream != null) {
				try {
					outStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		// Successful finished
		result = Activity.RESULT_OK;

		// http://stackoverflow.com/questions/3528735/failed-binder-transaction
		// bitmap = scaleDownBitmap(bitmap, 100, getApplicationContext());

		publishResults(// bitmap,
				output.getAbsolutePath(), result);
	}

	/*
	 * private Bitmap scaleDownBitmap(Bitmap bitmap, int newHeight, Context //
	 * context) { // if (bitmap != null) { // final float densityMultiplier =
	 * context.getResources() // .getDisplayMetrics().density; // int h = (int)
	 * (newHeight * densityMultiplier); // int w = (int) (h * bitmap.getWidth()
	 * / ((double) bitmap.getHeight())); // // bitmap =
	 * Bitmap.createScaledBitmap(bitmap, w, h, true); // } // return bitmap; }
	 */

	private void publishResults(// Bitmap bitmap,
			String outputPath, int result) {
		final Intent intent = new Intent(NOTIFICATION);
		intent.putExtra(FILEPATH, outputPath);
		// intent.putExtra("bitmap", bitmap);
		intent.putExtra(RESULT, result);
		sendBroadcast(intent);
	}
}
