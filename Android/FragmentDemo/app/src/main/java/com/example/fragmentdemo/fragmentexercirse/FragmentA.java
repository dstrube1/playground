package com.example.fragmentdemo.fragmentexercirse;

import android.app.Fragment;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.example.fragmentdemo.R;

public class FragmentA extends Fragment {

    ListView listView;
    Communicator communicator;
    String[] options;
    TypedArray icons;

    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_a, container, false);
    }

    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        listView = (ListView) getActivity().findViewById(R.id.listView);

        Resources res = getView().getContext().getResources();
        options = res.getStringArray(R.array.logo_names);
        icons = res.obtainTypedArray(R.array.logo_drawables);

        ItemListAdapter adapter = new ItemListAdapter(getView().getContext(),
                R.layout.list_layout, options, icons, this);
        listView.setAdapter(adapter);

        //make sure this doesn't break anything:
        icons.recycle();
        /*
         * listView.setOnItemClickListener(new OnItemClickListener() {
         *
         * @Override public void onItemClick(AdapterView<?> arg0, View arg1, int
         * position, long id) {
         * communicator.changeText("http://"+options[position]+".com"); } });
         */
    }

    public void setCommunicator(Communicator comm) {
        this.communicator = comm;
    }

    public interface Communicator {
        public void changeText(String itemSelect);
    }

}
