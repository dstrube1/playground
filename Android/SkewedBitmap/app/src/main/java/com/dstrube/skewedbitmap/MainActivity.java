package com.dstrube.skewedbitmap;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.os.Environment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.SeekBar;
import android.widget.Spinner;
import android.widget.TextView;

import java.io.File;

public class MainActivity extends AppCompatActivity {
    private final static String TAG = MainActivity.class.getName();

    /**************  Image path on SDCARD ********/
    //Environment.getExternalStorageDirectory().getPath() == /mnt/sdcard
//    private final String imageInSD =  Environment.getExternalStorageDirectory().getPath() + "/download/8503106632138381758.jpg";//"/sdcard/download.jpg";

    ImageView myImageView;
    Spinner spinnerScale;
    SeekBar seekbarRotate;
    SeekBar seekbarSkewX, seekbarSkewY;
    TextView textSkewX, textSkewY;

    private static final String[] strScale  = {"0.2x", "0.5x", "1.0x", "2.0x", "5.0x"};
    private static final Float[] floatScale = {0.2F, 0.5F, 1F, 2F, 5F};
    private final int defaultSpinnerScaleSelection = 2;

    private ArrayAdapter<String> adapterScale;

    private float curScale = 1F;
    private float curRotate = 0F;
    private float curSkewX = 0F;
    private float curSkewY = 0F;

    Bitmap bitmap;
    int bmpWidth, bmpHeight;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        myImageView = findViewById(R.id.imageview);

        spinnerScale = findViewById(R.id.scale);
        seekbarRotate = findViewById(R.id.rotate);
        seekbarSkewX = findViewById(R.id.skewx);
        seekbarSkewY = findViewById(R.id.skewy);
        textSkewX = findViewById(R.id.textskewx);
        textSkewY = findViewById(R.id.textskewy);

        adapterScale = new ArrayAdapter<>(this,android.R.layout.simple_spinner_item, strScale);
        adapterScale.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinnerScale.setAdapter(adapterScale);
        spinnerScale.setSelection(defaultSpinnerScaleSelection);

        curScale = floatScale[defaultSpinnerScaleSelection];

        final String[] paths = {
//                Environment.getExternalStorageDirectory().getPath(),              // /storage/emulated/0
//                Environment.getDataDirectory().getPath(),                         // /data
//                Environment.getDownloadCacheDirectory().getPath(),                // /cache
                Environment.getRootDirectory().getPath(),                         // /system
//                getExternalFilesDir(Environment.DIRECTORY_PICTURES).getPath(),    // /storage/emulated/0/Android/data/com.dstrube.skewedbitmap/files/Pictures
                getExternalFilesDir(Environment.DIRECTORY_DCIM).getPath(),        // /storage/emulated/0/Android/data/com.dstrube.skewedbitmap/files/DCIM
//                getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS).getPath(),   // /storage/emulated/0/Android/data/com.dstrube.skewedbitmap/files/Download
//                "/"
        };
        //To get the app to find the image, I had to first use the File Manager app to find an image in /storage/emulated/0/DCIM/Camera/...,
        // then copy it from there to /storage/emulated/0/Android/data/com.dstrube.skewedbitmap/files/DCIM/
        //^ Pain in the butt trial and error to figure this out. There's gotta be a better way.

        String imagePath = "";
        for (String path : paths){
            imagePath = getImage(path);
            if (imagePath != null){
                break;
            }
        }
        if (imagePath == null || imagePath.equals(""))
        {
            Log.e(TAG, "null imagePath");
            return;
        }

        bitmap = BitmapFactory.decodeFile(imagePath);
        if (bitmap == null){
            Log.e(TAG, "null bitmap");
            return;
        }
        bmpWidth = bitmap.getWidth();
        bmpHeight = bitmap.getHeight();

        drawMatrix();

