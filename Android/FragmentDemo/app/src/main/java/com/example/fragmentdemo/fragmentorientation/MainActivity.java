package com.example.fragmentdemo.fragmentorientation;

import android.app.Activity;
import android.app.Fragment;
import android.content.Context;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.example.fragmentdemo.R;

import java.util.ArrayList;

//////////////////
/*
 * FragmentOrientation
 * Show text boxes and a button in Portrait,
 * Show a ListView of Names and Descriptions in Landscape
 */
//////////////////
public class MainActivity extends Activity {

    private String state;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_orientation);

//        if (savedInstanceState == null) {
//            getSupportFragment«Manager().beginTransaction()
//                    .add(R.id.container, new PlaceholderFragment()).commit();
//        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        ListView listView = findViewById(R.id.listView1);
        Context ctx = getApplicationContext();
        Resources res = ctx.getResources();
        String[] names = res.getStringArray(R.array.names);
        String[] descriptions = res.getStringArray(R.array.descriptions);

        ArrayList<ListObject> list = new ArrayList<>();
        for (int i = 0; i < names.length; i++) {
            ListObject L = new ListObject(names[i], descriptions[i]);
            list.add(L);
        }

        try{
            if (list != null) {
                MyAdapter adapter = new MyAdapter(this, list);

                listView.setAdapter(adapter);
            }
        }catch(Exception e){
            //Toast.makeText(getApplicationContext(), e.toString(), Toast.LENGTH_LONG).show();
        }
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        state = "Saving Instance..";
        System.out.println(state);
//		Toast.makeText(getApplicationContext(), state, Toast.LENGTH_SHORT).show();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        state = "Destroying...";
        System.out.println(state);
//		Toast.makeText(getApplicationContext(), state, Toast.LENGTH_SHORT).show();
    }

    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);
        state = "Restoring Instance..";
        System.out.println(state);
//		Toast.makeText(getApplicationContext(), state, Toast.LENGTH_SHORT).show();
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

        public PlaceholderFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                                 Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_main_orientation, container,
                    false);
            return rootView;
        }
    }

}
