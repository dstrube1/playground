package com.dstrube.musicselection;

import android.content.Context;
import android.content.res.TypedArray;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

public class AlbumViewAdapter extends BaseAdapter {

    private LayoutInflater inflater;
//    private TypedArray albumImages;
//    private String[] albumNames;
//    private String[] songNames;

    public AlbumViewAdapter(Context context, int viewResourceId, TypedArray albumImages, String[] albumNames, String[] songNames) {
        inflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
//        this.albumImages = albumImages;
//        this.albumNames = albumNames;
//        this.songNames = songNames;
    }

    @Override
    public int getCount() {
        //
        return 0;
    }

    @Override
    public Object getItem(int position) {
        //
        return null;
    }

    @Override
    public long getItemId(int position) {
        //
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View row = inflater.inflate(R.layout.album_view, parent, false);
        return row;
    }
}
