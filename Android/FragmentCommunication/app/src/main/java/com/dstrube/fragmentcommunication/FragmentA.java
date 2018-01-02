package com.dstrube.fragmentcommunication;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public class FragmentA extends Fragment {

	Communicator comm;
	
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		return inflater.inflate(R.layout.fragment_a, container, false);
	}
	
	public void setCommunicator(Communicator c){
		comm = c;
	}
	public void onClick(View v){
		comm.respond("button was clicked");
	}
	public interface Communicator {
		public void respond(String data);
	}
}
