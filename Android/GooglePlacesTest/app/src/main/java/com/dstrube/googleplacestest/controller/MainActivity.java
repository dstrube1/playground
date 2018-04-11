package com.dstrube.googleplacestest.controller;

import android.app.ActionBar;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.widget.ArrayAdapter;

import com.dstrube.googleplacestest.R;
import com.dstrube.googleplacestest.model.Place;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.CameraPosition;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

import java.util.ArrayList;

public class MainActivity extends Activity implements OnMapReadyCallback {

    // private final String TAG = getClass().getSimpleName();
    private GoogleMap map;
    private String[] places;
    private LocationManager locationManager;
    private Location location;
    private final String SERVER_API_KEY = "AIzaSyC6ih35PA8zgPebleXimXiaiRp58dzJtWk";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // if (savedInstanceState == null) {
        // getSupportFragmentManager().beginTransaction()
        // .add(R.id.container, new PlaceholderFragment()).commit();
        // }

//        map = ((MapFragment) getFragmentManager().findFragmentById(R.id.map))
//                .getMapAsync(this);

        places = getResources().getStringArray(R.array.places);

        setCurrentLocation();

        final ActionBar actionBar = getActionBar();
        actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_LIST);

        actionBar.setListNavigationCallbacks(ArrayAdapter.createFromResource(
                this, R.array.places, android.R.layout.simple_list_item_1),
                new ActionBar.OnNavigationListener() {
                    @Override
                    public boolean onNavigationItemSelected(int itemPosition,
                                                            long itemId) {
                        if (location != null) {
                            map.clear();
                            new GetPlaces(MainActivity.this,
                                    places[itemPosition].toLowerCase().replace(
                                            "-", "_")).execute();
                        }
                        return true;
                    }
                });

    }

    @Override
    public void onMapReady(final GoogleMap map) {
        this.map = map;
        try {
            map.setMyLocationEnabled(true);
        } catch (SecurityException e) {
        }
    }

    private void setCurrentLocation() {
        locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);

        String provider = locationManager
                .getBestProvider(new Criteria(), false);
        if (provider != null)
            try {
                Location lastKnownLocation = locationManager
                        .getLastKnownLocation(provider);

                if (lastKnownLocation == null) {
                    locationManager.requestLocationUpdates(provider, 0, 0, listener);
                } else {
                    location = lastKnownLocation;
                    new GetPlaces(MainActivity.this, places[0].toLowerCase().replace(
                            "-", "_")).execute();
                }
            } catch (SecurityException e) {
            }
    }

    private LocationListener listener = new LocationListener() {

        @Override
        public void onStatusChanged(String provider, int status, Bundle extras) {
        }

        @Override
        public void onProviderEnabled(String provider) {
        }

        @Override
        public void onProviderDisabled(String provider) {
        }

        @Override
        public void onLocationChanged(Location newLocation) {
            location = newLocation;
            locationManager.removeUpdates(listener);
        }
    };

    /**
     * A placeholder fragment containing a simple view.
     */
	/* public static class PlaceholderFragment extends Fragment {

	 public PlaceholderFragment() {
	 }

	 @Override
	 public View onCreateView(LayoutInflater inflater, ViewGroup container,
	 Bundle savedInstanceState) {
	 View rootView = inflater.inflate(R.layout.fragment_main, container,
	 false);
	 return rootView;
	 }
	 }
*/

    private class GetPlaces extends AsyncTask<Void, Void, ArrayList<Place>> {

        private ProgressDialog dialog;
        private Context context;
        private String places;

        public GetPlaces(Context context, String places) {
            this.context = context;
            this.places = places;
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            dialog = new ProgressDialog(context);
            dialog.setCancelable(false);
            dialog.setMessage("Loading..");
            dialog.isIndeterminate();
            dialog.show();
        }

        /**
         * get the results from the search
         */
        @Override
        protected ArrayList<Place> doInBackground(Void... arg0) {
            PlaceService service = new PlaceService(
                    SERVER_API_KEY);
            ArrayList<Place> findPlaces = service.findPlaces(
                    location.getLatitude(), // 28.632808
                    location.getLongitude(), places); // 77.218276

            if (findPlaces != null) {
                for (int i = 0; i < findPlaces.size(); i++) {

                    // Place placeDetail = findPlaces.get(i);

                }
            }
            return findPlaces;
        }

        /**
         * adding the map marker after results are gotten
         */
        @Override
        protected void onPostExecute(ArrayList<Place> result) {
            super.onPostExecute(result);
            if (dialog.isShowing()) {
                dialog.dismiss();
            }
            for (int i = 0; i < result.size(); i++) {
                map.addMarker(new MarkerOptions()
                        .title(result.get(i).getName())
                        .position(
                                new LatLng(result.get(i).getLatitude(), result
                                        .get(i).getLongitude()))
                        .icon(BitmapDescriptorFactory
                                .defaultMarker(BitmapDescriptorFactory.HUE_GREEN))
                        .snippet(result.get(i).getVicinity()));
            }
            if (result.size() > 0) {
                CameraPosition cameraPosition = new CameraPosition.Builder()
                        .target(new LatLng(result.get(0).getLatitude(), result
                                .get(0).getLongitude())) // Sets the center of
                        // the map to
                        // Mountain View
                        .zoom(14) // Sets the zoom
                        .tilt(30) // Sets the tilt of the camera to 30 degrees
                        .build(); // Creates a CameraPosition from the builder
                map.animateCamera(CameraUpdateFactory
                        .newCameraPosition(cameraPosition));
            }
        }

    }
}
