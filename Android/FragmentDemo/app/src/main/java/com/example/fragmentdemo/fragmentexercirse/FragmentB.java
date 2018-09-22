package com.example.fragmentdemo.fragmentexercirse;

import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ImageView;

import com.example.fragmentdemo.R;

import java.util.HashMap;
import java.util.Map;

public class FragmentB extends Fragment {

    static Map<String, Integer> map;
    static {
        map = new HashMap<>();
        map.put("Google", R.drawable.google);
        map.put("Yahoo", R.drawable.yahoo);
        map.put("Facebook", R.drawable.facebook);
        map.put("Twitter", R.drawable.twitter);
        map.put("Bing", R.drawable.bing);
        map.put("Linkedin", R.drawable.linkedin);

    }

    ImageView imageView;
    WebView myWebView;
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_b, container , false);
    }


    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        imageView = (ImageView) getActivity().findViewById(R.id.imageButton1);
        myWebView = (WebView) getActivity().findViewById(R.id.webView1);
    }

    public void changeText(String selection){

        if(myWebView == null)
        {
            Intent intent = new Intent();
            intent.putExtra("URL", selection);

        }
        else
        {
//		WebSettings webSettings = myWebView.getSettings();
//		webSettings.setJavaScriptEnabled(true);
            myWebView.setWebViewClient(new WebViewClient());
            myWebView.loadUrl(selection);
        }
    }
}
