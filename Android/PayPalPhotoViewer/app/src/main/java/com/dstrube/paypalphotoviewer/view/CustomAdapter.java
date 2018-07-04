package com.dstrube.paypalphotoviewer.view;

import com.dstrube.paypalphotoviewer.R;
//import com.dstrube.paypalphotoviewer.R.id;
//import com.dstrube.paypalphotoviewer.R.layout;
//import com.dstrube.paypalphotoviewer.service.ImageLoader;

import java.util.ArrayList;





import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
//import android.widget.GridView;
import android.widget.ImageView;

public class CustomAdapter extends BaseAdapter {

	private ArrayList<PhotoRowObject> images;
	private LayoutInflater inflater;

	public CustomAdapter(Context context, ArrayList<PhotoRowObject> images) {
		this.images = images;
		inflater = LayoutInflater.from(context);
	}

	@Override
	public int getCount() {
		return images.size();
	}

	@Override
	public Object getItem(int position) {
		return images.get(position);
	}

	@Override
	public long getItemId(int position) {
		return 0;
	}

	@SuppressLint("InflateParams") 
	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
//		ImageView imageView;
		ViewHolder holder;
        if (convertView == null) {  // if it's not recycled, initialize some attributes
//            imageView = new ImageView(ctx);
//            imageView.setLayoutParams(new GridView.LayoutParams(85, 85));
//            imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
//            imageView.setPadding(8, 8, 8, 8);
        	convertView = inflater.inflate(R.layout.photo_row, null);
			holder = new ViewHolder();

			holder.image1 = convertView.findViewById(R.id.image1);
			
			convertView.setTag(holder);
			Bitmap bitmap = BitmapFactory.decodeFile(images.get(position).getPath());
			holder.image1.setImageBitmap(bitmap);
        } else {
//            imageView = (ImageView) convertView;
        	holder = (ViewHolder) convertView.getTag();
        }
//        Bitmap bitmap = BitmapFactory.decodeFile(images.get(position).getPath());
//        imageView.setImageBitmap(bitmap);
//        return imageView;
        return convertView;
	}
	/*
	 * This is from when we tried this with a list view:
	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		ViewHolder holder;
		if (convertView != null) {
			holder = (ViewHolder) convertView.getTag();
		} else {
			convertView = inflater.inflate(R.layout.photo_row, null);
			holder = new ViewHolder();

			holder.image1 = (ImageView) convertView.findViewById(R.id.image1);
			holder.image2 = (ImageView) convertView.findViewById(R.id.image2);

			convertView.setTag(holder);

			if (images.get(position).getIsLocal()) {
				Bitmap bitmap = BitmapFactory.decodeFile(images.get(position).getPath());
				if (position % 2 == 1) {
					holder.image1.setImageBitmap(bitmap);
				}
				else {
					holder.image2.setImageBitmap(bitmap);					
				}
			} else {
				ImageLoader imageLoader = new ImageLoader(ctx);
				if (position % 2 == 1) {
					imageLoader.DisplayImage(images.get(position).getPath(),
							holder.image1);
				} else {
					imageLoader.DisplayImage(images.get(position).getPath(),
							holder.image2);
				}
			}
		}

		return convertView;
	}
	*/

	private class ViewHolder {
		ImageView image1;
//		ImageView image2;
	}

}
