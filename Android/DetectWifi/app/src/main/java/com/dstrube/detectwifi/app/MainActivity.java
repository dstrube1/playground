package com.dstrube.detectwifi.app;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

import java.util.ArrayList;
import java.util.List;


public class MainActivity extends Activity {

    private Spinner spinner;
    private ArrayAdapter<String> adapter;
    private WifiManager wifiManager;
    private WifiReceiver wifiReceiver;
    private List<ScanResult> wifiList;
    private ArrayList<String> spinnerList;

    class WifiReceiver extends BroadcastReceiver {
        public void onReceive(Context c, Intent intent) {
            wifiList = wifiManager.getScanResults();
            for (int i = 0; i < wifiList.size(); i++) {
//				spinnerList.add(wifiList.get(i).toString());
                spinnerList.add(wifiList.get(i).SSID);
            }
            adapter = new ArrayAdapter<>(MainActivity.this,
                    android.R.layout.simple_spinner_item, spinnerList);
            adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
            spinner.setAdapter(adapter);
        }
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        // getBaseContext();
        // ConnectivityManager connectivityManager = (ConnectivityManager)
        // getSystemService(Context.CONNECTIVITY_SERVICE);
        // // Check for network connections
        // if (connectivityManager.getNetworkInfo(0).getState() ==
        // android.net.NetworkInfo.State.CONNECTED
        // || connectivityManager.getNetworkInfo(0).getState() ==
        // android.net.NetworkInfo.State.CONNECTING
        // || connectivityManager.getNetworkInfo(1).getState() ==
        // android.net.NetworkInfo.State.CONNECTING
        // || connectivityManager.getNetworkInfo(1).getState() ==
        // android.net.NetworkInfo.State.CONNECTED) {
        // // if connected with internet
        // Toast.makeText(this, " Connected ", Toast.LENGTH_LONG).show();
        // }
        // NetworkInfo [] infos = connectivityManager.getAllNetworkInfo();
        // ArrayList<String> list = new ArrayList<String>();
        // for (NetworkInfo info : infos){
        // list.add(info.toString());
        // }
        wifiList = new ArrayList<>();
        spinnerList = new ArrayList<>();

        wifiReceiver = new WifiReceiver();
        registerReceiver(wifiReceiver, new IntentFilter(
                WifiManager.SCAN_RESULTS_AVAILABLE_ACTION));

        wifiManager = (WifiManager) getSystemService(Context.WIFI_SERVICE);
        wifiManager.startScan();

        spinner = findViewById(R.id.spinner1);
    }


    @Override
    protected void onPause() {
        unregisterReceiver(wifiReceiver);
        super.onPause();
    }

    //TODO: refresh menu option

    @Override
    protected void onResume() {
        super.onResume();
        registerReceiver(wifiReceiver, new IntentFilter(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION));
    }
}
