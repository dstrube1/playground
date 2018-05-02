package com.dstrube.weblistintent.view

import android.app.Fragment
import android.webkit.WebViewClient
import android.os.Bundle
import android.view.ViewGroup
import android.view.LayoutInflater
import android.view.View
import android.webkit.WebView
import com.dstrube.weblistintent.R


class ContentFragment : Fragment() {
    private var URL: String? = null

    fun init(url: String) {
        URL = url
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup,
                     savedInstanceState: Bundle): View {
        val view = inflater.inflate(R.layout.web_layout, container, false)
        if (URL != null) {
            val webView = view.findViewById(R.id.webPage) as WebView
            webView.getSettings().setJavaScriptEnabled(true)
            webView.setWebViewClient(SwAWebClient())
            webView.loadUrl(URL)
        }
        return view // super.onCreateView(inflater, container,
        // savedInstanceState);
    }

    fun updateUrl(url: String) {
        URL = url

        val webView = getView().findViewById(R.id.webPage) as WebView
        webView.getSettings().setJavaScriptEnabled(true)
        webView.loadUrl(URL)

    }

    //Purpose: extended WebClient where shouldOverrideUrlLoading = false
    //What does that mean?
    private inner class SwAWebClient : WebViewClient() {

        override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
            return false
        }
    }

}