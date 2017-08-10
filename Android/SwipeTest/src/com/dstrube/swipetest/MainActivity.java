package com.dstrube.swipetest;

import java.util.Locale;

import android.support.v7.app.ActionBar.Tab;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.app.FragmentPagerAdapter;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
//import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class MainActivity extends ActionBarActivity implements
		ActionBar.TabListener { // <--required for tabs

	/**
	 * The {@link android.support.v4.view.PagerAdapter} that will provide
	 * fragments for each of the sections. We use a {@link FragmentPagerAdapter}
	 * derivative, which will keep every loaded fragment in memory. If this
	 * becomes too memory intensive, it may be best to switch to a
	 * {@link android.support.v4.app.FragmentStatePagerAdapter}.
	 */
	SectionsPagerAdapter mSectionsPagerAdapter;

	/**
	 * The {@link ViewPager} that will host the section contents.
	 */
	ViewPager mViewPager;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		// Set up the action bar.
		final ActionBar actionBar = getSupportActionBar();// required for tabs
		actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);// required
																	// for tabs

		// Create the adapter that will return a fragment for each of the three
		// primary sections of the activity.
		mSectionsPagerAdapter = new SectionsPagerAdapter(
				getSupportFragmentManager());

		// Set up the ViewPager with the sections adapter.
		mViewPager = (ViewPager) findViewById(R.id.pager);
		mViewPager.setAdapter(mSectionsPagerAdapter);

		// When swiping between different sections, select the corresponding
		// tab. We can also use ActionBar.Tab#select() to do this if we have
		// a reference to the Tab.
		mViewPager // required for tabs
				.setOnPageChangeListener(new ViewPager.SimpleOnPageChangeListener() {// required
																						// for
																						// tabs
					@Override
					// required for tabs
					public void onPageSelected(int position) {// required for
																// tabs
						actionBar.setSelectedNavigationItem(position);// required
																		// for
																		// tabs
					}// required for tabs
				});// required for tabs

		// For each of the sections in the app, add a tab to the action bar.
		for (int i = 0; i < mSectionsPagerAdapter.getCount(); i++) {// required
																	// for tabs
			// Create a tab with text corresponding to the page title defined by
			// the adapter. Also specify this Activity object, which implements
			// the TabListener interface, as the callback (listener) for when
			// this tab is selected.
			actionBar.addTab(actionBar.newTab()
					// required for tabs
					.setText(mSectionsPagerAdapter.getPageTitle(i))
					.setTabListener(this));
		}
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {

		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	public void onTabSelected(Tab tab, FragmentTransaction arg1) {// required
																	// for tabs
		mViewPager.setCurrentItem(tab.getPosition());
	}

	@Override
	public void onTabUnselected(Tab tab, FragmentTransaction arg1) {// required
																	// for tabs
		// do nothing
	}

	@Override
	public void onTabReselected(Tab tab, FragmentTransaction arg1) {// required
																	// for tabs
		// do nothing
	}

	/**
	 * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
	 * one of the sections/tabs/pages.
	 */
	public class SectionsPagerAdapter extends FragmentPagerAdapter {

		public SectionsPagerAdapter(FragmentManager fm) {
			super(fm);
		}

		@Override
		public Fragment getItem(int position) {
			// getItem is called to instantiate the fragment for the given page.
			// Return a PlaceholderFragment (defined as a static inner class
			// below).
			return PlaceholderFragment.newInstance(position + 1);
		}

		@Override
		public int getCount() {
			// total number of pages.
			return 7;
		}

		@Override
		public CharSequence getPageTitle(int position) {
			return "Section "+(position+1);
//			Locale locale = Locale.getDefault();
//			
//			switch (position) {
//			case 0:
//				return getString(R.string.title_section1).toUpperCase(locale);
//			case 1:
//				return getString(R.string.title_section2).toUpperCase(locale);
//			case 2:
//				return getString(R.string.title_section3).toUpperCase(locale);
//			}
//			return null;
		}
	}

	/**
	 * A placeholder fragment containing a simple view.
	 */
	public static class PlaceholderFragment extends Fragment {
		/**
		 * The fragment argument representing the section number for this
		 * fragment.
		 */
		private static final String ARG_SECTION_NUMBER = "section_number";

		/**
		 * Returns a new instance of this fragment for the given section number.
		 */
		public static PlaceholderFragment newInstance(int sectionNumber) {
			PlaceholderFragment fragment = new PlaceholderFragment();
			Bundle args = new Bundle();
			args.putInt(ARG_SECTION_NUMBER, sectionNumber);
			if (sectionNumber == 1) {
				args.putInt("color", Color.RED);
			} else if (sectionNumber == 2) {
				args.putInt("color", Color.YELLOW);
			} else if (sectionNumber == 3) {
				args.putInt("color", Color.GREEN);
			} else if (sectionNumber == 4) {
				args.putInt("color", Color.BLUE);
			} else if (sectionNumber == 5) {
				args.putInt("color", Color.MAGENTA);
			} else if (sectionNumber == 6) {
				args.putInt("color", Color.CYAN);
			} else if (sectionNumber == 7) {
				args.putInt("color", Color.WHITE);
			}
			fragment.setArguments(args);
			return fragment;
		}

		public PlaceholderFragment() {
		}

		@Override
		public View onCreateView(LayoutInflater inflater, ViewGroup container,
				Bundle savedInstanceState) {
			View rootView = inflater.inflate(R.layout.fragment_main, container,
					false);
			TextView textView = (TextView) rootView
					.findViewById(R.id.section_label);
			textView.setText(Integer.toString(getArguments().getInt(
					ARG_SECTION_NUMBER)));
			rootView.setBackgroundColor(getArguments().getInt("color"));
			return rootView;
		}
	}

}
