package com.dstrube.helloaumazondible

import android.util.Log
import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import org.json.JSONObject
import com.android.volley.VolleyError
import org.json.JSONArray
import com.android.volley.RequestQueue
import com.android.volley.Response


class MyDataSource// Singleton pattern requires private constructor
private constructor() : Response.ErrorListener, Response.Listener<JSONObject> {
    private val requestQueue: RequestQueue?
    val imagesUrls: ArrayList<String>
    private var retries: Int = 0
    private var url: String? = null
    var isLoading: Boolean = false
        private set
    private var onDataChangedListener: OnDataChangedListener? = null
    private val CLIENT_ID = "e7ce3f1a709543c7a03313e7f2e02bb4"
    private val TAG = "selfie"

    init {
        imagesUrls = ArrayList()
        isLoading = true
        retries = 0
        requestQueue = MyApplication.getRequestQueue()
        prepareUrlString()
    }

    interface OnDataChangedListener {
        fun onDataChanged()
    }

    private fun prepareUrlString() {
        url = "https://api.instagram.com/v1/tags/{tag}/media/recent/?client_id={client_id}"
        url = url!!.replace("{tag}", TAG)
        url = url!!.replace("{client_id}", CLIENT_ID)
    }

    override fun onResponse(response: JSONObject) {
        retries = 0
        Log.d("Instagram", "Beginning of onResponse; getMoreData request done")
        try {
            val pagination = response.getJSONObject("pagination")
            url = pagination.getString("next_url") // replace the old URL
            // to gather more
            // data
            val data = response.getJSONArray("data")
            val length = data.length()
            for (i in 0 until length) {
                imagesUrls.add(getImgUrlFromJsonObject(data.getJSONObject(i)))
            }
            isLoading = false
            onDataChangedListener!!.onDataChanged()
        } catch (e: Exception) {
            e.printStackTrace()
        }

    }

    override fun onErrorResponse(error: VolleyError) {
        retries++
        if (retries > 5)
            return
        Log.e("Instagram", "Attempt " + retries + " getMoreData request "
                + error.message)
        getMoreData() // retry request if fail
    }

    //input = response
    @Throws(Exception::class)
    private fun getImgUrlFromJsonObject(jsonObject: JSONObject): String {
        var jsonObject = jsonObject
        jsonObject = jsonObject.getJSONObject("images")
        jsonObject = jsonObject.getJSONObject("low_resolution")
        return jsonObject.getString("url")
    }

    fun getMoreData() {
        Log.d("Instagram", "getMoreData\nurl: " + url!!)
        isLoading = true
        val jsonObjectRequest = JsonObjectRequest(Request.Method.GET,
                url, null, this, this)
        requestQueue?.add(jsonObjectRequest)
    }

    fun setOnDataChangedListener(
            onDataChangedListener: OnDataChangedListener) {
        this.onDataChangedListener = onDataChangedListener
    }

    companion object {
        private var singleton: MyDataSource? = null

        //TODO: perhaps use of volatile here for threading concerns?
        val instance: MyDataSource?
            get() {
                if (singleton == null)
                    singleton = MyDataSource()
                return singleton
            }
    }
}
