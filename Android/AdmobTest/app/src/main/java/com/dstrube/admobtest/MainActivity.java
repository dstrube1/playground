package com.dstrube.admobtest;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.telephony.TelephonyManager;
import android.widget.RelativeLayout;
import android.widget.Toast;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // isGooglePlayServicesAvailable
        AdView adView = new AdView(this);// (AdView)findViewById(R.id.ad);
        // adView.setAdSize(AdSize.BANNER); //works
        // adView.setAdSize(AdSize.LARGE_BANNER); //works, slightly larger
        // adView.setAdSize(AdSize.FULL_BANNER); //works only in landscape mode;
        // weird
        // adView.setAdSize(AdSize.LEADERBOARD); //doesn't work?
        // adView.setAdSize(AdSize.MEDIUM_RECTANGLE); //big ad
        adView.setAdSize(AdSize.SMART_BANNER); // looks nicer than banner
        // adView.setAdSize(AdSize.WIDE_SKYSCRAPER); //doesn't work?
        // adView.setAdSize(AdSize.AUTO_HEIGHT); //invalid option
        // adView.setAdSize(AdSize.FULL_WIDTH); //invalid option

        adView.setAdUnitId(getResources().getString(R.string.ad_unit_id));

//        final TelephonyManager tm = (TelephonyManager) getBaseContext()
//                .getSystemService(Context.TELEPHONY_SERVICE);
//        String deviceid = tm.getDeviceId();

        AdRequest adRequest = new AdRequest.Builder()
                // .addTestDevice(AdRequest.DEVICE_ID_EMULATOR)
                //.addTestDevice(deviceid)
                // //////////////////////////////////////////////////////////////////////
                // //////////////// IMPORTANT: the above line ought to be there
                // when testing; and ought NOT be there when releasing to the
                // wild. See also this permission in manifest: READ_PHONE_STATE
                // //////////////////////////////////////////////////////////////////////
                .build();
        adView.loadAd(adRequest);

        RelativeLayout layoutR = findViewById(R.id.relativeLayout);
        if (layoutR != null) {

            // Toast.makeText(getApplicationContext(), "RelativeLayout",
            // Toast.LENGTH_SHORT).show();

            layoutR.addView(adView);

            RelativeLayout.LayoutParams params = (RelativeLayout.LayoutParams) adView
                    .getLayoutParams();
            params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
            adView.setLayoutParams(params);

        } else {
            // LinearLayout layoutL = (LinearLayout)
            // findViewById(R.id.linearLayout);
            // LinearLayout.LayoutParams params;
            Toast.makeText(getApplicationContext(), "LinearLayout",
                    Toast.LENGTH_SHORT).show();
            // layoutL.addView(adView);
        }

        // int available = GooglePlayServicesUtil
        // .isGooglePlayServicesAvailable(getApplicationContext());
        // Toast.makeText(getApplicationContext(),
        // "isGooglePlayServicesAvailable" + available, Toast.LENGTH_SHORT)
        // .show();
    }
}
