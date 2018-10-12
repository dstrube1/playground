package com.dstrube.helloaumazondible;

import android.app.Application;
import android.graphics.Bitmap;
import android.util.LruCache;

import com.android.volley.RequestQueue;
import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.Volley;

public class MyApplication  extends Application {

    private static RequestQueue requestQueue;
    private static ImageLoader imageLoader;
    private static ImageLoader.ImageCache imageCache;

    private static MyApplication instance;
    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
    }


    //
    //Volley logic
    //
    public static ImageLoader getImageLoader() {
        if (imageLoader == null){
            imageCache = new BitmapLruCache();
            imageLoader = new ImageLoader(getRequestQueue(), imageCache);
        }
        return imageLoader;
    }

    //Rolling our own request queue. Sure using the default is easier, but this is better
    public static RequestQueue getRequestQueue() {
        if (requestQueue == null) {
            requestQueue = Volley.newRequestQueue(instance.getApplicationContext());
        }
        return requestQueue;
    }

    //Image cache class, for internal static use only
    private static class BitmapLruCache extends LruCache<String, Bitmap> implements ImageLoader.ImageCache {
        public BitmapLruCache() {
            this(getDefaultLruCacheSize());
        }

        public BitmapLruCache(int sizeInKB) {
            super(sizeInKB);
        }

        @Override
        protected int sizeOf(String key, Bitmap bitmap) {
            return bitmap.getRowBytes() * bitmap.getHeight() / 1024;
        }

        @Override
        public Bitmap getBitmap(String url) {
            return get(url);
        }

        @Override
        public void putBitmap(String url, Bitmap bitmap) {
            put(url, bitmap);
        }

        public static int getDefaultLruCacheSize() {
            final int maxMemory =
                    (int) (Runtime.getRuntime().maxMemory() / 1024);
            final int cacheSize = maxMemory / 8;

            return cacheSize;
        }
    }

}
