package com.example.skewedbitmap;

import android.os.Bundle;
import android.os.Environment;
import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.SeekBar;
import android.widget.Spinner;
import android.widget.TextView;

public class MainActivity extends Activity {
	  
    /**************  Image path on SDCARD ********/
	//Environment.getExternalStorageDirectory().getPath() == /mnt/sdcard
    private final String imageInSD =  Environment.getExternalStorageDirectory().getPath() + "/download/8503106632138381758.jpg";//"/sdcard/download.jpg";
     
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
     
      /** Called when the activity is first created. */
      @Override
      public void onCreate(Bundle savedInstanceState) {
          super.onCreate(savedInstanceState);
          setContentView(R.layout.activity_main);
          
          myImageView = (ImageView)findViewById(R.id.imageview);
          
          spinnerScale = (Spinner)findViewById(R.id.scale);
          seekbarRotate = (SeekBar)findViewById(R.id.rotate);
          seekbarSkewX = (SeekBar)findViewById(R.id.skewx);
          seekbarSkewY = (SeekBar)findViewById(R.id.skewy);
          textSkewX = (TextView)findViewById(R.id.textskewx);
          textSkewY = (TextView)findViewById(R.id.textskewy);
          
          adapterScale = new ArrayAdapter<String>(this,android.R.layout.simple_spinner_item, strScale);
          adapterScale.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
          spinnerScale.setAdapter(adapterScale);
          spinnerScale.setSelection(defaultSpinnerScaleSelection);
          
          curScale = floatScale[defaultSpinnerScaleSelection];
          
          bitmap = BitmapFactory.decodeFile(imageInSD);
          bmpWidth = bitmap.getWidth();
          bmpHeight = bitmap.getHeight();
          
          drawMatrix();
          
          spinnerScale.setOnItemSelectedListener(spinnerScaleOnItemSelectedListener);
          seekbarRotate.setOnSeekBarChangeListener(seekbarRotateSeekBarChangeListener);
          seekbarSkewX.setOnSeekBarChangeListener(seekbarSkewXSeekBarChangeListener);
          seekbarSkewY.setOnSeekBarChangeListener(seekbarSkewYSeekBarChangeListener);
      }
      
      private void drawMatrix(){
        
          Matrix matrix = new Matrix();
          matrix.postScale(curScale, curScale);
          matrix.postRotate(curRotate);
          matrix.postSkew(curSkewX, curSkewY);
           
          // Recreate bitmap image accroding to matrix values
           
          Bitmap resizedBitmap = Bitmap.createBitmap(bitmap, 0, 0, bmpWidth, bmpHeight, matrix, true);
          myImageView.setImageBitmap(resizedBitmap);
        
      }
      
     /************** Override Seekbar Methods ***************/
      
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
      
     /************** Override Seekbar Methods ***************/
      
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
      
     /************** Override Seekbar Methods ***************/
      
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
      
     /************** Override Spinner Methods ***************/
      
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
}