package com.example.fragmentdemo;

import java.util.HashMap;
import java.util.Map;

import android.app.Fragment;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

public class FragmentB extends Fragment {

    static Map<String, Integer> map;
    private static final String TAG = FragmentB.class.getName();

    static {
        map = new HashMap<>();
        map.put("Android", R.drawable.android);
        map.put("iPhone", R.drawable.apple);
        map.put("WindowsMobile", R.drawable.window);
        map.put("Blackberry", R.drawable.bb);
        map.put("WebOS", R.drawable.palm);
        map.put("Ubuntu", R.drawable.ubanto);
        map.put("Windows7", R.drawable.window7);
        map.put("Max OS X", R.drawable.macos);
        map.put("Linux", R.drawable.linux);
        map.put("OS/2", R.drawable.ostwo);
    }

    ImageView imageView;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_b, container, false);
    }


    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        imageView = getActivity().findViewById(R.id.imageView1);
    }

    public void changeText(String selection) {
        Log.i(TAG, "changeText");
        imageView.setImageResource(map.get(selection));
    }
}
