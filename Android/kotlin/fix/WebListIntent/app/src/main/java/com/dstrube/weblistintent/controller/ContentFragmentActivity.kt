package com.dstrube.weblistintent.controller

//import android.content.Intent.getIntent
//import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.support.v4.app.FragmentActivity;
import com.dstrube.weblistintent.view.ContentFragment

class ContentFragmentActivity : FragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)//super.onCreate(arg0)

        val contentFragment = ContentFragment()

        val i = this.getIntent()
        val link = i.getExtras()!!.getString("link")

        contentFragment.init(link)
        getFragmentManager().beginTransaction().add(android.R.id.content, contentFragment).commit()
    }
}