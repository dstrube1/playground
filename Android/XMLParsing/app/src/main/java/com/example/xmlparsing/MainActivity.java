package com.example.xmlparsing;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import android.app.ListActivity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

public class MainActivity extends ListActivity {

	// All static variables
	static final String URL = "http://api.androidhive.info/pizza/?format=xml";
	// XML node keys
	static final String KEY_ITEM = "item"; // parent node
	static final String KEY_ID = "id";
	static final String KEY_NAME = "name";
	static final String KEY_COST = "cost";
	static final String KEY_DESC = "description";
	

	DOMXMLParser parser;
	String xml;  // getting XML
	Document doc; // getting DOM element

	NodeList nl; 
	ArrayList<HashMap<String, String>> menuItems = new ArrayList<HashMap<String, String>>();
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		new NetworkXMLCall().execute();
	}
	
	private void populateList() {
		// looping through all item nodes <item>
		for (int i = 0; i < nl.getLength(); i++) {
			// creating new HashMap
			HashMap<String, String> map = new HashMap<String, String>();
			Element e = (Element) nl.item(i);
			// adding each child node to HashMap key => value
			map.put(KEY_ID, parser.getValue(e, KEY_ID));
			map.put(KEY_NAME, parser.getValue(e, KEY_NAME));
			map.put(KEY_COST, "Rs." + parser.getValue(e, KEY_COST));
			map.put(KEY_DESC, parser.getValue(e, KEY_DESC));

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
		ListView lv = getListView();

		lv.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				// getting values from selected ListItem
				String name = ((TextView) view.findViewById(R.id.name)).getText().toString();
				String cost = ((TextView) view.findViewById(R.id.cost)).getText().toString();
				String description = ((TextView) view.findViewById(R.id.desciption)).getText().toString();
				
				// Starting new intent
				Intent in = new Intent(getApplicationContext(), SingleMenuItemActivity.class);
				in.putExtra(KEY_NAME, name);
				in.putExtra(KEY_COST, cost);
				in.putExtra(KEY_DESC, description);
				startActivity(in);

			}
		});
		
	}

	
	private class NetworkXMLCall extends AsyncTask<Void, Void, Void>{

		@Override
		protected Void doInBackground(Void... params) {
			parser =  new DOMXMLParser();
			xml = parser.getXmlFromUrl(URL); // getting XML
			doc = parser.getDomElement(xml); // getting DOM element
			nl =  doc.getElementsByTagName(KEY_ITEM);
			
			SAXParserFactory factory = SAXParserFactory.newInstance();
			try {
				SAXParser parser2 = factory.newSAXParser();
				//http://www.mkyong.com/java/how-to-read-xml-file-in-java-sax-parser/
				//http://docs.oracle.com/javase/tutorial/jaxp/sax/parsing.html
				//http://www.journaldev.com/1198/java-sax-parser-example-tutorial-to-parse-xml-to-list-of-objects
				
				parser2.parse(URL, new DefaultHandler(){
					
					@Override
					public void startElement(String uri, String localName,
							String qName, Attributes attributes)
							throws SAXException {
						super.startElement(uri, localName, qName, attributes);
					}
					
					@Override
					public void endElement(String uri, String localName,
							String qName) throws SAXException {
						super.endElement(uri, localName, qName);
					}
				});
				parser2.getXMLReader();
			} catch (ParserConfigurationException e) {
				e.printStackTrace();
			} catch (SAXException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		
		@Override
		protected void onPostExecute(Void result) {
			populateList();
		}


	}
	
	
}