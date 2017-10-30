package com.dstrube.weblistintent;

//import com.dstrube.weblistintent.FragmentA.Communicator;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
//import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
//import android.widget.ImageButton;
import android.widget.TextView;
//import android.widget.Toast;

//Custom list adapter
public class ItemListAdapter extends ArrayAdapter<String> {
	private LayoutInflater inflater;
	private String[] data;
//	private FragmentA fragment;
	private int mViewResourceId;
//	private Communicator communicator;

	public ItemListAdapter(Context ctx, int viewResourceId, String[] strings,
			FragmentA fragment) {

		super(ctx, viewResourceId, strings);

		inflater = (LayoutInflater) ctx
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

		data = strings;
//		this.fragment = fragment;
		mViewResourceId = viewResourceId;
	}

	@Override
	public int getCount() {
		return data.length;
	}

	@Override
	public String getItem(int position) {

		return data[position];
	}

	@Override
	public long getItemId(int position) {

		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		// must use final for the click listener; otherwise, this variable is
		// redundant
//		final int pos = position;
//		final ViewHolder holder;
		
		if (convertView == null) {
			convertView = inflater.inflate(mViewResourceId, null);
//			holder = new ViewHolder();
//			holder.textView = (TextView) convertView
//					.findViewById(R.id.item_text);
//			convertView.setTag(holder);
		} else {
//			holder = (ViewHolder) convertView.getTag();
		}

		TextView textView = (TextView) convertView
				.findViewById(R.id.item_text);
//		holder.textView.setText(getItem(position));
		textView.setText(getItem(position));

//		holder.textView.setOnClickListener(new OnClickListener() {
//
//			// None of these click listeners is listening. What gives?
//			@Override
//			public void onClick(View v) {
//				Toast.makeText(getContext(), "Item clicked", Toast.LENGTH_LONG)
//						.show();
//				communicator = fragment.comm;
//				communicator.setContent("http://" + data[pos] + ".com");
//			}
//		});

		// TextView tv = (TextView) convertView.findViewById(R.id.item_text);
		// tv.setOnClickListener(new OnClickListener() {
		//
		// @Override
		// public void onClick(View v) {
		// Toast.makeText(getContext(), "Item clicked", Toast.LENGTH_LONG)
		// .show();
		// communicator = fragment.comm;
		// communicator.setContent("http://" + data[pos] + ".com");
		//
		// }
		// });

		// convertView.setOnClickListener(new OnClickListener() {
		//
		// @Override
		// public void onClick(View v) {
		// Toast.makeText(getContext(), "Item clicked", Toast.LENGTH_LONG)
		// .show();
		// communicator = fragment.comm;
		// communicator.setContent("http://" + data[pos] + ".com");
		//
		// }
		// });

		// tv.setText(getItem(position));

		return convertView; // super.getView(position, convertView, parent);
	}

//	static class ViewHolder {
//		TextView textView;
//	}
}
