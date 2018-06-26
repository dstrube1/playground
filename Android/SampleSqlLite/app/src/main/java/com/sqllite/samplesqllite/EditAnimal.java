package com.sqllite.samplesqllite;

import java.util.HashMap;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

public class EditAnimal extends Activity {
    EditText animalName;
    EditText animalTallness;
    DBController controller = new DBController(this);

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_animal);
        animalName = findViewById(R.id.animalName);
        animalTallness = findViewById(R.id.animalTallness);
        Intent objIntent = getIntent();
        String animalId = objIntent.getStringExtra("animalId");
        Log.d("Reading: ", "Reading animals...");
        HashMap<String, String> animalList = controller.getAnimalInfo(animalId);
        Log.d("animalName", animalList.get("animalName"));
        Log.d("animalTallness", animalList.get("animalTallness"));
        if (animalList.size() != 0) {
            animalName.setText(animalList.get("animalName"));
            animalTallness.setText(animalList.get("animalTallness"));
        }
    }

    public void editAnimal(View view) {
        HashMap<String, String> queryValues = new HashMap<String, String>();
        animalName = findViewById(R.id.animalName);
        animalTallness = findViewById(R.id.animalTallness);

        Intent objIntent = getIntent();
        String animalId = objIntent.getStringExtra("animalId");
        queryValues.put("animalId", animalId);
        queryValues.put("animalName", animalName.getText().toString());
        queryValues.put("animalTallness", animalTallness.getText().toString());

        controller.updateAnimal(queryValues);
        this.callHomeActivity(view);

    }

    public void removeAnimal(View view) {
        Intent objIntent = getIntent();
        String animalId = objIntent.getStringExtra("animalId");
        controller.deleteAnimal(animalId);
        this.callHomeActivity(view);

    }

    public void callHomeActivity(View view) {
        Intent objIntent = new Intent(getApplicationContext(), MainActivity.class);
        startActivity(objIntent);
    }
}

