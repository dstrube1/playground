package com.dstrube.phonerecord.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dstrube.phonerecord.R;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SimpleAdapter;
import android.widget.TextView;

public class CustomAdapter extends SimpleAdapter {

	private ArrayList<HashMap<String, String>> data;
	private Context context;
	private LayoutInflater inflater;

	@SuppressWarnings("unchecked")
	public CustomAdapter(Context context, List<? extends Map<String, ?>> data,
			int resource, String[] from, int[] to) {
		super(context, data, resource, from, to);

		inflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		this.data = (ArrayList<HashMap<String, String>>) data;
		this.context = context;
	}

	// Get count of items in the list
	@Override
	public int getCount() {
		return data.size();
	}

	// Get item in the list
	@Override
	public Object getItem(int position) {
		return data.get(position);
	}

	// Get item id of item in the list
	@Override
	public long getItemId(int position) {
		return super.getItemId(position);
	}

	@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			View view;
			if (convertView == null) {
				view = inflater.inflate(com.dstrube.phonerecord.R.layout.list_item,
						parent, false);
			} else {
				view = convertView;
			}
			
			@SuppressWarnings("unchecked")
			HashMap<String, String> map = (HashMap<String, String>) getItem(position);
			TextView phoneNumberView = view.findViewById(R.id.phoneNumber);
			TextView callerNameView = view.findViewById(R.id.callerName);
			TextView dateTimeView = view.findViewById(R.id.dateTime);
			
			String[] columns = context.getResources().getStringArray(R.array.column_names);
			
			phoneNumberView.setText(map.get(columns[1]));
			callerNameView.setText(map.get(columns[2]));
			dateTimeView.setText(map.get(columns[3]));
			
			return view;
		}
}
