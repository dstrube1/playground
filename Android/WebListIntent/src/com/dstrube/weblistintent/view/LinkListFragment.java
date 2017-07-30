package com.dstrube.weblistintent.view;

import java.util.ArrayList;
import java.util.List;

import com.dstrube.weblistintent.R;
import com.dstrube.weblistintent.controller.ChangeLinkListener;
import com.dstrube.weblistintent.model.LinkData;

import android.app.Activity;
import android.app.Fragment;
import android.content.Context;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListView;

public class LinkListFragment extends Fragment {
	private List<LinkData> linkDataList = new ArrayList<LinkData>();
	private LinkAdapter la;

	// set data here
	// static{
	// final Context ctx = getView().getContext();
	// final Resources res = ctx.getResources();
	// final String[] domains = res.getStringArray(R.array.domains);
	// linkDataList.add(new LinkData("SwA",
	// "http://www.survivingwithandroid.com"));
	// linkDataList.add(new LinkData("Android", "http://www.android.com"));
	// linkDataList.add(new LinkData("Google Mail", "http://mail.google.com"));

	// }
	// i don't like this way of doing it; let's avoid it if possible

	public LinkListFragment() {
	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
		// Here we set our custom adapter. Now we have the reference to the
		// activity
		final Context ctx = getView().getContext();
		final Resources res = ctx.getResources();
		final String[] domains = res.getStringArray(R.array.domains);
		for (int i = 0; i < domains.length; i++) {
			linkDataList.add(new LinkData(domains[i], "http://www."+domains[i]+".com"));
		}
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View v = inflater.inflate(R.layout.linklist_layout, container, false);
		ListView lv = (ListView) v.findViewById(R.id.urls);
		la = new LinkAdapter(linkDataList, getActivity());
		lv.setAdapter(la);
		lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
			@Override
			public void onItemClick(AdapterView<?> parentAdapter, View view,
					int position, long id) {
				LinkData data = ((LinkAdapter) la).getItem(position);
				((ChangeLinkListener) getActivity()).onLinkChange(data.getUrl());
			}
		});
		return v;
	}

	@Override
	public void onAttach(Activity activity) {
		// We verify that our activity implements the listener
		if (!(activity instanceof ChangeLinkListener))
			throw new ClassCastException();
		super.onAttach(activity);
	}

}
