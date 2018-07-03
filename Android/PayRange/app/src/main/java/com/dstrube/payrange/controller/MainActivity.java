package com.dstrube.payrange.controller;

import android.content.res.TypedArray;
import android.graphics.Color;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.dstrube.payrange.R;
import com.dstrube.payrange.model.VendingMachine;
import com.dstrube.payrange.util.Randomizer;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = MainActivity.class.getSimpleName();

    /**
     * The {@link android.support.v4.view.PagerAdapter} that will provide
     * fragments for each of the sections. We use a
     * {@link FragmentPagerAdapter} derivative, which will keep every
     * loaded fragment in memory. If this becomes too memory intensive, it
     * may be best to switch to a
     * {@link android.support.v4.app.FragmentStatePagerAdapter}.
     */
    private static SectionsPagerAdapter mSectionsPagerAdapter;

    /**
     * The {@link ViewPager} that will host the section contents.
     */
    private static ViewPager mViewPager;

    private static int numberOfTabs;
    private static TypedArray images;
    private static TypedArray descriptions;
    private static ArrayList<VendingMachine> machines;

    public static final int NUMBER_OF_BLE_SIGNALS = 3;
    private static final int POOR_SIGNAL_THRESHOLD = 40;
    private static final int OK_SIGNAL_THRESHOLD = 70;

    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        Log.i(TAG, "onCreate");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Create the adapter that will return a fragment for each of the sections of the activity.
        mSectionsPagerAdapter = new SectionsPagerAdapter(getSupportFragmentManager());

        // Set up the ViewPager with the sections adapter.
        mViewPager = findViewById(R.id.container);
        mViewPager.setAdapter(mSectionsPagerAdapter);

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mSectionsPagerAdapter.isDataSetChanged = true;

                Randomizer.randomize(getParent());
                Snackbar.make(view, "Randomizing...", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();

            }
        });

        //Get all 10 images and their descriptions
        images = getResources().obtainTypedArray(R.array.imgs);
        descriptions = getResources().obtainTypedArray(R.array.desecriptions);

    }

    @Override
    protected void onDestroy() {
        Log.i(TAG, "onDestroy");
        images.recycle();
        descriptions.recycle();
        super.onDestroy();
    }

    /**
     * Called by Randomizer, post AsyncTask execution
     * @param postExecuteRandom - number of tabs / vending machines to display
     * @param randoms - random data for all the vending machines
     */
    public static void setMachines(final Integer postExecuteRandom, final ArrayList<Integer> randoms) {
        Log.i(TAG, "setMachines: postExecuteRandom = " + postExecuteRandom + ", randoms.size = " + randoms.size());
        numberOfTabs = postExecuteRandom;
        machines = new ArrayList<>(numberOfTabs);

        if (numberOfTabs > 0) {
            for (int i = 0; i < numberOfTabs; i++) {
                VendingMachine vendingMachine = new VendingMachine();
                //We don't set these here because these variables are set in onCreate,
                // outside a static context
                //vendingMachine.setDescription(descriptions.getText(i).toString());
                //vendingMachine.setImageId(images.getResourceId(i, -1));
                int[] strengths = new int[NUMBER_OF_BLE_SIGNALS];
                for (int j = 0; j < strengths.length; j++) {
                    strengths[j] = randoms.get((i * NUMBER_OF_BLE_SIGNALS) + j);
                }
                vendingMachine.setBleStrengths(strengths);
                machines.add(i, vendingMachine);
            }
        }

        if (null != mViewPager) {
            mViewPager.invalidate();
        }
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

        private static final String TAG = PlaceholderFragment.class.getSimpleName();
        /**
         * The fragment argument representing the section number for this
         * fragment.
         */
        private static final String ARG_SECTION_NUMBER = "section_number";

        public PlaceholderFragment() {
        }

        /**
         * Returns a new instance of this fragment for the given section
         * number.
         */
        public static PlaceholderFragment newInstance(final int sectionNumber) {
            Log.i(TAG, "newInstance");
            PlaceholderFragment fragment = new PlaceholderFragment();
            Bundle args = new Bundle();
            args.putInt(ARG_SECTION_NUMBER, sectionNumber);
            fragment.setArguments(args);

            return fragment;
        }

        @Override
        public View onCreateView(@NonNull final LayoutInflater inflater, final ViewGroup container,
                                 final Bundle savedInstanceState) {
            Log.i(TAG, "onCreateView");
            View rootView = inflater.inflate(R.layout.fragment_main, container, false);

            if (getArguments() == null){
                final String error = "Null arguments";
                Log.e(TAG, error);
                Toast.makeText(rootView.getContext(), error, Toast.LENGTH_LONG).show();
                return null;
            }

            final int element = getArguments().getInt(ARG_SECTION_NUMBER) - 1;
            if (machines.size() > element) {
                StringBuilder stringBuilder;
                final VendingMachine vendingMachine = machines.get(element);
                String strengthsText = "";

                final ImageView imageView = rootView.findViewById(R.id.image);
//            imageView.setImageResource(vendingMachine.getImageId());
                imageView.setImageResource(images.getResourceId(element, -1));

                if (vendingMachine != null) {
                    for (int i = 0; i < vendingMachine.getBleStrengths().length; i++) {
                        strengthsText += vendingMachine.getBleStrengths()[i];//todo find a better way of concatenating this
                        if (i < vendingMachine.getBleStrengths().length - 1) {
                            strengthsText += " - ";
                        }
                    }
                }

                TextView descriptionTextView = rootView.findViewById(R.id.section_label);
//            textView.setText(getString(R.string.section_format, getArguments().getInt(ARG_SECTION_NUMBER)));
//            descriptionTextView.setText(vendingMachine.getDescription());
                descriptionTextView.setText(descriptions.getText(element));

                TextView strengthsTextView = rootView.findViewById(R.id.strengths);
                stringBuilder = new StringBuilder();
                stringBuilder.append(strengthsTextView.getText());
                stringBuilder.append(strengthsText);
                strengthsTextView.setText(stringBuilder.toString());

                TextView averageStrengthsTextView = rootView.findViewById(R.id.average_strength);
                stringBuilder = new StringBuilder();
                stringBuilder.append(averageStrengthsTextView.getText());
                stringBuilder.append(vendingMachine.getAverageBleStrength());
                averageStrengthsTextView.setText(stringBuilder.toString());
                if (vendingMachine.getAverageBleStrength() < POOR_SIGNAL_THRESHOLD)
                    averageStrengthsTextView.setBackgroundColor(Color.RED);
                else if (vendingMachine.getAverageBleStrength() >= POOR_SIGNAL_THRESHOLD
                        && vendingMachine.getAverageBleStrength() < OK_SIGNAL_THRESHOLD)
                    averageStrengthsTextView.setBackgroundColor(Color.YELLOW);
                else
                    averageStrengthsTextView.setBackgroundColor(Color.GREEN);
            }
            return rootView;
        }
    }

    /**
     * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
     * one of the sections/tabs/pages.
     */
    public class SectionsPagerAdapter extends FragmentPagerAdapter {

        private final String TAG = SectionsPagerAdapter.class.getSimpleName();
        public SectionsPagerAdapter(final FragmentManager fm) {
            super(fm);
        }

        public boolean isDataSetChanged = false;

        @Override
        public Fragment getItem(final int position) {
            // getItem is called to instantiate the fragment for the given page.
            // Return a PlaceholderFragment (defined as a static inner class below).
            Log.i(TAG, "getItem");
            return PlaceholderFragment.newInstance(position + 1);
        }

        @Override
        public int getCount() {
            Log.i(TAG, "getCount");
            if (isDataSetChanged) {
                isDataSetChanged = false;
                notifyDataSetChanged();
            }
            return numberOfTabs;
        }

        @Override
        public CharSequence getPageTitle(final int position) {
            Log.i(TAG, "getPageTitle");
            return "page " + position + "of " + getCount();
        }
    }
}
