package com.dstrube.expandablelistviewsample;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.ExpandableListAdapter;
import android.widget.ExpandableListView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends Activity {

//    private  mExpandableListView;
    private List<GroupEntity> mGroupCollection;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        prepareResource();
        initPage();
    }

    private void prepareResource() {

        mGroupCollection = new ArrayList<>();

        for (int i = 1; i < 6; i++) {
            GroupEntity ge = new GroupEntity();
            ge.Name = "Group" + i;

            for (int j = 1; j < 5; j++) {
                GroupEntity.GroupItemEntity gi = ge.new GroupItemEntity();
                gi.Name = "Child" + j;
                ge.GroupItemCollection.add(gi);
            }

            mGroupCollection.add(ge);
        }

    }

    private void initPage() {
        final ExpandableListView mExpandableListView = findViewById(R.id.expandableListView);
        //MyExpandableListAdapter is my local concrete class, ExpandableListAdapter is an abstract class
        //if this app doesn't work, this line may be why
        ExpandableListAdapter adapter = new MyExpandableListAdapter(this,mExpandableListView, mGroupCollection);

        mExpandableListView.setAdapter(adapter);

        mExpandableListView.setOnChildClickListener(new ExpandableListView.OnChildClickListener() {

            @Override
            public boolean onChildClick(ExpandableListView parent, View v,
                                        int groupPosition, int childPosition, long id) {
                Toast.makeText(getApplicationContext(), "Clicked", Toast.LENGTH_SHORT).show();
                return false;
            }
        });
    }
}
