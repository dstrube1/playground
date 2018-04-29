package com.dstrube.xmlparsingtest.controller

import android.app.ListActivity
import android.os.Bundle
import android.widget.Toast
import android.widget.SimpleAdapter
//import android.support.test.orchestrator.junit.BundleJUnitUtils.getDescription
//import com.sun.deploy.net.HttpResponse
import java.io.IOException
import java.io.UnsupportedEncodingException
//import javax.xml.bind.DatatypeConverter.parseString
import android.os.AsyncTask
import com.dstrube.xmlparsingtest.R
import org.apache.http.client.ClientProtocolException
import org.apache.http.client.methods.HttpPost
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils


class MainActivity : ListActivity() {

    private val url = "http://api.androidhive.info/pizza/?format=xml"
    // private final String KEY_ITEM = "item"; // parent node
    private val KEY_ID = "id"
    private val KEY_NAME = "name"
    private val KEY_COST = "cost"
    private val KEY_DESC = "description"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onResume() {
        super.onResume()
    }

    fun networkCallDone(
            list: ArrayList<com.dstrube.xmlparsingtest.model.MenuItem>) {
        Toast.makeText(applicationContext, "Network call done!",
                Toast.LENGTH_SHORT).show()
    }

    private fun populateListView(
            list: ArrayList<com.dstrube.xmlparsingtest.model.MenuItem>) {
        // from SimpleAdapterTest:
        // ListView listView = (ListView) findViewById(R.id.listView);
        // String[] from = new String[] { "name", "cost", "description" };
        // int[] to = new int[] { R.id.name, R.id.cost, R.id.desciption};
        // SimpleAdapter adapter = new SimpleAdapter(this, (List<? extends
        // Map<String, ?>>) list, R.layout.list_item, from, to);
        // listView.setAdapter(adapter);

        val menuItems = ArrayList<HashMap<String, String?>>()
        for (i in 0 until list.size ){
            val map = HashMap<String, String?>()
            // Element e = (Element) list.get(i);
            // adding each child node to HashMap key => value
            map[KEY_ID] = list[i].getId()
            map[KEY_NAME] = list[i].getName()
            map[KEY_COST] = list[i].getCost()
            map[KEY_DESC] = list[i].getDescription()

            // adding HashList to ArrayList
            menuItems.add(map)
        }
        // Adding menuItems to ListView
        val adapter = SimpleAdapter(this, menuItems,
                R.layout.list_item,
                arrayOf(KEY_NAME, KEY_DESC, KEY_COST), intArrayOf(R.id.name, R.id.desciption, R.id.cost))

        listAdapter = adapter

        // selecting single ListView item
        // ListView lv = getListView();
    }

    fun getXmlFromUrl(url: String): String {
        var xml = ""

        try {
            // defaultHttpClient
            val httpClient = DefaultHttpClient()
            val httpPost = HttpPost(url)

            val httpResponse = httpClient.execute(httpPost)
            val httpEntity = httpResponse.getEntity()
            xml = EntityUtils.toString(httpEntity)

        } catch (e: UnsupportedEncodingException) {
            e.printStackTrace()
        } catch (e: ClientProtocolException) {
            e.printStackTrace()
        } catch (e: IOException) {
            e.printStackTrace()
        }

        // return XML
        return xml
    }

    private inner class NetworkXMLCall : AsyncTask<Void, Void, ArrayList<com.dstrube.xmlparsingtest.model.MenuItem>>() {
        override fun doInBackground(
                vararg params: Void): ArrayList<com.dstrube.xmlparsingtest.model.MenuItem>? {
            var list: ArrayList<com.dstrube.xmlparsingtest.model.MenuItem>? = null
            try {
                val input = assets.open("test0.xml")
                list = MySAXParser.parseFile(input)
            } catch (e: IOException) {
                e.printStackTrace()
            } catch (e: Exception) {
                e.printStackTrace()
            }

            if (list == null || list.size === 0) {
                try {
                    val xml = getXmlFromUrl(url)

                    list = MySAXParser.parseString(xml)
                } catch (e: Exception) {
                    e.printStackTrace()
                }

            }
            return list
        }

        override fun onPostExecute(
                result: ArrayList<com.dstrube.xmlparsingtest.model.MenuItem>) {
            // super.onPostExecute(result);
            // networkCallDone(result);
            populateListView(result)
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

}