        spinnerScale.setOnItemSelectedListener(spinnerScaleOnItemSelectedListener);
        seekbarRotate.setOnSeekBarChangeListener(seekbarRotateSeekBarChangeListener);
        seekbarSkewX.setOnSeekBarChangeListener(seekbarSkewXSeekBarChangeListener);
        seekbarSkewY.setOnSeekBarChangeListener(seekbarSkewYSeekBarChangeListener);
    }

    private String getImage(final String path){
        File file = new File(path);
        if (!file.exists()){
            Log.e(TAG, "file not exists: " + path);
            return null;
        }
        File[] files = file.listFiles();
        if (files == null){
            Log.e(TAG, "no files found in " + path);
            return null;
        }
        for (File f : files){
            if (f.isDirectory()){
                String temp = getImage(f.getAbsolutePath());
                if (temp != null)
                    return  temp;
                else
                    continue;
            }
            Log.i(TAG, "file: " + f.getName());
            if (f.getName().toLowerCase().endsWith(".jpg") || f.getName().toLowerCase().endsWith(".png")){
                return f.getAbsolutePath();
            }
        }
        return null;
    }

    private void drawMatrix(){

        Matrix matrix = new Matrix();
        matrix.postScale(curScale, curScale);
        matrix.postRotate(curRotate);
        matrix.postSkew(curSkewX, curSkewY);

        // Recreate bitmap image according to matrix values

        Bitmap resizedBitmap = Bitmap.createBitmap(bitmap, 0, 0, bmpWidth, bmpHeight, matrix, true);
        myImageView.setImageBitmap(resizedBitmap);

    }

    //region Override Seekbar Methods

    private SeekBar.OnSeekBarChangeListener seekbarSkewYSeekBarChangeListener
            = new SeekBar.OnSeekBarChangeListener() {

        @Override
        public void onStopTrackingTouch(SeekBar seekBar) {
            // TODO Auto-generated method stub

        }

        @Override
        public void onStartTrackingTouch(SeekBar seekBar) {
            // TODO Auto-generated method stub

        }

        @Override
        public void onProgressChanged(SeekBar seekBar, int progress,
                                      boolean fromUser) {
            // TODO Auto-generated method stub
            curSkewY = (float)(progress-100)/100;
            textSkewY.setText("Skew-Y: " + String.valueOf(curSkewY));
            drawMatrix();
        }
    };

    private SeekBar.OnSeekBarChangeListener seekbarSkewXSeekBarChangeListener
            = new SeekBar.OnSeekBarChangeListener(){

        @Override
        public void onProgressChanged(SeekBar seekBar, int progress,
                                      boolean fromUser) {
            // TODO Auto-generated method stub
            curSkewX = (float)(progress-100)/100;
            textSkewX.setText("Skew-X: " + String.valueOf(curSkewX));
            drawMatrix();
        }

        @Override
        public void onStartTrackingTouch(SeekBar seekBar) {
            // TODO Auto-generated method stub

        }

        @Override
        public void onStopTrackingTouch(SeekBar seekBar) {
            // TODO Auto-generated method stub

        }
    };

    private SeekBar.OnSeekBarChangeListener seekbarRotateSeekBarChangeListener
            = new SeekBar.OnSeekBarChangeListener(){

        @Override
        public void onProgressChanged(SeekBar seekBar, int progress,
                                      boolean fromUser) {
            curRotate = (float)progress;
            drawMatrix();
        }

        @Override
        public void onStartTrackingTouch(SeekBar seekBar) {
        }

        @Override
        public void onStopTrackingTouch(SeekBar seekBar) {
        }
    };

    private Spinner.OnItemSelectedListener spinnerScaleOnItemSelectedListener
            = new Spinner.OnItemSelectedListener(){

        @Override
        public void onItemSelected(AdapterView<?> arg0, View arg1,
                                   int arg2, long arg3) {
            curScale = floatScale[arg2];
            drawMatrix();

        }

        @Override
        public void onNothingSelected(AdapterView<?> arg0) {
            spinnerScale.setSelection(defaultSpinnerScaleSelection);
            curScale = floatScale[defaultSpinnerScaleSelection];
        }
    };

    public void Reset(View v){
        seekbarSkewX.setProgress(100);
        seekbarSkewY.setProgress(100);
        spinnerScale.setSelection(defaultSpinnerScaleSelection, true);
        seekbarRotate.setProgress(0);
    }

    //endregion
}
