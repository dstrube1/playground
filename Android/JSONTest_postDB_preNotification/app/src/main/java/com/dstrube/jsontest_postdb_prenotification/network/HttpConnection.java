package com.dstrube.jsontest_postdb_prenotification.network;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

/**
 * Abstract class for HttpConnection.
 * Should only be implemented in this project y HttpConnectionManager
 * @author david.strube
 *
 */
public abstract class HttpConnection {
	public static HttpClient httpClient;
	public static HttpPost httpPost;
	
	/**
	 * Set things up
	 * @param url
	 */
	public static void createHttpconnectionAttribute(String url){
		//see method of the same name and class in CustonListView for details
		httpClient = new DefaultHttpClient();
		httpPost = new HttpPost(url);
	}
	
	/**
	 * Get post name value pair
	 * @param paramMap
	 * @return
	 */
	public static List<NameValuePair> getPostNameValuePair(HashMap<String, String> paramMap){
		//see method of the same name and class in CustonListView for details
		List<NameValuePair> nameValuePairList = new ArrayList<NameValuePair>();
		Iterator<String> paramKey =  paramMap.keySet().iterator();
		while(paramKey.hasNext()){
			String key = paramKey.next();
			nameValuePairList.add(new BasicNameValuePair(key,paramMap.get(key)));
		}
		return nameValuePairList;
	}
}
