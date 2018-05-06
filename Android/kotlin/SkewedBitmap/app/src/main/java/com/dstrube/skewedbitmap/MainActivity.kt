package com.dstrube.skewedbitmap

import android.app.Activity
import android.os.Bundle
import android.graphics.Bitmap
import android.view.View
import android.widget.*
import android.widget.ArrayAdapter
import android.R.attr.bitmap
import android.opengl.ETC1.getHeight
import android.opengl.ETC1.getWidth
import android.graphics.BitmapFactory
import android.os.Environment
import android.os.Environment.DIRECTORY_DCIM
import android.os.Environment.getRootDirectory
import android.util.Log
import android.R.attr.bitmap
import android.graphics.Matrix
//import com.sun.tools.corba.se.idl.Util.getAbsolutePath
import java.io.File
import android.widget.SeekBar
import android.widget.AdapterView
import android.widget.AdapterView.OnItemSelectedListener






class MainActivity : Activity() {

    private val TAG = MainActivity::class.java.name

    /**************  Image path on SDCARD  */
    //Environment.getExternalStorageDirectory().getPath() == /mnt/sdcard
    //    private final String imageInSD =  Environment.getExternalStorageDirectory().getPath() + "/download/8503106632138381758.jpg";//"/sdcard/download.jpg";

    var myImageView: ImageView? = null
    var spinnerScale: Spinner? = null
    var seekbarRotate: SeekBar? = null
    var seekbarSkewX: SeekBar? = null
    var seekbarSkewY:SeekBar? = null
    var textSkewX: TextView? = null
    var textSkewY:TextView? = null

    private val strScale = arrayOf("0.2x", "0.5x", "1.0x", "2.0x", "5.0x")
    private val floatScale = arrayOf(0.2f, 0.5f, 1f, 2f, 5f)
    private val defaultSpinnerScaleSelection = 2

    private var adapterScale: ArrayAdapter<String>? = null

    private var curScale = 1f
    private var curRotate = 0f
    private var curSkewX = 0f
    private var curSkewY = 0f

    var bitmap: Bitmap? = null
    var bmpWidth: Int? = 0
    var bmpHeight:Int? = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        myImageView = findViewById(R.id.imageview)

        spinnerScale = findViewById(R.id.scale)
        seekbarRotate = findViewById(R.id.rotate)
        seekbarSkewX = findViewById(R.id.skewx)
        seekbarSkewY = findViewById(R.id.skewy)
        textSkewX = findViewById(R.id.textskewx)
        textSkewY = findViewById(R.id.textskewy)

        adapterScale = ArrayAdapter(this, android.R.layout.simple_spinner_item, strScale)
        adapterScale?.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        spinnerScale?.adapter = adapterScale
        spinnerScale?.setSelection(defaultSpinnerScaleSelection)

        curScale = floatScale[defaultSpinnerScaleSelection]

        val paths = arrayOf(
                //                Environment.getExternalStorageDirectory().getPath(),              // /storage/emulated/0
                //                Environment.getDataDirectory().getPath(),                         // /data
                //                Environment.getDownloadCacheDirectory().getPath(),                // /cache
                Environment.getRootDirectory().getPath(), // /system
                //                getExternalFilesDir(Environment.DIRECTORY_PICTURES).getPath(),    // /storage/emulated/0/Android/data/com.dstrube.skewedbitmap/files/Pictures
                getExternalFilesDir(Environment.DIRECTORY_DCIM)!!.path)// /storage/emulated/0/Android/data/com.dstrube.skewedbitmap/files/DCIM
        //                getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS).getPath(),   // /storage/emulated/0/Android/data/com.dstrube.skewedbitmap/files/Download
        //                "/"
        //To get the app to find the image, I had to first use the File Manager app to find an image in /storage/emulated/0/DCIM/Camera/...,
        // then copy it from there to /storage/emulated/0/Android/data/com.dstrube.skewedbitmap/files/DCIM/
        //^ Pain in the butt trial and error to figure this out. There's gotta be a better way.

        var imagePath: String? = ""
        for (path in paths) {
            Log.w(TAG, "Checking $path...")
            imagePath = getImage(path)
            if (imagePath != null) {
                break
            }
        }
        if (imagePath == null || imagePath == "") {
            Log.e(TAG, "null imagePath")
            return
        }

