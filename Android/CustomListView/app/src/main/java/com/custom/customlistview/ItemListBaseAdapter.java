package com.custom.customlistview;

import java.util.ArrayList;



import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.TextView;

public class ItemListBaseAdapter extends BaseAdapter {
	private static ArrayList<ItemDetails> itemDetailsArrayList;
	
	private Integer[] imgid = {
			R.drawable.p1,  //pizza1
			R.drawable.bb2, //burger
			R.drawable.p2,  //pizza
			R.drawable.bb5, //burger
			R.drawable.bb6, //burger
			R.drawable.d1   //drink
			};
	
	private LayoutInflater l_Inflater;

	public ItemListBaseAdapter(Context context, ArrayList<ItemDetails> results) {
		itemDetailsArrayList = results;
		l_Inflater = LayoutInflater.from(context);
	}

	public int getCount() {
		return itemDetailsArrayList.size();
	}

	public Object getItem(int position) {
		return itemDetailsArrayList.get(position);
	}

	public long getItemId(int position) {
		return position;
	}

	public View getView(int position, View convertView, ViewGroup parent) {
		
		/*
		 *   ViewHolder : Your code might call findViewById() frequently during the scrolling of ListView, 
		 *   which can slow down performance. Even when the Adapter returns an inflated view for 
		 *   recycling, you still need to look up the elements and update them. 
		 *   A way around repeated use of findViewById() is to use the "view holder" design pattern.
		 * 
		 */

		ViewHolder holder;
		if (convertView == null) {
			convertView = l_Inflater.inflate(R.layout.item_details_view, null);
			holder = new ViewHolder();
			holder.txt_itemName = convertView.findViewById(R.id.name);
			holder.txt_itemDescription = convertView.findViewById(R.id.itemDescription);
			holder.txt_itemPrice = convertView.findViewById(R.id.price);
			holder.itemImage = convertView.findViewById(R.id.photo);
			holder.checkBox = convertView.findViewById(R.id.checkBox);
			convertView.setTag(holder);
		} else {
			holder = (ViewHolder) convertView.getTag();
		}
		
		holder.txt_itemName.setText(itemDetailsArrayList.get(position).getName());
		holder.txt_itemDescription.setText(itemDetailsArrayList.get(position).getItemDescription());
		holder.txt_itemPrice.setText(itemDetailsArrayList.get(position).getPrice());
		holder.itemImage.setImageResource(imgid[itemDetailsArrayList.get(position).getImageNumber() - 1]);
//		imageLoader.DisplayImage("http://192.168.1.28:8082/ANDROID/images/BEVE.jpeg", holder.itemImage);
		holder.checkBox.setChecked(itemDetailsArrayList.get(position).getChecked());

		return convertView;
	}

	static class ViewHolder {
		TextView txt_itemName;
		TextView txt_itemDescription;
		TextView txt_itemPrice;
		ImageView itemImage;
		CheckBox checkBox;
	}
}
