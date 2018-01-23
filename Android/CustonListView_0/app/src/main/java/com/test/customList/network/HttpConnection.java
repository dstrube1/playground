package com.test.customList.network;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

public abstract class HttpConnection {
	public static HttpClient httpClient;
	public static HttpPost httpPost;
	public static void createHttpconnectionAttribute(){
		
		// Because we are not passing values over the URL, we should have a
		// mechanism to pass the values that can be
		// uniquely separate by the other end.
		// To achieve that we use BasicNameValuePair
		// Things we need to pass with the POST request
		
		httpClient = new DefaultHttpClient();
		//httpPost = new HttpPost(ConnectionConstant.url);
		httpPost = new HttpPost("http://api.androidhive.info/music/music.xml");
	}
	
	public static List<NameValuePair> getPostNameValuePair(HashMap<String, String> paramMap){

		// We add the content that we want to pass with the POST request to as
		// name-value pairs
		// Now we put those sending details to an ArrayList with type safe of
		// NameValuePair

		List<NameValuePair> nameValuePairList = new ArrayList<NameValuePair>();
		Iterator<String> paramKey =  paramMap.keySet().iterator();
		while(paramKey.hasNext()){
			String key = paramKey.next();
			nameValuePairList.add(new BasicNameValuePair(key,paramMap.get(key)));
		}
		return nameValuePairList;
	}

}
