package com.dstrube.weblistintent.view;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.dstrube.weblistintent.R;
import com.dstrube.weblistintent.model.LinkData;

public class LinkAdapter extends ArrayAdapter<LinkData> {
	private Context ctx;
	private List<LinkData> linkDataList;

	public LinkAdapter(List<LinkData> linkDataList, Context ctx) {
		super(ctx, R.layout.row_layout, linkDataList);
		this.ctx = ctx;
		this.linkDataList = linkDataList;
	}

	@Override
	public int getCount() {
		return linkDataList.size();
	}

	@Override
	public LinkData getItem(int position) {
		return linkDataList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return linkDataList.get(position).hashCode();
	}
	
	@Override
    public View getView(int position, View convertView, ViewGroup parent) {
       View v = convertView;
       if (convertView == null) {
                               LayoutInflater inflater = (LayoutInflater) ctx.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                               v = inflater.inflate(R.layout.row_layout, null);
       }
       
       TextView linkDomainText = (TextView) v.findViewById(R.id.domain);
//       TextView lName = (TextView) v.findViewById(R.id.url);
       
       LinkData ld = linkDataList.get(position);
       linkDomainText.setText(ld.getDomain());
//       lName.setText(ld.getUrl());
       
       return v;
    
    }
}
