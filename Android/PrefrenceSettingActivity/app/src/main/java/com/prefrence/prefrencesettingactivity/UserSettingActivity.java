package com.prefrence.prefrencesettingactivity;

import android.app.Activity;
import android.os.Bundle;

 
public class UserSettingActivity extends Activity {
 

	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState); 
        //this makes it incompatible with API 10:
        getFragmentManager().beginTransaction().replace(android.R.id.content,
                new SettingFragment()).commit();
 
    }
}
