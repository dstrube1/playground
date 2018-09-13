package com.dstrube.listview2;

import android.app.ListActivity;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

//////////////////
/*
* ListView2
* This time with compound components
* http://androidcookbook.com/Recipe.seam;jsessionid=C0EC047F8349134EE99E8F376C828E3F?recipeId=1418
* ^that URL may expire, in which case, just search for it on that site
*
* 2014-04-10: broken
*/
//////////////////
public class MainActivity extends ListActivity {

    ListView listView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    protected void onResume() {
        super.onResume();
        Context ctx = getApplicationContext();
        Resources res = ctx.getResources();

        String[] options = res.getStringArray(R.array.country_names);
        TypedArray icons = res.obtainTypedArray(R.array.country_icons);

        setListAdapter(new ImageAndTextAdapter(ctx, R.layout.simplerow, options, icons));
        icons.recycle();
        listView = findViewById(R.layout.simplerow);
        setContentView(listView);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener(){

            public void onItemClick(AdapterView<?> parent, View view, int position,
                                    long id) {
                Toast.makeText(getBaseContext(), "blah0",Toast.LENGTH_LONG).show();
            }

        });
    }

    public void itemClick(View view, int position, long id){
        Toast.makeText(getApplicationContext(), "v", Toast.LENGTH_LONG).show();
    }

}
