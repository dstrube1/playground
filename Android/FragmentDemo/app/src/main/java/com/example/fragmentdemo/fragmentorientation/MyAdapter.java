package com.example.fragmentdemo.fragmentorientation;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.example.fragmentdemo.R;

import java.util.ArrayList;

public class MyAdapter extends BaseAdapter {

    private Activity activity;
    private ArrayList<ListObject> data;
    private static LayoutInflater inflater = null;

    public MyAdapter(Activity a, ArrayList<ListObject>  d) {
        activity = a;
        data=d;
        inflater = (LayoutInflater)activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
    }

    @Override
    public int getCount() {
        return data.size();
    }

    @Override
    public Object getItem(int position) {
        return data.get(position);
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(int position, View adapterView, ViewGroup parent) {
        if(adapterView == null)
            adapterView = inflater.inflate(R.layout.list_object_view_orientation, null);

        TextView name = adapterView.findViewById(R.id.name); // title
        TextView description = adapterView.findViewById(R.id.description); // artist name
        ListObject listObject = data.get(position);
        name.setText(listObject.getName());
        description.setText(listObject.getDescription());
        return adapterView;
    }

}
