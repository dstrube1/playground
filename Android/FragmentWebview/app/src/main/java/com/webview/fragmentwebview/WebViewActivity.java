package com.webview.fragmentwebview;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.util.Log;

public class WebViewActivity extends FragmentActivity {

        @Override
        protected void onCreate(Bundle savedInstanceState) {                
                super.onCreate(savedInstanceState);
                
                WebViewFragment wvf = new WebViewFragment();
                
                Intent i = this.getIntent();
                String link = i.getExtras().getString("link");
                
                Log.d("SwA", "URL ["+link+"]");
                
                wvf.init(link);
                getFragmentManager().beginTransaction().add(android.R.id.content, wvf).commit();
        }
}