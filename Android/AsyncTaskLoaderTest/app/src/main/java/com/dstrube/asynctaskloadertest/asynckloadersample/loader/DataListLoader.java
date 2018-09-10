package com.dstrube.asynctaskloadertest.asynckloadersample.loader;

import java.util.ArrayList;
import java.util.List;

import android.content.AsyncTaskLoader;
import android.content.Context;
//import android.support.v4.content.AsyncTaskLoader;

import com.dstrube.asynctaskloadertest.asynckloadersample.domain.Model;

public class DataListLoader extends AsyncTaskLoader<List<Model>> {

    List<Model> mModels;

    public DataListLoader(Context context) {
        super(context);
    }

    @Override
    public List<Model> loadInBackground() {
        System.out.println("DataListLoader.loadInBackground");

        // You should perform the heavy task of getting data from
        // Internet or database or other source
        // Here, we are generating some Sample data

        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        // Create corresponding array of entries and load with data.
        List<Model> entries = new ArrayList<Model>(5);
        entries.add(new Model("Java", "2"));
        entries.add(new Model("C++", "9"));
        entries.add(new Model("Python", "6"));
        entries.add(new Model("JavaScript", "10"));

        return entries;
    }

    /**
     * Called when there is new data to deliver to the client.  The
     * super class will take care of delivering it; the implementation
     * here just adds a little more logic.
     */
    @Override
    public void deliverResult(List<Model> listOfData) {
//    	super.deliverResult(listOfData);

        System.out.println("deliverResult  >>>>>>.");
        if (isReset()) {
            // An async query came in while the loader is stopped.  We
            // don't need the result.
            if (listOfData != null) {
                onReleaseResources(listOfData);
            }
        }

        List<Model> oldApps = listOfData;
        mModels = listOfData;

        if (isStarted()) {
            // If the Loader is currently started, we can immediately
            // deliver its results.
            super.deliverResult(listOfData);
        }

        // At this point we can release the resources associated with
        // 'oldApps' if needed; now that the new result is delivered we
        // know that it is no longer in use.
        if (oldApps != null) {
            onReleaseResources(oldApps);
        }
    }

    /**
     * Handles a request to start the Loader.
     */
    @Override protected void onStartLoading() {
//    	super.onStartLoading();
        System.out.println("onStartLoading  >>>>>>.");
        if (mModels != null) {
            // If we currently have a result available, deliver it
            // immediately.
            deliverResult(mModels);
        }


        if (takeContentChanged() || mModels == null) {
            // If the data has changed since the last time it was loaded
            // or is not currently available, start a load.
            forceLoad();
        }
    }

    /**
     * Handles a request to stop the Loader.
     */
    @Override protected void onStopLoading() {
//    	super.onStopLoading();
        // Attempt to cancel the current load task if possible.
        System.out.println("onStopLoading  >>>>>>.");
        cancelLoad();
    }

    /**
     * Handles a request to cancel a load.
     */
    @Override public void onCanceled(List<Model> apps) {
        super.onCanceled(apps);

        // At this point we can release the resources associated with 'apps'
        // if needed.
        onReleaseResources(apps);
    }

    /**
     * Handles a request to completely reset the Loader.
     */
    @Override protected void onReset() {
        super.onReset();

        // Ensure the loader is stopped
        onStopLoading();

        // At this point we can release the resources associated with 'apps'
        // if needed.
        if (mModels != null) {
            onReleaseResources(mModels);
            mModels = null;
        }
    }

    /**
     * Helper function to take care of releasing resources associated
     * with an actively loaded data set.
     */
    protected void onReleaseResources(List<Model> apps) {}

}