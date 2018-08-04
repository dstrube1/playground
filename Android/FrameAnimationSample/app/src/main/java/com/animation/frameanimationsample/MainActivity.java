package com.animation.frameanimationsample;

import android.os.Bundle;
import android.app.Activity;
import android.graphics.drawable.AnimationDrawable;
//import android.view.Menu;
import android.view.MotionEvent;
import android.widget.ImageView;

public class MainActivity extends Activity {
    AnimationDrawable logoAnimation;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ImageView logoImage = findViewById(R.id.iv1);
        logoImage.setBackgroundResource(R.drawable.logo_animation);
        logoAnimation = (AnimationDrawable) logoImage.getBackground();
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        if (event.getAction() == MotionEvent.ACTION_DOWN) {
            logoAnimation.start();
            return true;

        } else return super.onTouchEvent(event);
    }
}