package com.dstrube.weblistintent;

import android.annotation.SuppressLint;
import android.app.Activity;
//import android.content.Intent;
import android.os.Bundle;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

//a more descriptive name like like "WebActivity" would be more appropriate for future projects
public class Screen2 extends Activity {
//	private Intent intent;
	private String url;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.screen2);

//		intent = getIntent();
		url = getIntent().getStringExtra("url");
	}

	@SuppressLint("SetJavaScriptEnabled") @Override
	protected void onResume() {
		super.onResume();
		WebView webView = (WebView) findViewById(R.id.webView1);
		WebSettings webSettings = webView.getSettings();
		webSettings.setJavaScriptEnabled(true);
		webView.setWebViewClient(new WebViewClient());
		webView.loadUrl(url);
	}
	
	//I'm leaving a lot of methods out from Abraham's WebActivity.
	//If app is failing, come back to this first
}
