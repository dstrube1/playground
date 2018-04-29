package com.dstrube.xmlparsingtest.controller

import org.xml.sax.Attributes
import org.xml.sax.helpers.DefaultHandler
import org.xml.sax.SAXException

import com.dstrube.xmlparsingtest.model.MenuItem

class MenuItemXMLHandler : DefaultHandler(){
    private var currentElement = false
    private var currentValue = ""
    private var item: MenuItem? = null
    private val list = ArrayList<MenuItem?>()


    fun getList(): ArrayList<MenuItem?> {
        return list
    }

    //When tag starts
    @Throws(SAXException::class)
    override fun startElement(uri: String, localName: String, qName: String,
                     attributes: Attributes) {
        //super.startElement(uri, localName, qName, attributes);
        currentElement = true
        currentValue = ""
        if (localName == "item") {
            item = MenuItem()
        }
    }

    //When tag ends
    @Throws(SAXException::class)
    override fun endElement(uri: String?, localName: String?, qName: String?) {
        //super.endElement(uri, localName, qName);
        currentElement = false
        if (localName!!.equals("id", ignoreCase = true)) {
            item?.setId(currentValue)
        } else if (localName.equals("name", ignoreCase = true)) {
            item?.setName(currentValue)
        } else if (localName.equals("cost", ignoreCase = true)) {
            item?.setCost(currentValue)
        } else if (localName.equals("description", ignoreCase = true)) {
            item?.setDescription(currentValue)
        } else if (localName.equals("item", ignoreCase = true)) {
            list.add(item)
        }
        //else?
    }

    //To get tag characters
    @Throws(SAXException::class)
    override fun characters(ch: CharArray?, start: Int, length: Int) {
        //super.characters(ch, start, length);
        if (currentElement) {
            currentValue += String(ch!!, start, length)
        }
    }
}