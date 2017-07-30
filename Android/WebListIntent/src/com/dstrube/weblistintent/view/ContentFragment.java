package com.dstrube.weblistintent.view;

import com.dstrube.weblistintent.R;

import android.annotation.SuppressLint;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.webkit.WebViewClient;

//In the FragmentWebview project, this was WebViewFragment.
//I like my name better
@SuppressLint("SetJavaScriptEnabled") 
public class ContentFragment extends Fragment {
	private String URL;

	public void init(String url) {
		URL = url;
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View view = inflater.inflate(R.layout.web_layout, container, false);
		if (URL != null) {
			WebView webView = (WebView) view.findViewById(R.id.webPage);
			webView.getSettings().setJavaScriptEnabled(true);
			webView.setWebViewClient(new SwAWebClient());
			webView.loadUrl(URL);
		}
		return view; // super.onCreateView(inflater, container,
						// savedInstanceState);
	}

	public void updateUrl(String url) {
		URL = url;

		WebView webView = (WebView) getView().findViewById(R.id.webPage);
		webView.getSettings().setJavaScriptEnabled(true);
		webView.loadUrl(URL);

	}

	//Purpose: extended WebClient where shouldOverrideUrlLoading = false
	//What does that mean?
	private class SwAWebClient extends WebViewClient {

        @Override
        public boolean shouldOverrideUrlLoading(WebView view, String url) {
                return false;
        }
	};

}
