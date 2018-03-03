package com.dstrube.expandablelisttest;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ExpandableListView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private List<String> groupList;
    private HashMap<String, List<String>> childList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ExpandableListView elvis = findViewById(R.id.expandableListView1);

        // preparing list data
        prepareListData();

        MyExpandableListAdapter adapter = new MyExpandableListAdapter(this,
                groupList, childList);

        elvis.setAdapter(adapter);
    }

    private void prepareListData() {
        groupList = new ArrayList<>();
        childList = new HashMap<>();

        // Adding child data
        groupList.add("Top 250");
        groupList.add("Now Showing");
        groupList.add("Coming Soon..");

        // Adding child data
        List<String> top250 = new ArrayList<>();
        top250.add("The Shawshank Redemption");
        top250.add("The Godfather");
        top250.add("The Godfather: Part II");
        top250.add("Pulp Fiction");
        top250.add("The Good, the Bad and the Ugly");
        top250.add("The Dark Knight");
        top250.add("12 Angry Men");

        List<String> nowShowing = new ArrayList<>();
        nowShowing.add("The Conjuring");
        nowShowing.add("Despicable Me 2");
        nowShowing.add("Turbo");
        nowShowing.add("Grown Ups 2");
        nowShowing.add("Red 2");
        nowShowing.add("The Wolverine");

        List<String> comingSoon = new ArrayList<>();
        comingSoon.add("2 Guns");
        comingSoon.add("The Smurfs 2");
        comingSoon.add("The Spectacular Now");
        comingSoon.add("The Canyons");
        comingSoon.add("Europa Report");

        childList.put(groupList.get(0), top250); // Header, Child data
        childList.put(groupList.get(1), nowShowing);
        childList.put(groupList.get(2), comingSoon);
    }

}
