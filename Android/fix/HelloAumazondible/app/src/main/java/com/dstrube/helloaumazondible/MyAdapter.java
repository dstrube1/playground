package com.dstrube.helloaumazondible;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.BaseAdapter;

import com.android.volley.toolbox.NetworkImageView;

import java.util.ArrayList;

public class MyAdapter extends BaseAdapter implements MyDataSource.OnDataChangedListener,
        AbsListView.OnScrollListener {

    private ArrayList<String> imagesUrls;
    private int screenSize;
    private Context context;
    private MyDataSource dataSource;

    public MyAdapter(Context context, MyDataSource dataSource, int screenSize) {
        super();
        this.screenSize = screenSize;
        this.dataSource = dataSource;
        this.context = context;
        imagesUrls = dataSource.getImagesUrls();
        this.dataSource.setOnDataChangedListener(this);
    }

    public void setImageSize(NetworkImageView networkImageView, int pos) {
        int size = screenSize;
        if (imageIsSmall(pos))
            size = size / 2;
        size = size - (int) (size * .05);
        networkImageView.setMaxHeight(size);
        networkImageView.setMinimumHeight(size);
        networkImageView.setMinimumWidth(size);
        networkImageView.setMinimumHeight(size);
    }

    public boolean imageIsSmall(int pos) {
        if (pos % 3 == 0)
            return false;
        return true;
    }

    //
    // Overriding adapter methods
    //
    @Override
    public int getCount() {
        if (imagesUrls != null) {
            return imagesUrls.size();
        }
        return 0;
    }

    @Override
    public Object getItem(int pos) {
        if (imagesUrls != null) {
            return imagesUrls.get(pos);
        }
        return null;
    }

    @Override
    public long getItemId(int pos) {
        return 0;
    }

    @Override
    public View getView(int pos, View convertView, ViewGroup parent) {
        // volley NetworkImageView
        NetworkImageView networkImageView;
        if (convertView != null) {
            networkImageView = (NetworkImageView) convertView;
        } else {
            networkImageView = new NetworkImageView(this.context);
        }
        setImageSize(networkImageView, pos);
        networkImageView.setImageUrl(imagesUrls.get(pos),
                MyApplication.getImageLoader());
        return networkImageView;
    }

    @Override
    public void onDataChanged() {
        notifyDataSetChanged();
    }

    @Override
    public void onScrollStateChanged(AbsListView view, int scrollState) {
    }

    @Override
    public void onScroll(AbsListView view, int firstVisibleItem,
                         int visibleItemCount, int totalItemCount) {
        int count = getCount();
        if (count == 0) {
            return;
        } else if (firstVisibleItem > count - 10 && !dataSource.isLoading()) {
            dataSource.getMoreData();
        }
    }
}
