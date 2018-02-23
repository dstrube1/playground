package com.dstrube.gpstracking;

import android.app.Activity;
import android.os.Bundle;
//import android.view.LayoutInflater;
//import android.view.View;
//import android.view.ViewGroup;
//import android.widget.TextView;
//import android.widget.Button;
import android.widget.Toast;

//import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
//import com.google.android.gms.maps.model.CameraPosition;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

//////////////////
/* 
* AndroidGPSTracking
* This app was originally sample code illustrating just the lat /lng -> geocoder function.
* I've since commented all that out, and used this app for an API key testing some Google Map functions.
*/
//////////////////

//http://www.androidhive.info/2013/08/android-working-with-google-maps-v2/
public class AndroidGPSTrackingActivity extends Activity {

	// no need to declare this in the main activity if all it was used for was a
	// click listener that is better off declared in the xml:
	// Button btnShowLocation;

	private GoogleMap map;

	// GPSTracker - duh!
	// private GPSTracker gps;
	//
	// private TextView latituteField;
	// private TextView longitudeField;
	// private TextView addressField;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

		// if (savedInstanceState == null) {
		// getFragmentManager().beginTransaction()
		// .add(R.id.container, new PlaceholderFragment()).commit();
		// }

		try {
			initializeMap();
		} catch (Exception e) {
			e.printStackTrace();
		}

		// latituteField = (TextView) findViewById(R.id.latText);
		// longitudeField = (TextView) findViewById(R.id.lonText);
		// addressField = (TextView) findViewById(R.id.addressText);

	}

	private void initializeMap() {
		if (map == null) {
			MapFragment mapFragment = (MapFragment) getFragmentManager()
					.findFragmentById(R.id.map);
			map = mapFragment.getMap();

			if (map == null) {
				Toast.makeText(getApplicationContext(), "Sorry, no can do.",
						Toast.LENGTH_LONG).show();
			}

			// latitude and longitude
			// hashmap is no good if you need to remember the key later on
			// HashMap<Double,Double> points = new HashMap<Double,Double>();
			// points.put(new Double(0), new Double(0));
			// points.put(new Double(37.4422006), new Double(-122.084095));
			// Googleplex:
			// double latitude = 37.4422006;
			// double longitude = -122.084095;
			// double latitude = 0;
			// double longitude = 0;

			// create marker
			// MarkerOptions marker = new MarkerOptions().position(new
			// LatLng(latitude, longitude)).title("Hello Maps ");

			//all the colors of markers
			addPoint(0, 0, "Rose", BitmapDescriptorFactory.HUE_ROSE);
//			addPoint(5, 5, "Green", BitmapDescriptorFactory.HUE_GREEN);
//			addPoint(10, 10, "Azure", BitmapDescriptorFactory.HUE_AZURE);
//			addPoint(15, 15, "Blue", BitmapDescriptorFactory.HUE_BLUE);
//			addPoint(20, 20, "Cyan", BitmapDescriptorFactory.HUE_CYAN);
//			addPoint(25, 25, "Magenta", BitmapDescriptorFactory.HUE_MAGENTA);
//			addPoint(30, 30, "Orange", BitmapDescriptorFactory.HUE_ORANGE);
//			addPoint(35, 35, "Red", BitmapDescriptorFactory.HUE_RED);
//			addPoint(40, 40, "Violet", BitmapDescriptorFactory.HUE_VIOLET);
//			addPoint(45, 45, "Yellow", BitmapDescriptorFactory.HUE_YELLOW);

			//change focus and zoom
//			CameraPosition cameraPosition = new CameraPosition.Builder()
//					.target(new LatLng(17.385044, 78.486671)).zoom(12).build();
//
//			map.animateCamera(CameraUpdateFactory
//					.newCameraPosition(cameraPosition));

			//map type none?
//			map.setMapType(GoogleMap.MAP_TYPE_NONE);
			//really means no map O_o
		
			//use this when installed on phone, not on emulator:
//			map.getUiSettings().setZoomControlsEnabled(false);
			
			//doesn't work on emulator?
			map.setMyLocationEnabled(true);
			
			//showing / hiding works, but not sure about the functionality
			map.getUiSettings().setMyLocationButtonEnabled(true);
			
//			always handy
			map.getUiSettings().setRotateGesturesEnabled(true);
			map.getUiSettings().setCompassEnabled(true);
		}
	}

	private void addPoint(int lat, int lng, String string, float hue) {
		MarkerOptions marker = new MarkerOptions().position(
				new LatLng(lat, lng)).title(string);
		marker.icon(BitmapDescriptorFactory
		// .fromResource(R.drawable.ic_launcher));
				.defaultMarker(hue));
		// adding marker
		map.addMarker(marker);

	}

	@Override
	protected void onResume() {
		super.onResume();
		initializeMap();
	}

	// public void Click(View v) {
	// gps = new GPSTracker(AndroidGPSTrackingActivity.this);
	//
	// // check if GPS enabled
	// if (gps.canGetLocation()) {
	//
	// double latitude = gps.getLatitude();
	// double longitude = gps.getLongitude();
	//
	// // \n is for new line
	// // Toast.makeText(
	// // getApplicationContext(),
	// // "Your Location is - \nLat: " + latitude + "\nLong: "
	// // + longitude, Toast.LENGTH_LONG).show();
	// latituteField.setText(String.valueOf(latitude));
	// longitudeField.setText(String.valueOf(longitude));
	//
	// String address = gps.getAddress();
	// addressField.setText(address);
	// } else {
	// // can't get location
	// // GPS or Network is not enabled
	// // Ask user to enable GPS/network in settings
	// gps.showSettingsAlert();
	// }
	// }

	/**
	 * A placeholder fragment containing a simple view.
	 */
	// public static class PlaceholderFragment extends MapFragment {
	//
	// public PlaceholderFragment() {
	// }
	//
	// @Override
	// public View onCreateView(LayoutInflater inflater, ViewGroup container,
	// Bundle savedInstanceState) {
	// View rootView = inflater.inflate(R.layout.fragment_a, container,
	// false);
	// return rootView;
	// }
	// }
}