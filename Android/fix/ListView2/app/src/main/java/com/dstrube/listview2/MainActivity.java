package com.dstrube.listview2;

//import android.app.Activity;
//import android.app.ActionBar;
import android.app.Fragment;
import android.app.ListActivity;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;
import android.widget.Toast;
//import android.os.Build;

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

	private ListView listView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        if (savedInstanceState == null) {
            getFragmentManager().beginTransaction()
                    .add(R.id.container, new PlaceholderFragment())
                    .commit();
        }

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
    	listView = (ListView)findViewById(R.layout.simplerow);
    	setContentView(listView);
    	listView.setOnItemClickListener(new OnItemClickListener(){

    	    public void onItemClick(AdapterView<?> parent, View view, int position,
    	            long id) {
    	        Toast.makeText(getBaseContext(), "blah0",Toast.LENGTH_LONG).show();
    	    }

    	});    	
    }
    
    public void itemClick(View view, int position,long id){
    	Toast.makeText(getApplicationContext(), "v", Toast.LENGTH_LONG).show();
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

        public PlaceholderFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_main, container, false);
            return rootView;
        }
    }

}
