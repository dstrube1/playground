package com.dstrube.xmlparsingtest.controller;

import java.util.ArrayList;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import com.dstrube.xmlparsingtest.model.MenuItem;

public class MenuItemXMLHandler extends DefaultHandler {

	private Boolean currentElement = false;
	private String currentValue = "";
	private MenuItem item = null;
	private ArrayList<MenuItem> list = new ArrayList<MenuItem>();

	public ArrayList<MenuItem> getList(){
		return list;
	}
	
	//When tag starts
	@Override
	public void startElement(String uri, String localName, String qName,
			Attributes attributes) throws SAXException {
		//super.startElement(uri, localName, qName, attributes);
		currentElement = true;
		currentValue = "";
		if (localName.equals("item")){
			item = new MenuItem();
		}
	}
	
	//When tag ends
	@Override
	public void endElement(String uri, String localName, String qName)
			throws SAXException {
		//super.endElement(uri, localName, qName);
		currentElement = false;
		if (localName.equalsIgnoreCase("id")){
			item.setId(currentValue);
		}
		else if (localName.equalsIgnoreCase("name")){
			item.setName(currentValue);
		}
		else if (localName.equalsIgnoreCase("cost")){
			item.setCost(currentValue);
		}
		else if (localName.equalsIgnoreCase("description")){
			item.setDescription(currentValue);
		}
		else if (localName.equalsIgnoreCase("item")){
            list.add(item);
		}
		//else?
	}
	
	//To get tag characters
	@Override
	public void characters(char[] ch, int start, int length)
			throws SAXException {
		//super.characters(ch, start, length);
		if (currentElement){
			currentValue = currentValue + new String(ch, start, length);
		}
	}
}
