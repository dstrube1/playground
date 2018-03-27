package com.dstrube.jsontest_postdb_prenotification.service;

import java.io.File;

import android.content.Context;

/**
 * This class represents a file cache
 * Required by ImageLoader.
 * 
 * @author david.strube
 * 
 */
public class FileCache {

	private File cacheDir;

	/**
	 * Constructor
	 * 
	 * @param context
	 */
	public FileCache(Context context) {
		// Find the dir to save cached images
		if (android.os.Environment.getExternalStorageState().equals(
				android.os.Environment.MEDIA_MOUNTED))
			cacheDir = new File(
					android.os.Environment.getExternalStorageDirectory(),
					"LazyList");
		else
			cacheDir = context.getCacheDir();
		if (!cacheDir.exists())
			cacheDir.mkdirs();
	}

	/**
	 * Given a url, get the file
	 * @param url
	 * @return
	 */
	public File getFile(String url) {
		// I identify images by hashcode. Not a perfect solution, good for the
		// demo.
		String filename = String.valueOf(url.hashCode());
		// Another possible solution (thanks to grantland)
		// String filename = URLEncoder.encode(url);
		File f = new File(cacheDir, filename);
		return f;

	}

	/**
	 * Clear cache
	 */
	public void clear() {
		File[] files = cacheDir.listFiles();
		if (files == null)
			return;
		for (File f : files)
			f.delete();
	}
}
