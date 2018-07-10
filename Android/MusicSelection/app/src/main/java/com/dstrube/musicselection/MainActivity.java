package com.dstrube.musicselection;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;

//////////////////
/*
* MusicSelection
* shows 3 compound views (image button, text view, text view), representing album image, album name, song name
* a- \res\layout\fragment_main[_old].xml is the one that works this way
* b- \res\layout\fragment_main[_new_listview].xml is the one that tries this with ListView
* a- comment lines like this:
* 	av1 = new AlbumView(getApplicationContext());
* and uncomment lines like this:
* 	av1 = (AlbumView)findViewById(R.id.albumview1);
* b- vice versa [a]
* 2014-04-08:  not working, but i feel i'm close
*/
//////////////////
public class MainActivity extends AppCompatActivity {

//    private AlbumView av1, av2, av3;
//    private ListView listView ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    protected void onResume() {
        super.onResume();

		final ListView listView = findViewById(R.id.list);
		final AlbumView av1;// = new AlbumView(getApplicationContext());//may need attribute set
		final AlbumView av2;// = new AlbumView(getApplicationContext());
		final AlbumView av3;// = new AlbumView(getApplicationContext());
    	av1 = findViewById(R.id.albumview1);
    	av1.setAlbumImage("album1");
    	av1.setAlbumName("Kerosene Hat");
    	av1.setSongName("Lonesome Johnny Blues");
    	av2 = findViewById(R.id.albumview2);
    	av2.setAlbumImage("album2");
    	av2.setAlbumName("To Bring You My Love");
    	av2.setSongName("Teclo");
    	av3 = findViewById(R.id.albumview3);
    	av3.setAlbumImage("album3");
    	av3.setAlbumName("Big Time");
    	av3.setSongName("Train Song");
		final AlbumView[] values = new AlbumView[]{av1,av2,av3};
		final ArrayAdapter<AlbumView> adapter = new ArrayAdapter<>(this,
    	        android.R.layout.simple_list_item_1, //R.layout.album_view, <- breaks, but seems like on the right track
    	        values);
    	listView.setAdapter(adapter);

		final Context ctx = getApplicationContext();
		final Resources res = ctx.getResources();
		final TypedArray albumImages = res.obtainTypedArray(R.array.albumImages);
		final String[] albumNames = res.getStringArray(R.array.albumNames);
		final String[] songNames = res.getStringArray(R.array.songNames);
        listView.setAdapter(new AlbumViewAdapter(ctx,
                R.layout.album_view, albumImages, albumNames,songNames));

    }
}
