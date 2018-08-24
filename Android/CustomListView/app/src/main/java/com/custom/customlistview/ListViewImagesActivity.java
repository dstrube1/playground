package com.custom.customlistview;

import java.util.ArrayList;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

//////////////////
/* 
 * CustomListView
 * Add checkbox next to each item
 * Add Submit button
 * Click button = Toast displaying list of all checked items
 */
//////////////////
public class ListViewImagesActivity extends Activity {

	/** Called when the activity is first created. */

	private ArrayList<ItemDetails> image_details;
	private ItemListBaseAdapter adapter0;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

		image_details = GetSearchResults();

		final ListView lv1 = findViewById(R.id.listV_main);

		final ItemListBaseAdapter adapter = new ItemListBaseAdapter(this, image_details);
		lv1.setAdapter(adapter);
		adapter0 = adapter;
		
		lv1.setOnItemClickListener(new OnItemClickListener() {
			@Override
			public void onItemClick(AdapterView<?> a, View v, int position,
					long id) {
				Object o = lv1.getItemAtPosition(position);
				ItemDetails obj_itemDetails = (ItemDetails) o;
				if (obj_itemDetails.getChecked()) {
					obj_itemDetails.setChecked(false);
				}
				else{
					obj_itemDetails.setChecked(true);
				}
				
				adapter.notifyDataSetChanged();
				
//				Toast.makeText(
//						ListViewImagesActivity.this,
//						"You have chosen : " + " " + obj_itemDetails.getName()
//								+ "; id=" + id, Toast.LENGTH_SHORT).show();
			}
		});
	}

	public void buttonClick(View v) {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("Checked items:\n");
		for (int i=0; i<image_details.size(); i++){
			ItemDetails item = (ItemDetails)adapter0.getItem(i);
			if (item.getChecked()) {
                stringBuilder.append(item.getName());
                stringBuilder.append(";\n");
			}
//			else result+="item "+item.getName()+" unchecked;\n";;
		}
		final String result = stringBuilder.toString();
		Toast.makeText(ListViewImagesActivity.this, result, Toast.LENGTH_LONG)
				.show();
	}

	private ArrayList<ItemDetails> GetSearchResults() {
		ArrayList<ItemDetails> results = new ArrayList<ItemDetails>();

		ItemDetails item_details = new ItemDetails();
		item_details.setName("Pizza");
		item_details.setItemDescription("Spicy Chiken Pizza");
		item_details.setPrice("RS 310.00");
		item_details.setImageNumber(1);
		item_details.setChecked(false);
		results.add(item_details);

		item_details = new ItemDetails();
		item_details.setName("Burger");
		item_details.setItemDescription("Beef Burger");
		item_details.setPrice("RS 350.00");
		item_details.setImageNumber(2);
		item_details.setChecked(false);
		results.add(item_details);

		item_details = new ItemDetails();
		item_details.setName("Pizza");
		item_details.setItemDescription("Chiken Pizza");
		item_details.setPrice("RS 250.00");
		item_details.setImageNumber(3);
		item_details.setChecked(false);
		results.add(item_details);

		item_details = new ItemDetails();
		item_details.setName("Burger");
		item_details.setItemDescription("Chicken Burger");
		item_details.setPrice("RS 350.00");
		item_details.setImageNumber(4);
		item_details.setChecked(false);
		results.add(item_details);

		item_details = new ItemDetails();
		item_details.setName("Burger");
		item_details.setItemDescription("Fish Burger");
		item_details.setPrice("RS 310.00");
		item_details.setImageNumber(5);
		item_details.setChecked(false);
		results.add(item_details);

		item_details = new ItemDetails();
		item_details.setName("Mango");
		item_details.setItemDescription("Mango Juice");
		item_details.setPrice("RS 250.00");
		item_details.setImageNumber(6);
		item_details.setChecked(false);
		results.add(item_details);

		return results;
	}
}