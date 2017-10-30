package com.dstrube.xmlparsingtest.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.util.ArrayList;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;

import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import com.dstrube.xmlparsingtest.model.MenuItem;

public class MySAXParser {

	private static XMLReader reader = null;
	private static MenuItemXMLHandler handler = null;
	private static SAXParserFactory factory = null;
	private static SAXParser parser = null;
	private static ArrayList<MenuItem> list = null;
	private static Context context = null;

	private static void preParse(Context ctx) {

		try {
			context = ctx;
			factory = SAXParserFactory.newInstance();
			parser = factory.newSAXParser();
			reader = parser.getXMLReader();
			handler = new MenuItemXMLHandler();
			reader.setContentHandler(handler);
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
			Toast.makeText(
					context, e.toString(),
					Toast.LENGTH_LONG).show();
		} catch (SAXException e) {
			e.printStackTrace();
			Toast.makeText(
					context, e.toString(),
					Toast.LENGTH_LONG).show();
		}
	}

	private static ArrayList<MenuItem> postParse() {
		list = handler.getList();

		for (int i = 0; i < list.size(); i++) {
			com.dstrube.xmlparsingtest.model.MenuItem item = list.get(i);
			Log.d("", "Menu item id:" + item.getId());
			Log.d("", "Menu item name:" + item.getName());
			Log.d("", "Menu item cost:" + item.getCost());
		}

		return list;
	}

	public static ArrayList<MenuItem> parseString(String xml, Context ctx) {

		preParse(ctx);

		try {

			InputSource input = new InputSource();
			input.setCharacterStream(new StringReader(xml));

			reader.parse(input);

			// } catch (ParserConfigurationException e) {
			// e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
			Toast.makeText(
					context, e.toString(),
					Toast.LENGTH_LONG).show();
		} catch (IOException e) {
			e.printStackTrace();
			Toast.makeText(
					context, e.toString(),
					Toast.LENGTH_LONG).show();
		}
		return postParse();

	}

	public static ArrayList<MenuItem> parseFile(InputStream input, Context ctx) {

		try {
			preParse(ctx);

			reader.parse(new InputSource(input));

			// } catch (ParserConfigurationException e) {
			// e.printStackTrace();
			// Toast.makeText(getApplicationContext(), e.toString(),
			// Toast.LENGTH_LONG).show();
		} catch (SAXException e) {
			e.printStackTrace();
			Toast.makeText(
					context, e.toString(),
					Toast.LENGTH_LONG).show();
		} catch (IOException e) {
			e.printStackTrace();
			Toast.makeText(
					context, e.toString(),
					Toast.LENGTH_LONG).show();
		}

		return postParse();
	}
}
