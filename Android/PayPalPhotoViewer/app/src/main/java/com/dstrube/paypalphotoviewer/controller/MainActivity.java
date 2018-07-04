package com.dstrube.paypalphotoviewer.controller;

import java.io.File;
import java.util.ArrayList;

import com.dstrube.paypalphotoviewer.R;
import com.dstrube.paypalphotoviewer.view.CustomAdapter;
import com.dstrube.paypalphotoviewer.view.PhotoRowObject;
import com.dstrube.paypalphotomodel.Photo;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Fragment;
import android.os.Bundle;
import android.os.Environment;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.GridView;
import android.widget.TextView;

public class MainActivity extends Activity {

	private ArrayList<Photo> internalPhotos;
	private ArrayList<Photo> externalPhotos;
	private ArrayList<Photo> webPhotos;
	private ArrayList<PhotoRowObject> allImages;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		if (savedInstanceState == null) {
			getFragmentManager().beginTransaction()
					.add(R.id.container, new PlaceholderFragment()).commit();
		}
		if (internalPhotos == null) {
			internalPhotos = new ArrayList<>();
		}
		if (externalPhotos == null) {
			externalPhotos = new ArrayList<>();
		}
		if (webPhotos == null) {
			webPhotos = new ArrayList<>();
		}
		if (allImages == null) {
			allImages = new ArrayList<>();
		}
	}

	// We'll worry about Locale before going to production
	@SuppressLint("DefaultLocale")
	private void getPhotos(String path, ArrayList<Photo> list) {
		try {
			// System.out.println("testing "+path);
			File dir = new File(path);
			// if it wants to be left alone, leave it alone
			if (!dir.isHidden()) {
				for (File file : dir.listFiles()) {
					if (file.isDirectory()) {
						// get what all is inside this folder
						getPhotos(file.getPath(), list);
						// then move on, so as to not risk adding this
						// folder to the list of photos.
						// (I've seen folders in the Android filesystem with
						// names like "blah.jpg".)
						continue;
					}
					String fileName = file.getName().toLowerCase();
					if (fileName.endsWith(".jpg")
							|| fileName.endsWith(".png")) {
						// maybe other file types, but this is good enough
						// for now
						Photo myPhoto = new Photo(file.getName(),
								file.getAbsolutePath(), "location", "lat",
								"lng", "dateTaken");
						list.add(myPhoto);
					}
				}
			}
		} catch (NullPointerException e) {
			System.out.println("NullPointerException at " + path);
		} catch (Exception e) {
			System.out.println("Unexpected Exception at " + path);
		}
	}

	@Override
	protected void onResume() {
		super.onResume();

		// 0: throw up a Wait indicator
		// Toast.makeText(getApplicationContext(),
		// "getting the list of internal photos", Toast.LENGTH_SHORT)
		// .show();
		
		// 1: get the list of internal photos
//		getPhotos(Environment.getDataDirectory().toString(), internalPhotos);
		
		// 2: get the list of external photos
		// Toast.makeText(getApplicationContext(),
		// "getting the list of external photos", Toast.LENGTH_SHORT)
		// .show();
		getPhotos(Environment.getExternalStorageDirectory().toString(),
				externalPhotos);

		// 3: get the user setting for whether to include photos from a web
		// service; if so, get them
		// Toast.makeText(getApplicationContext(),
		// "getting the list of web photos", Toast.LENGTH_SHORT).show();
		// list internal, list external, list web
		// handle click to go to the view of one photo

		TextView tv = findViewById(R.id.textView1);
//		listView = (ListView)findViewById(R.id.listView);
		GridView gridView = findViewById(R.id.gridview);
		
		if (internalPhotos.size() > 0) {
//			for (Photo photo : internalPhotos) {
//				PhotoRowObject pro = new PhotoRowObject(photo.getPath(),true);
//				allImages.add(pro);
//			}
		}
		if (externalPhotos.size() > 0) {
			for (Photo photo : externalPhotos) {
				PhotoRowObject pro = new PhotoRowObject(photo.getPath(),true);
				allImages.add(pro);
			}
		}
		if (allImages.size() == 0) {
			tv.setText("No images found.");
		}else{
			tv.setVisibility(View.GONE);
//			listView.setVisibility(View.VISIBLE);
			gridView.setVisibility(View.VISIBLE);
			CustomAdapter adapter = new CustomAdapter(this, allImages);
//	        listView.setAdapter(adapter);
			gridView.setAdapter(adapter);
		}

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
			View rootView = inflater.inflate(R.layout.fragment_main, container,
					false);
			return rootView;
		}
	}

}
