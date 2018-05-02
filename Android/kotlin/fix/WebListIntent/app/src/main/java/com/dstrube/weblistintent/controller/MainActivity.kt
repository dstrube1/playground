package com.dstrube.weblistintent.controller

import android.app.Activity
import android.app.Fragment
import android.os.Bundle
import com.dstrube.weblistintent.R
import android.content.Intent
import com.dstrube.weblistintent.view.ContentFragment
import android.view.ViewGroup
import android.view.LayoutInflater
import android.view.View
import android.widget.FrameLayout
import com.dstrube.weblistintent.controller.MainActivity.PlaceholderFragment




class MainActivity : Activity(), ChangeLinkListener {//extends Activity implements ChangeLinkListener

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        if (savedInstanceState == null) {
            fragmentManager.beginTransaction()
                    .add(R.id.container, PlaceholderFragment())
                    .commit()
        }
    }

    override fun onLinkChange(link: String?) {
        if (findViewById<FrameLayout>(R.id.contentFragment) != null) {
            var contentFragment: ContentFragment? = fragmentManager.findFragmentById(R.id.contentFragment) as ContentFragment
            if (contentFragment == null) {
                contentFragment = ContentFragment()
                contentFragment.init(link!!)
                // We are in dual fragment (Tablet or phone landscape)
                val fm = fragmentManager
                val ft = fm.beginTransaction()

                // contentFragment.updateUrl(link);
                ft.replace(R.id.contentFragment, contentFragment)
                ft.commit()
            } else {
                contentFragment.updateUrl(link!!)
            }
        } else {
            val i = Intent(this, ContentFragmentActivity::class.java)
            i.putExtra("link", link)
            startActivity(i)
        }

    }


    /**
     * A placeholder fragment containing a simple view.
     */
    class PlaceholderFragment : Fragment() {

        override fun onCreateView(inflater: LayoutInflater, container: ViewGroup,
                         savedInstanceState: Bundle): View {
            return inflater.inflate(R.layout.fragment_main, container, false)
        }
    }
}
