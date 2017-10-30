package com.dstrube.weblistintent;

import java.util.HashMap;
import java.util.Map;
import android.annotation.SuppressLint;
import android.app.Fragment;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class FragmentB extends Fragment {
	Map<String, String> map;
	WebView webView;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		final Context ctx = getView().getContext();
		final Resources res = ctx.getResources();
		final String[] domains = res.getStringArray(R.array.domains);

		map = new HashMap<String, String>();
		for (int i = 0; i < domains.length; i++) {
			map.put(domains[i], "http://www." + domains[i] + ".com");
		}
		return inflater.inflate(R.layout.fragment_b, container, false);

	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
		webView = (WebView) getActivity().findViewById(R.id.webView1);
	}

	@SuppressLint("SetJavaScriptEnabled") 
	public void setContent(String selection) {

		if (webView == null) {
			Intent intent = new Intent();
			intent.putExtra("url", selection);

		} else {
			WebSettings webSettings = webView.getSettings();
			webSettings.setJavaScriptEnabled(true);
			webView.setWebViewClient(new WebViewClient());
			webView.loadUrl(selection);
		}
	}
}
