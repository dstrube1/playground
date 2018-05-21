package com.dstrube.samplesqllite

import android.app.Activity
import android.app.ListActivity
import android.os.Bundle
import android.widget.SimpleAdapter
import android.content.Intent
import android.view.View
import android.widget.TextView
import android.widget.AdapterView
import android.widget.AdapterView.OnItemClickListener



class MainActivity : ListActivity() {

    var animalId: TextView? = null
    var controller = DBController(this)


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        //		ArrayList<HashMap<String, String>> animalList = controller
//				.getAllAnimals();
//		if (animalList.size() != 0) {
//			ListView lv = getListView();
//			lv.setOnItemClickListener(new OnItemClickListener() {
//				@Override
//				public void onItemClick(AdapterView<?> parent, View view,
//						int position, long id) {
//					animalId = (TextView) view.findViewById(R.id.animalId);
//					String valAnimalId = animalId.getText().toString();
//					Intent objIndent = new Intent(getApplicationContext(),
//							EditAnimal.class);
//					objIndent.putExtra("animalId", valAnimalId);
//					startActivity(objIndent);
//				}
//			});
//			ListAdapter adapter = new SimpleAdapter(MainActivity.this,
//					animalList, R.layout.view_animal_entry, new String[] {
//							"animalId", "animalName", "animalTallness" },
//					new int[] { R.id.animalId, R.id.animalName,
//							R.id.animalTallness });
//			setListAdapter(adapter);
//		}
    }

    fun showAddForm(view: View) {
        val objIntent = Intent(applicationContext, NewAnimal::class.java)
        startActivity(objIntent)
    }

    override fun onResume() {
        super.onResume()
        val animalList = controller.getAllAnimals()
        if (animalList.size !== 0) {
            val lv = listView
            lv.onItemClickListener = object : OnItemClickListener {
                override fun onItemClick(parent: AdapterView<*>, view: View,
                                position: Int, id: Long) {
                    animalId = view.findViewById(R.id.animalId) as TextView
                    val valAnimalId = animalId?.text.toString()
                    val objIndent = Intent(applicationContext,
                            EditAnimal::class.java)
                    objIndent.putExtra("animalId", valAnimalId)
                    startActivity(objIndent)
                }
            }
            val adapter = SimpleAdapter(this@MainActivity,
                    animalList, R.layout.view_animal_entry, arrayOf("animalId", "animalName", "animalTallness"),
                    intArrayOf(R.id.animalId, R.id.animalName, R.id.animalTallness))
            listAdapter = adapter
        }
    }
}
