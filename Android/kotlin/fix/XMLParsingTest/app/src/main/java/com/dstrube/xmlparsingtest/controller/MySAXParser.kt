package com.dstrube.xmlparsingtest.controller

import android.util.Log

import com.dstrube.xmlparsingtest.model.MenuItem

import org.xml.sax.XMLReader
import org.xml.sax.InputSource
import org.xml.sax.SAXException

import java.io.IOException
import java.io.InputStream
import java.io.StringReader
import javax.xml.parsers.SAXParser
import javax.xml.parsers.SAXParserFactory
import javax.xml.parsers.ParserConfigurationException

    private var reader: XMLReader? = null
    private var handler: MenuItemXMLHandler = MenuItemXMLHandler()
    private var factory: SAXParserFactory? = null
    private var parser: SAXParser? = null
    private var list: ArrayList<MenuItem?>? = null

    private fun preParse() {

        try {
            factory = SAXParserFactory.newInstance()
            parser = factory?.newSAXParser()
            reader = parser?.xmlReader
            handler = MenuItemXMLHandler()
            reader?.contentHandler = handler
        } catch (e: ParserConfigurationException) {
            e.printStackTrace()
        } catch (e: SAXException) {
            e.printStackTrace()
        }

    }

    private fun postParse(): ArrayList<MenuItem> {
        list = handler.getList()
        val size = list?.size

        for (i in 0 until size!!) {
            val item = list!!.get(i)
            Log.d("", "Menu item id:" + item?.getId()!!)
            Log.d("", "Menu item name:" + item.getName()!!)
            Log.d("", "Menu item cost:" + item.getCost()!!)
        }

        return list
    }

    fun parseString(xml: String): ArrayList<MenuItem> {

        preParse()

        try {

            val input = InputSource()
            input.characterStream = StringReader(xml)

            reader?.parse(input)

            // } catch (ParserConfigurationException e) {
            // e.printStackTrace();
        } catch (e: SAXException) {
            e.printStackTrace()
        } catch (e: IOException) {
            e.printStackTrace()
        }

        return postParse()

    }

    fun parseFile(input: InputStream): ArrayList<MenuItem> {

        try {
            preParse()

            reader?.parse(InputSource(input))

            // } catch (ParserConfigurationException e) {
            // e.printStackTrace();
        } catch (e: SAXException) {
            e.printStackTrace()
        } catch (e: IOException) {
            e.printStackTrace()
        }

        return postParse()
    }
