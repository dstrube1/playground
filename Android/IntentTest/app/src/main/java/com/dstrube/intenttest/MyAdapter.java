package com.dstrube.intenttest;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;

public class MyAdapter extends BaseAdapter {

    private Activity activity;
    private ArrayList<Employee_P> data;
    private static LayoutInflater inflater = null;

    public MyAdapter(Activity a, ArrayList<Employee_P> d) {
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
    public View getView(int position, View convertView, ViewGroup parent) {
        View vi=convertView;
        if(convertView==null) {
            vi = inflater.inflate(R.layout.activity_report_parcelable, null);
        }

//        TextView name = vi.findViewById(R.id.name); // title
//        TextView emailAddress = vi.findViewById(R.id.emailAddress); // artist name
//        TextView phoneNumber = vi.findViewById(R.id.phoneNumber); // duration
//		View row = inflater.inflate(R.layout.employee_view, parent, false);
//        Employee_P employee = data.get(position);
//        name.setText(employee.getName());
//        emailAddress.setText(employee.getEmailAddress());
//        phoneNumber.setText(employee.getPhoneNumber());
        return vi;

    }

}
