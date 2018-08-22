package com.test.custonlistview;

import java.util.ArrayList;

import com.test.customList.network.MusicVO;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class LazyAdapter extends BaseAdapter {

    private Activity activity;
    private ArrayList<MusicVO> data;
    private static LayoutInflater inflater = null;
    private ImageLoader imageLoader;

    public LazyAdapter(Activity a, ArrayList<MusicVO> d) {
        activity = a;
        data = d;
        inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        imageLoader = new ImageLoader(activity.getApplicationContext());
    }

    public int getCount() {
        return data.size();
    }

    public Object getItem(int position) {
        return position;
    }

    public long getItemId(int position) {
        return position;
    }

    public View getView(int position, View convertView, ViewGroup parent) {

        View vi = convertView;
        if (convertView == null)
            vi = inflater.inflate(R.layout.list_row, null);

        TextView title = vi.findViewById(R.id.title); // title
        TextView artist = vi.findViewById(R.id.artist); // artist name
        TextView duration = vi.findViewById(R.id.duration); // duration
        ImageView thumb_image = vi.findViewById(R.id.list_image); // thumb image

        MusicVO song = data.get(position);

        // Setting all values in list view
        System.out.println("Inside Get View >>>>>>  " + song.getTitle() + "   >> " + song.getArtist());
        title.setText(song.getTitle());
        artist.setText(song.getArtist());
        duration.setText(song.getDuration());
        imageLoader.DisplayImage(song.getThumb_Url(), thumb_image);
        return vi;
    }
}