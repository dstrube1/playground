package com.dstrube.paypalphotoviewer.service;

import java.io.File;

import android.content.Context;

/**
 * This class represents a file cache
 * Required by ImageLoader.
 * 
 * @author david.strube
 * (Copied from Nirmal Thakur)
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
				android.os.Environment.MEDIA_MOUNTED)) {
			cacheDir = new File(
					android.os.Environment.getExternalStorageDirectory(),
					"LazyList");
		}
		else {
			cacheDir = context.getCacheDir();
		}
		if (!cacheDir.exists()) {
			if (!cacheDir.mkdirs()){
				System.out.println("Make dirs failed");
			}

		}
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
		return new File(cacheDir, filename);
	}

	/**
	 * Clear cache
	 */
	public void clear() {
		File[] files = cacheDir.listFiles();
		if (files == null) {
            return;
        }
		for (File f : files) {
            if (!f.delete()){
                System.out.println("Failed to delete " + f.getAbsolutePath());
            }
        }
	}
}
