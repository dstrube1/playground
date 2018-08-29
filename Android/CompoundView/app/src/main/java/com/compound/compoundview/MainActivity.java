package com.compound.compoundview;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;

//////////////////
/*
 * CompoundView
 * Doesn't use a ListView;
 * instead, activity_main has multiple instances of an extended LinearLayout class
*/
//////////////////
public class MainActivity extends Activity {

    HeroInfoControl heroLuna;
    HeroInfoControl heroTiny;
    HeroInfoControl heroKael;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        heroLuna = findViewById(R.id.heroLuna);
        heroLuna.setHeroIcon(getResources().getDrawable(R.drawable.ic_launcher));
        heroLuna.setHeroTitle(getResources().getDrawable(R.drawable.capture1));
        heroLuna.setHeroName("Luna Moonfang");
 
        heroTiny = findViewById(R.id.heroTiny);
        heroTiny.setHeroIcon(getResources().getDrawable(R.drawable.ic_launcher));
        heroTiny.setHeroTitle(getResources().getDrawable(R.drawable.capture2));
        heroTiny.setHeroName("Tiny");
 
        heroKael = findViewById(R.id.heroKael);
        heroKael.setHeroIcon(getResources().getDrawable(R.drawable.ic_launcher));
        heroKael.setHeroTitle(getResources().getDrawable(R.drawable.capture3));
        heroKael.setHeroName("Kael");
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
}