        bitmap = BitmapFactory.decodeFile(imagePath)//.toInt()
        if (bitmap == null) {
            Log.e(TAG, "null bitmap")
            return
        }
        bmpWidth = bitmap?.width
        bmpHeight = bitmap?.height

        drawMatrix()

        spinnerScale?.onItemSelectedListener = spinnerScaleOnItemSelectedListener
        seekbarRotate?.setOnSeekBarChangeListener(seekbarRotateSeekBarChangeListener)
        seekbarSkewX?.setOnSeekBarChangeListener(seekbarSkewXSeekBarChangeListener)
        seekbarSkewY?.setOnSeekBarChangeListener(seekbarSkewYSeekBarChangeListener)

    }

    private fun getImage(path: String): String? {
        val file = File(path)
        if (!file.exists()) {
            Log.e(TAG, "file not exists: $path")
            return null
        }
        val files = file.listFiles()
        if (files == null) {
            Log.e(TAG, "no files found in $path")
            return null
        }
        for (f in files!!) {
            if (f.isDirectory) {
                val temp = getImage(f.absolutePath)
                return temp ?: continue
            }
            Log.i(TAG, "file: " + f.name)
            if (f.name.toLowerCase().endsWith(".jpg") || f.name.toLowerCase().endsWith(".png")) {
                return f.absolutePath
            }
        }
        return null
    }

    private fun drawMatrix() {

        val matrix = Matrix()
        matrix.postScale(curScale, curScale)
        matrix.postRotate(curRotate)
        matrix.postSkew(curSkewX, curSkewY)

        // Recreate bitmap image according to matrix values

        val resizedBitmap = Bitmap.createBitmap(bitmap, 0, 0, bmpWidth!!, bmpHeight!!, matrix, true)
        myImageView?.setImageBitmap(resizedBitmap)

    }

    //region Override Seekbar Methods

    private val seekbarSkewYSeekBarChangeListener = object : SeekBar.OnSeekBarChangeListener {

        override fun onStopTrackingTouch(seekBar: SeekBar) {
            // TODO Auto-generated method stub

        }

        override fun onStartTrackingTouch(seekBar: SeekBar) {
            // TODO Auto-generated method stub

        }

        override fun onProgressChanged(seekBar: SeekBar, progress: Int,
                                       fromUser: Boolean) {
            // TODO Auto-generated method stub
            curSkewY = (progress - 100).toFloat() / 100
            textSkewY?.text = "Skew-Y: ${curSkewY}"
            drawMatrix()
        }
    }

    private val seekbarSkewXSeekBarChangeListener = object : SeekBar.OnSeekBarChangeListener {

        override fun onProgressChanged(seekBar: SeekBar, progress: Int,
                                       fromUser: Boolean) {
            // TODO Auto-generated method stub
            curSkewX = (progress - 100).toFloat() / 100
            textSkewX?.text = "Skew-X: $curSkewX"// + String.valueOf(curSkewX))
            drawMatrix()
        }

        override fun onStartTrackingTouch(seekBar: SeekBar) {
            // TODO Auto-generated method stub

        }

        override fun onStopTrackingTouch(seekBar: SeekBar) {
            // TODO Auto-generated method stub

        }
    }

    private val seekbarRotateSeekBarChangeListener = object : SeekBar.OnSeekBarChangeListener {

        override fun onProgressChanged(seekBar: SeekBar, progress: Int,
                                       fromUser: Boolean) {
            curRotate = progress.toFloat()
            drawMatrix()
        }

        override fun onStartTrackingTouch(seekBar: SeekBar) {}

        override fun onStopTrackingTouch(seekBar: SeekBar) {}
    }


    private val spinnerScaleOnItemSelectedListener = object : AdapterView.OnItemSelectedListener { //was Spinner.OnItemSelectedListener

        override fun onItemSelected(arg0: AdapterView<*>, arg1: View,
                           arg2: Int, arg3: Long) {
            curScale = floatScale[arg2]
            drawMatrix()

        }

        override fun onNothingSelected(arg0: AdapterView<*>) {
            spinnerScale?.setSelection(defaultSpinnerScaleSelection)
            curScale = floatScale[defaultSpinnerScaleSelection]
        }
    }

    fun Reset(v: View) {
        seekbarSkewX?.progress = 100
        seekbarSkewY?.progress = 100
        spinnerScale?.setSelection(defaultSpinnerScaleSelection, true)
        seekbarRotate?.progress = 0
    }
//endregion
}
