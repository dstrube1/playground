package com.dstrube.samplesqllite

import android.content.Intent
import android.content.Intent.getIntent
import android.widget.EditText
import android.os.Bundle
import android.app.Activity
import android.util.Log
import android.view.View


class EditAnimal : Activity() {
    internal var animalName: EditText? = null
    internal var animalTallness: EditText? = null
    internal var controller = DBController(this)
    public override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_edit_animal)
        animalName = findViewById(R.id.animalName)
        animalTallness = findViewById(R.id.animalTallness)
        val objIntent = intent
        val animalId = objIntent.getStringExtra("animalId")
        Log.d("Reading: ", "Reading animals...")
        val animalList = controller.getAnimalInfo(animalId)
        Log.d("animalName", animalList.get("animalName"))
        Log.d("animalTallness", animalList.get("animalTallness"))
        if (animalList.size !== 0) {
            animalName?.setText(animalList.get("animalName"))
            animalTallness?.setText(animalList.get("animalTallness"))
        }
    }

    fun editAnimal(view: View) {
        val queryValues = HashMap<String, String>()
        animalName = findViewById(R.id.animalName)
        animalTallness = findViewById(R.id.animalTallness)

        val objIntent = intent
        val animalId = objIntent.getStringExtra("animalId")
        queryValues["animalId"] = animalId
        queryValues["animalName"] = animalName?.text.toString()
        queryValues["animalTallness"] = animalTallness?.text.toString()

        controller.updateAnimal(queryValues)
        this.callHomeActivity(view)

    }

    fun removeAnimal(view: View) {
        val objIntent = intent
        val animalId = objIntent.getStringExtra("animalId")
        controller.deleteAnimal(animalId)
        this.callHomeActivity(view)

    }

    fun callHomeActivity(view: View) {
        val objIntent = Intent(applicationContext, MainActivity::class.java)
        startActivity(objIntent)
    }
}

