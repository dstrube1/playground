package com.dstrube.asynctaskloadertest.asynckloadersample;

import java.util.List;

//import org.apache.http.message.BasicNameValuePair;

import android.app.ListFragment;
import android.app.LoaderManager;
import android.content.Loader;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ListView;

import com.dstrube.asynctaskloadertest.asynckloadersample.domain.Model;
import com.dstrube.asynctaskloadertest.asynckloadersample.loader.DataListLoader;

public class DataListFragment extends ListFragment implements LoaderManager.LoaderCallbacks<List<Model>> {

    CustomArrayAdapter mAdapter;

    @Override public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        System.out.println("DataListFragment.onActivityCreated");

        // Initially there is no data
        setEmptyText("No Data Here");

        // Create an empty adapter we will use to display the loaded data.
        mAdapter = new CustomArrayAdapter(getActivity());
        setListAdapter(mAdapter);

        // Start out with a progress indicator.
        setListShown(false);

        // Prepare the loader.  Either re-connect with an existing one,
        // or start a new one.
        getLoaderManager().initLoader(0, null, this);
    }

    @Override
    public void onListItemClick(ListView l, View v, int position, long id) {
        // Insert desired behavior here.
        Log.i("DataListFragment", "Item clicked: " + id);
    }

    @Override
    public Loader<List<Model>> onCreateLoader(int arg0, Bundle arg1) {
        System.out.println("DataListFragment.onCreateLoader");


        return new DataListLoader(getActivity());
    }

    @Override
    public void onLoadFinished(Loader<List<Model>> arg0, List<Model> data) {
        mAdapter.setData(data);
        System.out.println("DataListFragment.onLoadFinished");
        // The list should now be shown.
        if (isResumed()) {
            setListShown(true);
        } else {
            setListShownNoAnimation(true);
        }
    }

    @Override
    public void onLoaderReset(Loader<List<Model>> arg0) {
        mAdapter.setData(null);
    }
}
