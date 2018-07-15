package com.dstrube.jsontest_postdb_prenotification.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


//import android.R;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

import com.dstrube.jsontest_postdb_prenotification.R;
import com.dstrube.jsontest_postdb_prenotification.service.ImageLoader;

//This is the adapter for the list view
public class CustomAdapter extends SimpleAdapter {

    private ArrayList<HashMap<String, String>> mData;
    // private int mViewResourceId;

    private Context ctx;
    private LayoutInflater mInflater;

    // Constructor
    // Warning suppressed for the data conversion from List to ArrayList
    @SuppressWarnings("unchecked")
    public CustomAdapter(Context context, List<? extends Map<String, ?>> data,
                         int resource, String[] from, int[] to) {
        super(context, data, resource, from, to);
        // mViewResourceId = resource;
        ctx = context;
        mInflater = (LayoutInflater) ctx
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        mData = (ArrayList<HashMap<String, String>>) data;
    }

    // Get count of items in the list
    @Override
    public int getCount() {
        return mData.size();
    }

    // Get item in the list
    @Override
    public Object getItem(int position) {
        return mData.get(position);
    }

    // Get item id of item in the list
    @Override
    public long getItemId(int position) {
        return super.getItemId(position);
    }

    // Get the View for displaying the list view
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        // return super.getView(position, convertView, parent);
        View view;
        final String TAG_LASTNAME = "lastName";
        final String TAG_FIRSTNAME = "firstName";
        // final String TAG_NAME = "name";
        final String TAG_EMAIL = "email";
        final String TAG_TITLE = "title";
        final String TAG_THUMB_URL = "thumbUrl";

        if (convertView == null) {
            view = mInflater.inflate(com.dstrube.jsontest_postdb_prenotification.R.layout.list_item,
                    parent, false);
        } else {
            view = convertView;
        }
        @SuppressWarnings("unchecked")
        HashMap<String, String> map = (HashMap<String, String>) getItem(position);
        TextView firstNameView = view.findViewById(R.id.fName);
        TextView lastNameView = view.findViewById(R.id.lName);
        TextView emailView = view.findViewById(R.id.email);
        TextView titleView = view.findViewById(R.id.title);
        ImageView thumb = view.findViewById(R.id.thumb);

        firstNameView.setText(map.get(TAG_FIRSTNAME));
        lastNameView.setText(map.get(TAG_LASTNAME));
        emailView.setText(map.get(TAG_EMAIL));
        titleView.setText(map.get(TAG_TITLE));
        // does this work?
        // Uri uri = Uri.parse(map.get(TAG_THUMB_URL));
        // thumb.setImageURI(uri);
        // no, of course not, that would be too easy -_-

        // this would take time:
        // thumb.setImageBitmap(map.get(TAG_THUMB_URL));

        // quick, dirty and ugly:
        Context ctx = view.getContext();
        // Resources res = ctx.getResources();
        //
        // TypedArray icons = res.obtainTypedArray(R.array.face_icons);
        // int index = 0;
        // if (map.get(TAG_FIRSTNAME).contains("e")){
        // index=1;
        // }
        // setImageResource(R.drawable.face1);//
        // Drawable drawable = res.getDrawable(R.drawable.face2);
        // setImageDrawable(drawable);
        // thumb.setImageDrawable(icons.getDrawable(index));
        // icons.recycle();

        /*
         * and that doesn't work either
         *
         * notes:
         * should be good enough:
         * com.dstrube.listview2
         * iv.setImageDrawable
         *
         * good:
         * com.store.externalstoragefile
         * MainActivity Bitmap bitmap =
         * BitmapFactory.decodeFile(filePath); imageView.setImageBitmap(bitmap);
         *
         * see also:
         * com.dstrube.intentserviceimagedownloader
         * image.setImageBitmap(bitmap)
         *
         * insane / hardcore expert:
         * com.test.custonlistview
         * LazyAdapter
         * getView
         * imageLoader.DisplayImage(song.getThumb_Url(), thumb_image);
         *
         * let's do this:
         */
        System.out.println("Almost at the end of CustomAdapter getView...");
        ImageLoader imageLoader = new ImageLoader(ctx);
        imageLoader.DisplayImage(map.get(TAG_THUMB_URL), thumb);
        System.out.println("At the end of CustomAdapter getView.");
        return view;
    }

}
