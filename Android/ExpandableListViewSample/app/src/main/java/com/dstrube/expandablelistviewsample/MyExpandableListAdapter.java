package com.dstrube.expandablelistviewsample;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseExpandableListAdapter;
import android.widget.ExpandableListView;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

/**
 * Created on 6/11/2014.
 */
public class MyExpandableListAdapter extends BaseExpandableListAdapter {
    private Context mContext;
    private ExpandableListView mExpandableListView;
    private List<GroupEntity> mGroupCollection;
    private int[] groupStatus;

    public MyExpandableListAdapter(Context pContext,
                                   ExpandableListView pExpandableListView,
                                   List<GroupEntity> pGroupCollection) {
        mContext = pContext;
        mGroupCollection = pGroupCollection;
        mExpandableListView = pExpandableListView;
        groupStatus = new int[mGroupCollection.size()];

        setListEvent();
    }

    private void setListEvent() {

        mExpandableListView
                .setOnGroupExpandListener(new ExpandableListView.OnGroupExpandListener() {

                    @Override
                    public void onGroupExpand(int arg0) {
                        // TODO Auto-generated method stub
                        groupStatus[arg0] = 1;
                    }
                });

        mExpandableListView
                .setOnGroupCollapseListener(new ExpandableListView.OnGroupCollapseListener() {

                    @Override
                    public void onGroupCollapse(int arg0) {
                        // TODO Auto-generated method stub
                        groupStatus[arg0] = 0;
                    }
                });
    }

    @Override
    public String getChild(int arg0, int arg1) {
        return mGroupCollection.get(arg0).GroupItemCollection.get(arg1).Name;
    }

    @Override
    public long getChildId(int arg0, int arg1) {
        return 0;
    }

    @Override
    public View getChildView(int arg0, int arg1, boolean arg2, View arg3,
                             ViewGroup arg4) {

        ChildHolder childHolder;
        if (arg3 == null) {
            arg3 = LayoutInflater.from(mContext).inflate(
                    R.layout.list_item, null);

            childHolder = new ChildHolder();

            childHolder.title = arg3.findViewById(R.id.item_title);
            arg3.setTag(childHolder);
        } else {
            childHolder = (ChildHolder) arg3.getTag();
        }

        childHolder.title.setText(mGroupCollection.get(arg0).GroupItemCollection.get(arg1).Name);
        return arg3;
    }

    @Override
    public int getChildrenCount(int arg0) {
        return mGroupCollection.get(arg0).GroupItemCollection.size();
    }

    @Override
    public Object getGroup(int arg0) {
        return mGroupCollection.get(arg0);
    }

    @Override
    public int getGroupCount() {
        return mGroupCollection.size();
    }

    @Override
    public long getGroupId(int arg0) {
        return arg0;
    }

    @Override
    public View getGroupView(int arg0, boolean arg1, View arg2, ViewGroup arg3) {
        // TODO Auto-generated method stub
        GroupHolder groupHolder;
        if (arg2 == null) {
            arg2 = LayoutInflater.from(mContext).inflate(R.layout.list_group,
                    null);
            groupHolder = new GroupHolder();
            groupHolder.img = arg2.findViewById(R.id.tag_img);
            groupHolder.title = arg2.findViewById(R.id.group_title);
            arg2.setTag(groupHolder);
        } else {
            groupHolder = (GroupHolder) arg2.getTag();
        }
        if (groupStatus[arg0] == 0) {
            groupHolder.img.setImageResource(R.drawable.group_down);
        } else {
            groupHolder.img.setImageResource(R.drawable.group_up);
        }
        groupHolder.title.setText(mGroupCollection.get(arg0).Name);

        return arg2;
    }

    class GroupHolder {
        ImageView img;
        TextView title;
    }

    class ChildHolder {
        TextView title;
    }

    @Override
    public boolean hasStableIds() {
        return true;
    }

    @Override
    public boolean isChildSelectable(int arg0, int arg1) {
        return true;
    }
}
