package com.test.customList.network;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
//import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;


public class HttpConnectionManager extends HttpConnection {

	public static String getMusicList(HashMap<String, String> paramMap) {

		createHttpconnectionAttribute();

		try {
			// UrlEncodedFormEntity is an entity composed of a list of
			// url-encoded pairs.
			// This is typically useful while sending an HTTP POST request.
			 UrlEncodedFormEntity urlEncodedFormEntity = new UrlEncodedFormEntity(getPostNameValuePair(paramMap));

			// setEntity() hands the entity (here it is urlEncodedFormEntity) to
			// the request.
			
			httpPost.setEntity(urlEncodedFormEntity);

			try {
				// HttpResponse is an interface just like HttpPost.
				// Therefore we can't initialize them
				
				HttpResponse httpResponse = httpClient.execute(httpPost);

				// According to the JAVA API, InputStream constructor do
				// nothing.
				// So we can't initialize InputStream although it is not an
				// interface
				
				InputStream inputStream = httpResponse.getEntity().getContent();

				InputStreamReader inputStreamReader = new InputStreamReader(inputStream);

				BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

				StringBuilder stringBuilder = new StringBuilder();

				String bufferedStrChunk;

				while ((bufferedStrChunk = bufferedReader.readLine()) != null) {
					stringBuilder.append(bufferedStrChunk);
				}
				return stringBuilder.toString();

			} catch (ClientProtocolException cpe) {
				System.out.println("First Exception caz of HttpResponese :"+ cpe);
				cpe.printStackTrace();
				return null;
			} catch (IOException ioe) {
				System.out.println("Second Exception caz of HttpResponse :"+ ioe);
				ioe.printStackTrace();
				return null;
			}
		} catch (Exception uee) {
			System.out.println("An Exception given because of UrlEncodedFormEntity argument : "+ uee);
			uee.printStackTrace();
			return null;
		}
	}
}
