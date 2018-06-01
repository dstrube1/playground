package com.dstrube.phonerecord.service

import android.widget.Toast
import android.content.Intent
import android.os.IBinder
import android.os.Bundle
import android.app.AlertDialog
import android.app.Service
import android.content.Context
import android.location.*
import android.provider.Settings
import android.util.Log
import java.io.IOException
import java.util.*


//TODO This is all interesting, but what is it doing in this project?

class GPSTracker
/**
 * Constructor
 *
 * @param context
 */
(private val mContext: Context) : Service(), LocationListener {

    // flag for GPS status
    private var isGPSEnabled = false

    // flag for network status
    private var isNetworkEnabled = false

    // flag for GPS status
    private var canGetLocation = false

    private var location: Location? = null // location
    private var latitude: Double = 0.toDouble() // latitude
    private var longitude: Double = 0.toDouble() // longitude
    // 1 minute = 60,000 milliseconds

    // Declaring a Location Manager
    private var locationManager: LocationManager? = null

    // Context ctx = null;
    // try {
    // // getBaseContext() == null
    // ctx = getApplicationContext(); //this one throws an exception just
    // trying to instantiate it
    // } catch (Exception e) {
    // e.printStackTrace(); // NullPointer
    // ctx = this;
    // }
    val address: String
        get() {
            val geocoder: Geocoder
            val addresses: List<Address>

            var returnAddress = "None"
            val locale = Locale.getDefault()

            try {
                geocoder = Geocoder(mContext, locale)
                if (Geocoder.isPresent()) {
                    addresses = geocoder.getFromLocation(latitude, longitude, 1)
                    if (addresses.isNotEmpty()) {
                        val address = addresses[0].getAddressLine(0)
                        val city = addresses[0].getAddressLine(1)
                        val country = addresses[0].getAddressLine(2)
                        returnAddress = "$address, $city, $country"
                    } else {
                        Toast.makeText(mContext, "No address found.", Toast.LENGTH_LONG).show()
                    }
                } else {
                    Toast.makeText(mContext, "Geocoder is not present.", Toast.LENGTH_LONG).show()
                }
            } catch (e: IOException) {
                e.printStackTrace()
            } catch (e: Exception) {
                e.printStackTrace()
            }

            return returnAddress
        }

    init {
        getLocation()
    }

    /**
     * This is the meat of the class, the answer to your prayers, your dreams
     * come true.
     *
     * @return
     */
    private fun getLocation(): Location? {
        try {
            locationManager = mContext.getSystemService(LOCATION_SERVICE) as LocationManager

            // getting GPS status
            isGPSEnabled = locationManager!!
                    .isProviderEnabled(LocationManager.GPS_PROVIDER)

            // getting network status
            isNetworkEnabled = locationManager!!
                    .isProviderEnabled(LocationManager.NETWORK_PROVIDER)

            if (!isGPSEnabled && !isNetworkEnabled) {
                // no network provider is enabled;
                // no need to set canGetLocation = false;
                // that is its default, and nothing else (besides the below
                // code) will change that after creating this object -
                // instantiating this class - since canGetLocation is now
                // explicitly private.
            } else {
                this.canGetLocation = true
                if (isNetworkEnabled) {
                    enforcePermission("android.permission.ACCESS_COARSE_LOCATION", 0, 0, "Missing permission: ACCESS_COARSE_LOCATION")
                    enforcePermission("android.permission.ACCESS_FINE_LOCATION", 0, 0, "Missing permission: ACCESS_FINE_LOCATION")
                    locationManager!!.requestLocationUpdates(
                            LocationManager.NETWORK_PROVIDER,
                            MIN_TIME_BW_UPDATES,
                            MIN_DISTANCE_CHANGE_FOR_UPDATES.toFloat(), this)
                    Log.d("Network", "Network")
                    // why / how / when would this be null?
                    // does requestLocationUpdates possibly set it to null? :
                    if (locationManager != null) {
                        location = locationManager!!
                                .getLastKnownLocation(LocationManager.NETWORK_PROVIDER)
                        if (location != null) {
                            latitude = location!!.latitude
                            longitude = location!!.longitude
                        }
                    }
                }

                // Note: another if, not else, because we want to keep both
                // options optional

                // if GPS Enabled get lat/long using GPS Services
                if (isGPSEnabled) {
                    if (location == null) {
                        enforcePermission("android.permission.ACCESS_COARSE_LOCATION", 0, 0, "Missing permission: ACCESS_COARSE_LOCATION")
                        enforcePermission("android.permission.ACCESS_FINE_LOCATION", 0, 0, "Missing permission: ACCESS_FINE_LOCATION")
                        locationManager!!.requestLocationUpdates(
                                LocationManager.GPS_PROVIDER,
                                MIN_TIME_BW_UPDATES,
                                MIN_DISTANCE_CHANGE_FOR_UPDATES.toFloat(), this)
                        Log.d("GPS Enabled", "GPS Enabled")
                        // why / how / when would this be null?
                        // does requestLocationUpdates possibly set it to null?
                        // :
                        if (locationManager != null) {
                            location = locationManager!!
                                    .getLastKnownLocation(LocationManager.GPS_PROVIDER)
                            if (location != null) {
                                latitude = location!!.latitude
                                longitude = location!!.longitude
                            }
                        }
                    }
                }
            }

        } catch (e: Exception) {
            e.printStackTrace()
        }

        return location
    }

    /**
     * Stop using GPS listener Calling this function will stop using GPS in your
     * app, but will not disable GPS
     */
    fun stopUsingGPS() {
        if (locationManager != null) {
            locationManager!!.removeUpdates(this@GPSTracker)
        }
    }

    /**
     * Function to get latitude
     */
    fun getLatitude(): Double {
        if (location != null) {
            latitude = location!!.latitude
        }

        return latitude
    }

    /**
     * Function to get longitude
     */
    fun getLongitude(): Double {
        if (location != null) {
            longitude = location!!.longitude
        }

        return longitude
    }

    /**
     * Function to check GPS/wifi enabled
     *
     * @return boolean
     */
    fun canGetLocation(): Boolean {
        return this.canGetLocation
    }

    /**
     * Function to show settings alert dialog On pressing Settings button will
     * lauch Settings Options
     */
    fun showSettingsAlert() {
        val alertDialog = AlertDialog.Builder(mContext)

        // Setting Dialog Title
        alertDialog.setTitle("GPS is settings")

        // Setting Dialog Message
        alertDialog
                .setMessage("GPS is not enabled. Do you want to go to settings menu?")

        // On pressing Settings button
        alertDialog.setPositiveButton("Settings"
        ) { _, _ ->
            val intent = Intent(
                    Settings.ACTION_LOCATION_SOURCE_SETTINGS)
            mContext.startActivity(intent)
        }

        // on pressing cancel button
        alertDialog.setNegativeButton("Cancel"
        ) { dialog, _ -> dialog.cancel() }

        // Showing Alert Message
        alertDialog.show()
    }

    /**
     * Unused
     */
    override fun onLocationChanged(location: Location) {
        // Geocoder geocoder;
        // List<Address> addresses;
        // geocoder = new Geocoder(this, Locale.getDefault());
        // try {
        // addresses = geocoder.getFromLocation(location.getLatitude(),
        // location.getLongitude(), 1);

        // String address = addresses.get(0).getAddressLine(0);
        // String city = addresses.get(0).getAddressLine(1);
        // String country = addresses.get(0).getAddressLine(2);

        /*
		 * Toast.makeText( this.mContext, "Your Location is - \nLat: " +
		 * latitude + "\nLong: " + longitude + "\nAddress: " + address + ; *
		 * "\n" + city + "\n"+ country, Toast.LENGTH_LONG) .show();
		 */
        // Toast.makeText(
        // this.mContext,
        // "Your Location is - \nLat: " + latitude + "\nLong: "
        // + longitude, Toast.LENGTH_LONG).show();
        // } catch (Exception e) {
        // e.printStackTrace();
        // }

    }

    /**
     * Unused
     */
    override fun onProviderDisabled(provider: String) {}

    /**
     * Unused
     */
    override fun onProviderEnabled(provider: String) {}

    /**
     * Unused
     */
    override fun onStatusChanged(provider: String, status: Int, extras: Bundle) {}

    /**
     * Unused
     */
    override fun onBind(arg0: Intent): IBinder? {
        return null
    }

    companion object {

        // The minimum distance to change Updates in meters
        private val MIN_DISTANCE_CHANGE_FOR_UPDATES: Long = 10 // 10 meters

        // The minimum time between updates in milliseconds
        private val MIN_TIME_BW_UPDATES = (1000 * 60 * 1).toLong()
    }
}
