package com.drawable.drawablebutton;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;

//////////////////
/* 
* DrawableButton
* This is an illustration of available customizations for buttons.
* In drawable_button.xml, there are:
* button1 - a normal button
* button2 - customized button; note: android:background="@drawable/button_customize" => buttoncustomize.xml - shape android:shape="ring", or whatever
* button3 - Customized Button with Image: drawableTop
* imageButton1 - pretty straightforward
* new_game - android:background="@drawable/button_menu" => buttonmenu.xml - mouseOver and pressed state images
*/
//////////////////
public class DrawableButtonActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.drawable_button);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.drawable_button, menu);
		return true;
	}

}
