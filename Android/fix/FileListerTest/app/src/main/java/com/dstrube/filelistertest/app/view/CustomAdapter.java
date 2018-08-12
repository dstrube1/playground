package com.dstrube.filelistertest.app.view;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.dstrube.filelistertest.app.R;
import com.dstrube.filelistertest.app.model.MyFile;

import java.util.ArrayList;

/**
 * Created by unbounded on 6/9/2014.
 */
public class CustomAdapter extends BaseAdapter {

    // does this need to be static?
    private ArrayList<MyFile> list;
    private LayoutInflater inflater;

    public CustomAdapter(Context context, ArrayList<MyFile> list) {
        this.list = list;
        inflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        return list.size();
    }

    @Override
    public Object getItem(int position) {
        return list.get(position);
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder;
        if (convertView != null) {
            holder = (ViewHolder) convertView.getTag();
        } else {
            convertView = inflater.inflate(R.layout.file_view, null);
            holder = new ViewHolder();
            holder.txt_fileName = (TextView) convertView
                    .findViewById(R.id.fileName);
            holder.txt_filePath = (TextView) convertView
                    .findViewById(R.id.filePath);
            holder.txt_fileIsDir = (TextView) convertView
                    .findViewById(R.id.fileIsDir);
            holder.txt_fileModifiedDate = (TextView) convertView
                    .findViewById(R.id.fileModifiedDate);
            convertView.setTag(holder);
        }

        holder.txt_fileName.setText(list.get(position).getName());
        holder.txt_filePath.setText(list.get(position).getPath());
        if (list.get(position).getIsDir()) {
            holder.txt_fileIsDir.setText("Directory");
            holder.txt_fileIsDir.setTextColor(Color.RED);
        } else {
            holder.txt_fileIsDir.setText("File");
            holder.txt_fileIsDir.setTextColor(Color.GREEN);
        }
        holder.txt_fileModifiedDate.setText(list.get(position).getModifiedDate());

        return convertView;
    }

    // This is from the CustomListView project
    // static instead of private?
    private class ViewHolder {
        TextView txt_fileName;
        TextView txt_filePath;
        TextView txt_fileIsDir;
        TextView txt_fileModifiedDate;
    }
}
