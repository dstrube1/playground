package com.example.fragmentdemo.fragmentexercirse;

import android.content.Context;
import android.content.res.TypedArray;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageButton;

import com.example.fragmentdemo.R;

public class ItemListAdapter extends ArrayAdapter<String> {

    //	private static ArrayList<Site> list;
    private LayoutInflater mInflater;
    private String[] mStrings;
    private TypedArray mIcons;
    private FragmentA.Communicator communicator;
    private FragmentA mFragment;
    private int mViewResourceId;

    public ItemListAdapter(Context ctx, int viewResourceId, String[] strings,
                           TypedArray icons, FragmentA fragment) {

        super(ctx, viewResourceId, strings);

        mInflater = (LayoutInflater) ctx
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        mStrings = strings;
        mIcons = icons;
        mFragment = fragment;
        mViewResourceId = viewResourceId;
    }

    @Override
    public int getCount() {
        return mStrings.length;
    }

    @Override
    public String getItem(int position) {

        return mStrings[position];
    }

    @Override
    public long getItemId(int position) {

        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        final int pos = position;
        final ViewHolder holder;
        if (convertView == null) {
            convertView = mInflater.inflate(mViewResourceId, null);
            holder = new ViewHolder();
            holder.imgButton = convertView
                    .findViewById(R.id.imageButton1);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }


        holder.imgButton.setImageDrawable(mIcons.getDrawable(position));
        holder.imgButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                communicator = mFragment.communicator;
                communicator.changeText("http://"+mStrings[pos]+".com");

            }
        });

        return convertView;

    }

    static class ViewHolder {
        ImageButton imgButton;
    }

}
