package com.dstrube.weblistintent.controller;

import com.dstrube.weblistintent.R;
//import com.dstrube.weblistintent.R.id;
//import com.dstrube.weblistintent.R.layout;
//import com.dstrube.weblistintent.R.menu;
import com.dstrube.weblistintent.view.ContentFragment;

import android.app.Activity;
//import android.app.ActionBar;
import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
//import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
//import android.os.Build;

public class MainActivity extends Activity implements ChangeLinkListener{

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (savedInstanceState == null) {
            getFragmentManager().beginTransaction()
                    .add(R.id.container, new PlaceholderFragment())
                    .commit();
        }
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

	@Override
	public void onLinkChange(String link) {
		if (findViewById(R.id.contentFragment) != null) {
			ContentFragment contentFragment = (ContentFragment) getFragmentManager().findFragmentById(R.id.contentFragment);
			if (contentFragment == null) {
				contentFragment = new ContentFragment();
				contentFragment.init(link);
				// We are in dual fragment (Tablet or phone landscape)
				FragmentManager fm = getFragmentManager();
				FragmentTransaction ft = fm.beginTransaction();

				// contentFragment.updateUrl(link);
				ft.replace(R.id.contentFragment, contentFragment);
				ft.commit();
			} else {
				contentFragment.updateUrl(link);
			}
		} else {
			Intent i = new Intent(this, ContentFragmentActivity.class);
			i.putExtra("link", link);
			startActivity(i);
		}

	}

}
