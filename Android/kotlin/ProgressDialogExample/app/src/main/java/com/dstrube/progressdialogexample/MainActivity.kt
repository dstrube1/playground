package com.dstrube.progressdialogexample

import android.app.Activity
import android.app.ProgressDialog
import android.os.Bundle
import android.os.Handler
import android.view.View

class MainActivity : Activity() {

    private var barProgressDialog: ProgressDialog? = null
    private var updateBarHandler: Handler? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        updateBarHandler = Handler()
    }

    fun launchRingDialog(view: View) {
        val ringProgressDialog = ProgressDialog.show(this@MainActivity, "Please wait ...", "Downloading Image ...", true)
        ringProgressDialog.setCancelable(true)

        Thread(Runnable {
            try {
                // Here you should write your time consuming task...
                // Let the progress ring for 10 seconds...
                Thread.sleep(10000)
            } catch (e: Exception) {

            }

            ringProgressDialog.dismiss()
        }).start()
    }

    fun launchBarDialog(view: View) {
        barProgressDialog = ProgressDialog(this@MainActivity)

        barProgressDialog?.setTitle("Downloading Image ...")
        barProgressDialog?.setMessage("Download in progress ...")
        barProgressDialog?.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL)
        barProgressDialog?.progress = 0
        barProgressDialog?.max = 20
        barProgressDialog?.show()

        Thread(Runnable {
            try {

                // Here you should write your time consuming task...
                while (barProgressDialog?.progress!! <= barProgressDialog?.max!!) {

                    Thread.sleep(1000)

                    updateBarHandler?.post(/*Runnable*/ { barProgressDialog?.incrementProgressBy(2) })


                    if (barProgressDialog?.progress === barProgressDialog?.max) {

                        barProgressDialog?.dismiss()

                    }
                }
            } catch (e: Exception) {
            }
        }).start()
    }

}
