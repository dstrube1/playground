package com.dstrube.asynctaskloadertest;

import android.content.Context;
import android.widget.ListView;

public class MyObject {
	public Context context;
	public  ListView listView;
	
	public MyObject(){}
	public MyObject(Context context, ListView listView){
		setContext(context);
		setListView(listView);
	}

	public void setContext(Context context){
		this.context = context;
	}
	public void setListView(ListView listView){
		this.listView = listView;
	}
}
