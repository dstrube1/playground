package com.dstrube.weblistintent;

//import java.util.HashMap;
//import java.util.Map;

import android.app.Fragment;
import android.content.Context;
//import android.content.Intent;
//import android.content.res.Configuration;
import android.content.res.Resources;
//import android.content.res.TypedArray;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
//import android.widget.AdapterView.OnItemClickListener;
//import android.widget.AdapterView;
//import android.widget.ArrayAdapter;
import android.widget.ListView;

public class FragmentA extends Fragment {
	ListView listView;
//	Map<String, String> map;

	//hooray communicator pattern!
	Communicator comm;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		//blow up the balloon
		View result = inflater.inflate(R.layout.fragment_a, container, false);
		return result;
		// super.onCreateView(inflater, container, savedInstanceState);
	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
		//get the listView
		listView = (ListView) getActivity().findViewById(R.id.listView);
		
		//must be final for the click listener below
		final Context ctx = getView().getContext();
		final Resources res = ctx.getResources();
		final String[] domains = res.getStringArray(R.array.domains);

//		map = new HashMap<String, String>();
//		for (int i = 0; i < domains.length; i++) {
//			map.put(domains[i], "http://www." + domains[i] + ".com");
//		}

//		ArrayAdapter<String> adapter = new ArrayAdapter<String>(ctx,
//				android.R.layout.simple_list_item_1, android.R.id.text1,
//				domains);

		ItemListAdapter adapter = new ItemListAdapter(ctx, R.layout.simplerow,
				//android.R.layout.simple_list_item_1, 
				domains, this);

		listView.setAdapter(adapter);
		
		//on second thought, let's let someone else handle the click listener
//		listView.setOnItemClickListener(new OnItemClickListener() {
//			@Override
//			public void onItemClick(ItemListAdapter<?> arg0, View arg1, int position,
//					long id) {
////				Toast.makeText(getApplicationContext(), map.get(domains[position]), Toast.LENGTH_LONG).show();
//				Configuration config = res.getConfiguration();
//				//config.orientation
//				int orient = config.orientation; 
//				//getScreenOrientation(); <- great idea, but returns "neither landscape nor portrait" on landscape :(
//				if (orient == Configuration.ORIENTATION_LANDSCAPE) {
////			        Toast.makeText(getApplicationContext(), "landscape", Toast.LENGTH_SHORT).show();
//			    } else if (orient == Configuration.ORIENTATION_PORTRAIT){
////			        Toast.makeText(getApplicationContext(), "portrait", Toast.LENGTH_SHORT).show();
//			    }
//			    else{
////			    	Toast.makeText(getApplicationContext(), "neither landscape nor portrait", Toast.LENGTH_SHORT).show();
//			    }
//				Intent intent = new Intent(ctx, Screen2.class);
//				intent.putExtra("url", map.get(domains[position]));
//				startActivity(intent);
//			}
//		});
	
	}

	public void setCommunicator(Communicator comm) {
		this.comm = comm;
	}

	public interface Communicator {
		public void setContent(String itemSelected);
	}
}
