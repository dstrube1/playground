package com.dstrube.jsontest.network;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;

import android.content.Context;
import android.widget.Toast;

/**
 * This is the class that is given a URL and returns the content
 * @author david.strube
 *
 */
public class HttpConnectionManager extends HttpConnection {
	//getObject()

	//No constructor
	//Only a static method for getting content from a URL
	public static String Get(String url, Context ctx){
		
		createHttpconnectionAttribute(url);
		
		String content = "";
		InputStream inStream = null;
		
		try {
			// defaultHttpClient
			DefaultHttpClient httpClient = new DefaultHttpClient();
			HttpPost httpPost = new HttpPost(url);

			HttpResponse httpResponse = httpClient.execute(httpPost);
			HttpEntity httpEntity = httpResponse.getEntity();
			inStream = httpEntity.getContent();

		} catch (UnsupportedEncodingException e) {
			// e.printStackTrace();
			Toast.makeText(ctx, e.toString(), Toast.LENGTH_LONG).show();
		} catch (ClientProtocolException e) {
			Toast.makeText(ctx, e.toString(), Toast.LENGTH_LONG).show();
		} catch (IOException e) {
			Toast.makeText(ctx, e.toString(), Toast.LENGTH_LONG).show();
		}

		//Taking from stream to reader, and from reader to string
		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					inStream, "iso-8859-1"), 8);
			StringBuilder sb = new StringBuilder();
			String line = null;
			while ((line = reader.readLine()) != null) {
				sb.append(line + "\n");
			}
			inStream.close();
			content = sb.toString();
		} catch (Exception e) {
			// Log.e("Buffer Error", "Error converting result " + e.toString());
			Toast.makeText(ctx, "Error converting result " + e.toString(),
					Toast.LENGTH_LONG).show();
		}
		return content;

	}
}
