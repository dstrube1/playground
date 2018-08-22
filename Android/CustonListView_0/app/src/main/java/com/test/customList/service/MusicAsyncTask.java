package com.test.customList.service;

import java.io.BufferedReader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;
import com.test.customList.network.HttpConnectionManager;
import com.test.customList.network.MusicVO;
import com.test.custonlistview.MusicListActivity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Parcelable;
import android.util.Log;
import android.widget.Toast;

public class MusicAsyncTask extends AsyncTask<String, String, String> {

	Context uiContext;
	private ProgressDialog pdia;

	public MusicAsyncTask(Context myContext) {
		this.uiContext = myContext;
		pdia = new ProgressDialog(uiContext);
		System.out.println("Inside Constructor");
	}

	@Override
	protected void onPreExecute() {
		super.onPreExecute();
		this.pdia.setMessage("Loading...");
		//pdia.show();
	}

	@Override
	protected String doInBackground(String... params) {

		System.out.println("In Background" + params.length);
		System.out.println("Params " + params[0]);

		HashMap<String, String> postParam = new HashMap<>();
		String resp = HttpConnectionManager.getMusicList(postParam);

		return resp;

	}

	@Override
	protected void onPostExecute(String result) {
		



		if (null == result || result.equals("")  ) {
			if (result.equals("success")) {
				Toast.makeText(uiContext, "Successfully Submit!!",
						Toast.LENGTH_LONG).show();
			} else {
				Toast.makeText(uiContext, "Failed!!",
						Toast.LENGTH_LONG).show();
			}

		} else {

			BufferedReader br = new BufferedReader(new StringReader(result));
			InputSource is = new InputSource(br);

			/************ Parse XML **************/
			List<MusicVO> myData = null;

			try {
				
				MusicXMLParser parser = new MusicXMLParser();
				
				SAXParserFactory factory = SAXParserFactory.newInstance();
				SAXParser sp = factory.newSAXParser();
				XMLReader reader = sp.getXMLReader();
				reader.setContentHandler(parser);
				reader.parse(is);
				
				myData = parser.list;

			} catch (Exception e) {
				Log.e("Jobs", "Exception parse xml :" + e);
			}

			if (myData != null) {

				/*************** Get Data From ArrayList *********/
				for (MusicVO xmlRowData : myData) {
					if (xmlRowData != null) {
						System.out.println("****  "+ xmlRowData.getArtist());
					} else
						Log.e("Jobs", "Jobs value null");
				}
			}
			//pdia.cancel();
			
			Bundle bundle = new Bundle();
			bundle.putParcelableArrayList("arraylist",(ArrayList<? extends Parcelable>) myData);
			Intent intent = new Intent(uiContext, MusicListActivity.class);
			intent.putExtras(bundle);

			uiContext.startActivity(intent);
			
			
		}
	}
}