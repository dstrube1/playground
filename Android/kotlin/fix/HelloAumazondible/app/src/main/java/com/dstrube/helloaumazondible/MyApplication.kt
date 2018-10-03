package com.dstrube.helloaumazondible

import android.app.Application
import android.graphics.Bitmap
import android.support.v4.util.LruCache
import com.android.volley.toolbox.Volley
import com.android.volley.RequestQueue
import com.android.volley.toolbox.ImageLoader


class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        instance = this
    }

    //Image cache class, for internal static use only
    private class BitmapLruCache @JvmOverloads constructor(sizeInKB: Int = defaultLruCacheSize) : LruCache<String, Bitmap>(sizeInKB), ImageLoader.ImageCache {

        protected override fun sizeOf(key: String, bitmap: Bitmap): Int {
            return bitmap.rowBytes * bitmap.height / 1024
        }

        override fun getBitmap(url: String): Bitmap {
            return get(url)
        }

        override fun putBitmap(url: String, bitmap: Bitmap) {
            put(url, bitmap)
        }

        companion object {

            val defaultLruCacheSize: Int
                get() {
                    val maxMemory = (Runtime.getRuntime().maxMemory() / 1024).toInt()

                    return maxMemory / 8
                }
        }
    }

    companion object {

        private var requestQueue: RequestQueue? = null
        private var imageLoader: ImageLoader? = null
        private var imageCache: ImageLoader.ImageCache? = null

        private var instance: MyApplication? = null


        //
        //Volley logic
        //
        fun getImageLoader(): ImageLoader? {
            if (imageLoader == null) {
                imageCache = BitmapLruCache()
                imageLoader = ImageLoader(getRequestQueue(), imageCache)
            }
            return imageLoader
        }

        //Rolling our own request queue. Sure using the default is easier, but this is better
        fun getRequestQueue(): RequestQueue? {
            if (requestQueue == null && instance != null) {
                requestQueue = Volley.newRequestQueue(instance!!.applicationContext)
            }
            return requestQueue
        }
    }

}
