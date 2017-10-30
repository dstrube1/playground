package com.dstrube.weblistintent.controller;

import com.dstrube.weblistintent.view.ContentFragment;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;

public class ContentFragmentActivity extends FragmentActivity {
	@Override
	protected void onCreate(Bundle arg0) {
		super.onCreate(arg0);
		
		ContentFragment contentFragment = new ContentFragment();
        
        Intent i = this.getIntent();
        String link = i.getExtras().getString("link");
        
        contentFragment.init(link);
        getFragmentManager().beginTransaction().add(android.R.id.content, contentFragment).commit();
	}
}
