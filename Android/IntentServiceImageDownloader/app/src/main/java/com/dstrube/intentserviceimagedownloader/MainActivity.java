package com.dstrube.intentserviceimagedownloader;

//import java.io.File;
//import java.net.URI;

import android.app.Activity;
//import android.app.ActionBar;
import android.app.Fragment;
import android.app.ProgressDialog;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
//import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.Handler;
import android.os.ResultReceiver;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.Toast;

//import android.os.Build;

public class MainActivity extends Activity {

	// source of button images:
	// http://www.turbosquid.com/3d-models/3d-portal-button-model/686559
	// http://www.newgrounds.com/art/view/tsdeath1/simple-3d-button

	private ImageView image = null;
	private ProgressDialog barProgressDialog;
	private Handler updateBarHandler;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		if (savedInstanceState == null) {
			getFragmentManager().beginTransaction()
					.add(R.id.container, new PlaceholderFragment()).commit();
		}
	}

	@Override
	protected void onResume() {
		super.onResume();
		image = findViewById(R.id.imageView1);
		registerReceiver(receiver, new IntentFilter(
				DownloadService.NOTIFICATION));
		updateBarHandler = new Handler();

	}

	/**
	 * This method handles the click on the button in the main activity's fragment.
	 * @param v
	 */
	public void Click(View v) {
		// this works, but is not what we're trying to do:
		// image.setImageResource(R.drawable.button2);

		barProgressDialog = new ProgressDialog(MainActivity.this);

		barProgressDialog.setTitle("Downloading Image ...");
		barProgressDialog.setMessage("Download in progress ...");
		barProgressDialog.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
		barProgressDialog.setProgress(0);
		barProgressDialog.setMax(100);
		barProgressDialog.show();

		Intent intent = new Intent(this, DownloadService.class);
		// add info for the service which file to download and where to store
		intent.putExtra(DownloadService.FILENAME, "hive.jpg");
		intent.putExtra(DownloadService.URL,
				"http://api.androidhive.info/progressdialog/hive.jpg");
		intent.putExtra("receiver", new DownloadReceiver(updateBarHandler));
		// Bundle extras = new Bundle();
		// extras.putParcelable("context", MainActivity.this);
		// intent.putExtras(extras);
		startService(intent);

	}

	/**
	 * This class receives notification from the DownloadServices as the download progresses.
	 * When notification is received, this class updates the Progress Dialog Bar
	 * @author david.strube
	 *
	 */
	public class DownloadReceiver extends ResultReceiver {

		public DownloadReceiver(Handler handler) {
			super(handler);
		}

		@Override
		protected void onReceiveResult(int resultCode, Bundle resultData) {
			super.onReceiveResult(resultCode, resultData);
			if (resultCode == DownloadService.UPDATE_PROGRESS) {
				int progress = resultData.getInt("progress");
				int max = resultData.getInt("max");
				if (barProgressDialog.getMax() != max) {
					barProgressDialog.setMax(max);
				}
				// put progress bar logic here
				if (barProgressDialog.getProgress() <= barProgressDialog
						.getMax()) {
					barProgressDialog.setProgress(progress);
					System.out.println("progress update: "+progress + "/"+max);
				}

				// MyProgressDialog.setProgress(progress);
				
				if (barProgressDialog.getProgress() == barProgressDialog
						.getMax()) {

					barProgressDialog.dismiss();

				}
			}
		}
	}

	/**
	 * This class receives notification from the DownloadServices when the download is complete.
	 * When notification is received, this class displays the downloaded image.
	 * @author david.strube
	 *
	 */
	private BroadcastReceiver receiver = new BroadcastReceiver() {

		@Override
		public void onReceive(Context context, Intent intent) {
			final Bundle bundle = intent.getExtras();
			if (bundle != null) {
				final String filePath = bundle.getString(DownloadService.FILEPATH);
				final Bitmap bitmap = BitmapFactory.decodeFile(filePath);
				//not doing either of these ways:
				// File file = new File(filePath);
				// Bitmap bitmap = (Bitmap) bundle.get("bitmap");

				final int resultCode = bundle.getInt(DownloadService.RESULT);
				if (resultCode == RESULT_OK) {
					// Toast.makeText(MainActivity.this,
					// "Download complete. Download URI: " + filePath,
					// Toast.LENGTH_LONG).show();
					// worth a try:

					image.setImageBitmap(bitmap);
					if (barProgressDialog.isShowing()) {

						barProgressDialog.dismiss();

					}
				} else {
					Toast.makeText(MainActivity.this, "Download failed.",
							Toast.LENGTH_LONG).show();
				}
			}
		}
	};

	@Override
	protected void onPause() {
		super.onPause();
		unregisterReceiver(receiver);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {

		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

	/**
	 * A placeholder fragment containing a simple view.
	 */
	public static class PlaceholderFragment extends Fragment {

		public PlaceholderFragment() {
		}

		@Override
		public View onCreateView(LayoutInflater inflater, ViewGroup container,
				Bundle savedInstanceState) {
			final View rootView = inflater.inflate(R.layout.fragment_main, container,
					false);
			return rootView;
		}
	}

}
