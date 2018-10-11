package com.dstrube.instagramtest;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.BaseAdapter;

import com.android.volley.toolbox.NetworkImageView;

import java.util.ArrayList;

public class InstagramAdapter extends BaseAdapter
        implements InstagramDataSource.OnDataChangedListener, AbsListView.OnScrollListener {

    private ArrayList<String> imagesUrls;
    private int screenSize;
    Context context;
    InstagramDataSource instagramDataSource;

    public InstagramAdapter(Context context, InstagramDataSource instagramDataSource, int screenSize){
        super();
        this.screenSize = screenSize;
        this.instagramDataSource = instagramDataSource;
        this.context = context;
        imagesUrls = instagramDataSource.getImagesUrls();
        instagramDataSource.setOnDataChangedListener(this);
    }

    //
    //Customs adapter usual methods
    //
    @Override
    public int getCount() {
        if(imagesUrls == null) return 0;
        return imagesUrls.size();
    }
    @Override
    public Object getItem(int position) {
        if(imagesUrls == null) return null;
        return imagesUrls.get(position);
    }
    @Override
    public long getItemId(int position) {
        return 0;
    }

    //
    //GetView designed to recycle View objects, volley take care of how images a loaded
    //
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        NetworkImageView image; //using the volley NetworkImageView as view
        if(convertView == null){
            image = new NetworkImageView(this.context);
        }else{
            image = (NetworkImageView)convertView;
        }
        setImageSize(image, position);
        image.setImageUrl(imagesUrls.get(position), App.getImageLoader());
        return image;
    }

    public void setImageSize(NetworkImageView image, int position){
        int size = screenSize;
        if(imageIsSmall(position)) size = size / 2;
        size = size - (int)(size * .05);
        image.setMaxHeight(size);
        image.setMinimumHeight(size);
        image.setMinimumWidth(size);
        image.setMinimumHeight(size);
    }

    public boolean imageIsSmall(int position){
        if(position % 3 == 0)return false;
        return true;
    }

    //
    //Listen to changes on the data source
    //
    @Override
    public void onDataChanged() {
        notifyDataSetChanged();
    }

    //
    //This handle the scroll to request more data
    //
    @Override
    public void onScrollStateChanged(AbsListView view, int scrollState) {
    }

    @Override
    public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount, int totalItemCount) {
        int count = getCount();
        if(count == 0) return;

        if(firstVisibleItem > count - 10 && !instagramDataSource.isLoading())
            instagramDataSource.getMoreData();
    }

}
