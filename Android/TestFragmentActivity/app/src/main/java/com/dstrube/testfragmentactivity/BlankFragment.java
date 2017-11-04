package com.dstrube.testfragmentactivity;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.app.Fragment;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.dstrube.testfragmentactivity.Utils.Utils;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link BlankFragment.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link BlankFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class BlankFragment extends Fragment {
    private static final String TAG = BlankFragment.class.getName();

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
//    private static final String ARG_PARAM1 = "param1";
//    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
//    private String mParam1;
//    private String mParam2;

    private OnFragmentInteractionListener mListener;
    private Button button;

//Compiler complains that constructor must be public. But it mustn't if one is using the singleton pattern
    private BlankFragment() {
        // Required empty <strikethrough>public</strikethrough> constructor
        //This breaks the app without a try catch:
        try {
            Log.i(TAG, "Constructor method: "+Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
        }catch (Exception e)
        {
            Log.d(TAG, e.getMessage());
            //Attempt to invoke virtual method 'java.lang.String java.lang.reflect.Method.getName()' on a null object reference
        }
        Log.i(TAG, "Constructor name:"+ new Object(){}.getClass().getEnclosingConstructor().getName());
        //getEnclosingConstructor().getName == TAG
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment BlankFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static BlankFragment newInstance(String param1, String param2) {
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
        BlankFragment fragment = new BlankFragment();
        Bundle args = new Bundle();
//        args.putString(ARG_PARAM1, param1);
//        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
        if (context instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) context;
        } else {
            throw new RuntimeException(context.toString()
                    + " must implement OnFragmentInteractionListener");
        }
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
        if (getArguments() != null) {
//            mParam1 = getArguments().getString(ARG_PARAM1);
//            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_blank, container, false);
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    @Override
    public void onStart() {
        super.onStart();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    @Override
    public void onResume() {
        super.onResume();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));

        //where was I going with this?...
//     getContext();
    }

    @Override
    public void onPause() {
        super.onPause();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    @Override
    public void onStop() {
        super.onStop();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
    }

    @Override
    public void onDetach() {
        super.onDetach();
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
        mListener = null;
    }

    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        Log.i(TAG, Utils.methodLogString(new Object(){}.getClass().getEnclosingMethod()));
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }
}
