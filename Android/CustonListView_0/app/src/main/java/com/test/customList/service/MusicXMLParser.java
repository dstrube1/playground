package com.test.customList.service;

import java.util.ArrayList;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import com.test.customList.network.MusicVO;


public class MusicXMLParser extends DefaultHandler {
	public ArrayList<MusicVO> list = new ArrayList<>();
	//String builder acts as a buffer

	StringBuilder builder;
	MusicVO musicVO = null;
	@Override
	public void startDocument() throws SAXException {
		list = new ArrayList<>();
	}

	@Override
	public void startElement(String uri, String localName, String qName,
			Attributes attributes) throws SAXException {

		// Create StringBuilder object to store xml node value
		builder = new StringBuilder();

		if (localName.equals("music")) {
			// Do nothing
		}
		if (localName.equals("song")) {
			musicVO = new MusicVO("");
		}
	}

	@Override
	public void endElement(String uri, String localName, String qName)
			throws SAXException {

		if (localName.equals("song")) {

			/** finished reading a job xml node, add it to the arraylist **/
			list.add(musicVO);

		} else if (localName.equalsIgnoreCase("id")) {
			musicVO.setId(builder.toString());
		} else if (localName.equalsIgnoreCase("title")) {

			musicVO.setTitle(builder.toString());
		} else if (localName.equalsIgnoreCase("artist")) {
			musicVO.setArtist(builder.toString());
		}else if (localName.equalsIgnoreCase("duration")) {
			musicVO.setDuration(builder.toString());
		}else if (localName.equalsIgnoreCase("thumb_url")) {
			musicVO.setThumb_Url(builder.toString());
		}
	}

	@Override
	public void characters(char[] ch, int start, int length)
			throws SAXException {

		/****** Read the characters and append them to the buffer ******/
		String tempString = new String(ch, start, length);
		builder.append(tempString);
	}
}
