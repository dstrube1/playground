package com.dstrube.xmlparsingtest.controller;

import java.io.IOException;
import java.io.InputStream;
//import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
//import java.util.List;
//import java.util.Map;

//import javax.xml.parsers.ParserConfigurationException;
//import javax.xml.parsers.SAXParser;
//import javax.xml.parsers.SAXParserFactory;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
//import org.w3c.dom.Element;
//import org.xml.sax.InputSource;
//import org.xml.sax.SAXException;
//import org.xml.sax.XMLReader;

import com.dstrube.xmlparsingtest.R;
//import com.dstrube.xmlparsingtest.R.id;
//import com.dstrube.xmlparsingtest.R.layout;
//import com.dstrube.xmlparsingtest.R.menu;
//
//import android.app.Activity;
//import android.app.ActionBar;
import android.app.Fragment;
import android.app.ListActivity;
import android.os.AsyncTask;
import android.os.Bundle;
//import android.util.Log;
import android.view.LayoutInflater;
//import android.view.Menu;
//import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListAdapter;
//import android.widget.ListView;
import android.widget.SimpleAdapter;
//import android.os.Build;
import android.widget.Toast;

//starting with this:
//http://www.mysamplecode.com/2011/11/android-parse-xml-file-example-using.html
public class MainActivity extends ListActivity {

	private final String url = "http://api.androidhive.info/pizza/?format=xml";
	// private final String KEY_ITEM = "item"; // parent node
	private final String KEY_ID = "id";
	private final String KEY_NAME = "name";
	private final String KEY_COST = "cost";
	private final String KEY_DESC = "description";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		// if (savedInstanceState == null) {
		// getFragmentManager().beginTransaction()
		// .add(R.id.container, new PlaceholderFragment()).commit();
		// }
	}

	@Override
	protected void onResume() {
		super.onResume();
		new NetworkXMLCall().execute();
	}

	public void networkCallDone(
			ArrayList<com.dstrube.xmlparsingtest.model.MenuItem> list) {
		Toast.makeText(getApplicationContext(), "Network call done!",
				Toast.LENGTH_SHORT).show();
	}

	private void populateListView(
			ArrayList<com.dstrube.xmlparsingtest.model.MenuItem> list) {
		// from SimpleAdapterTest:
		// ListView listView = (ListView) findViewById(R.id.listView);
		// String[] from = new String[] { "name", "cost", "description" };
		// int[] to = new int[] { R.id.name, R.id.cost, R.id.desciption};
		// SimpleAdapter adapter = new SimpleAdapter(this, (List<? extends
		// Map<String, ?>>) list, R.layout.list_item, from, to);
		// listView.setAdapter(adapter);

		ArrayList<HashMap<String, String>> menuItems = new ArrayList<HashMap<String, String>>();
		for (int i = 0; i < list.size(); i++) {
			HashMap<String, String> map = new HashMap<String, String>();
			// Element e = (Element) list.get(i);
			// adding each child node to HashMap key => value
			map.put(KEY_ID, list.get(i).getId());
			map.put(KEY_NAME, list.get(i).getName());
			map.put(KEY_COST, list.get(i).getCost());
			map.put(KEY_DESC, list.get(i).getDescription());

			// adding HashList to ArrayList
			menuItems.add(map);
		}
		// Adding menuItems to ListView
		ListAdapter adapter = new SimpleAdapter(this, menuItems,
				R.layout.list_item,
				new String[] { KEY_NAME, KEY_DESC, KEY_COST }, new int[] {
						R.id.name, R.id.desciption, R.id.cost });

		setListAdapter(adapter);

		// selecting single ListView item
		// ListView lv = getListView();
	}

	public String getXmlFromUrl(String url) {
		String xml = "";

		try {
			// defaultHttpClient
			DefaultHttpClient httpClient = new DefaultHttpClient();
			HttpPost httpPost = new HttpPost(url);

			HttpResponse httpResponse = httpClient.execute(httpPost);
			HttpEntity httpEntity = httpResponse.getEntity();
			xml = EntityUtils.toString(httpEntity);

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// return XML
		return xml;
	}

	private class NetworkXMLCall
			extends
			AsyncTask<Void, Void, ArrayList<com.dstrube.xmlparsingtest.model.MenuItem>> {
		@Override
		protected ArrayList<com.dstrube.xmlparsingtest.model.MenuItem> doInBackground(
				Void... params) {
			ArrayList<com.dstrube.xmlparsingtest.model.MenuItem> list = null;
			try {
				InputStream input = getAssets().open("test0.xml");
				list = MySAXParser.parseFile(input, MainActivity.this);
			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (list == null || list.size() == 0) {
				try {
					String xml = getXmlFromUrl(url);

					list = MySAXParser.parseString(xml, MainActivity.this);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return list;
		}

		@Override
		protected void onPostExecute(
				ArrayList<com.dstrube.xmlparsingtest.model.MenuItem> result) {
			// super.onPostExecute(result);
			// networkCallDone(result);
			populateListView(result);
		}
	}

	// @Override
	// public boolean onCreateOptionsMenu(Menu menu) {
	//
	// // Inflate the menu; this adds items to the action bar if it is present.
	// getMenuInflater().inflate(R.menu.main, menu);
	// return true;
	// }

	// @Override
	// public boolean onOptionsItemSelected(MenuItem item) {
	// // Handle action bar item clicks here. The action bar will
	// // automatically handle clicks on the Home/Up button, so long
	// // as you specify a parent activity in AndroidManifest.xml.
	// int id = item.getItemId();
	// if (id == R.id.action_settings) {
	// return true;
	// }
	// return super.onOptionsItemSelected(item);
	// }

	/**
	 * A placeholder fragment containing a simple view.
	 */
	public static class PlaceholderFragment extends Fragment {

		public PlaceholderFragment() {
		}

		@Override
		public View onCreateView(LayoutInflater inflater, ViewGroup container,
				Bundle savedInstanceState) {
			View rootView = inflater.inflate(R.layout.fragment_main, container,
					false);
			return rootView;
		}
	}

}
