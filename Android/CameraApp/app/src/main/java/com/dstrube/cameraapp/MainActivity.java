package com.dstrube.cameraapp;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.VideoView;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    // Activity request codes
    private final int CAMERA_CAPTURE_IMAGE_REQUEST_CODE = 100;
    private final int CAMERA_CAPTURE_VIDEO_REQUEST_CODE = 200;
    public final int MEDIA_TYPE_IMAGE = 1;
    public final int MEDIA_TYPE_VIDEO = 2;

    // directory name to store captured images and videos
    private final String FILE_DIRECTORY_NAME = "CameraAppFiles";

    private String MODE;

    private Uri fileUri; // file url to store image/video

    private ImageView imgPreview;
    private VideoView videoPreview;
    private TextView previewText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    /**
     * This function is made unnecessary by the line in the manifest that checks
     * for this feature: android.hardware.camera
     *
     * @return
     */
    @SuppressWarnings("unused")
    private boolean isDeviceSupportCamera() {
        if (getApplicationContext().getPackageManager().hasSystemFeature(
                PackageManager.FEATURE_CAMERA)) {
            // this device has a camera
            return true;
        } else {
            // no camera on this device
            return false;
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        imgPreview = findViewById(R.id.imgPreview);
        videoPreview = findViewById(R.id.videoPreview);
        previewText = findViewById(R.id.previewText);
    }

    /**
     * Creating file uri to store image/video
     */
    public Uri getOutputMediaFileUri(int type) {
        File file = getOutputMediaFile(type);
        if (file == null){
            //Toast error was thrown earlier
            return null;
        }
        return Uri.fromFile(file);
    }

    /*
     * returning image / video
     */
    private File getOutputMediaFile(int type) {
        // External sdcard location
        File mediaStorageDir;
        if (MODE.equals(Environment.DIRECTORY_PICTURES)){
            mediaStorageDir = new File(
                    Environment
                            .getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),
                    FILE_DIRECTORY_NAME);
        }else if (MODE.equals(Environment.DIRECTORY_MOVIES)){
            mediaStorageDir = new File(
                    Environment
                            .getExternalStoragePublicDirectory(Environment.DIRECTORY_MOVIES),
                    FILE_DIRECTORY_NAME);
        }else{
            Toast.makeText(getApplicationContext(), "Error getting media storage directory. Unknown (probably unset) mode.", Toast.LENGTH_LONG).show();
            return null;
        }
        // Create the storage directory if it does not exist
        if (!mediaStorageDir.exists()) {
            if (!mediaStorageDir.mkdirs()) {
                Toast.makeText(getApplicationContext(),FILE_DIRECTORY_NAME + ": Oops! Failed create "
                        + FILE_DIRECTORY_NAME + " directory",Toast.LENGTH_SHORT).show();
//	            System.out.println(FILE_DIRECTORY_NAME + ": Oops! Failed create "
//	                    + FILE_DIRECTORY_NAME + " directory");
                return null;
            }
        }
        // Create a media file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss",
                Locale.getDefault()).format(new Date());
        File mediaFile;
        if (type == MEDIA_TYPE_IMAGE) {
            mediaFile = new File(mediaStorageDir.getPath() + File.separator
                    + "IMG_" + timeStamp + ".jpg");
        } else if (type == MEDIA_TYPE_VIDEO) {
            mediaFile = new File(mediaStorageDir.getPath() + File.separator
                    + "VID_" + timeStamp + ".mp4");
        }else {
            return null;
        }

        return mediaFile;
    }

    public void PictureClick(View v) {
        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);

        MODE = Environment.DIRECTORY_PICTURES;
        fileUri = getOutputMediaFileUri(MEDIA_TYPE_IMAGE);

        if (fileUri == null){
            //Toast error was thrown earlier
            return;
        }

        intent.putExtra(MediaStore.EXTRA_OUTPUT, fileUri);

        // start the image capture Intent
        startActivityForResult(intent, CAMERA_CAPTURE_IMAGE_REQUEST_CODE);
    }

    public void VideoClick(View v) {
        Intent intent = new Intent(MediaStore.ACTION_VIDEO_CAPTURE);

        MODE = Environment.DIRECTORY_MOVIES;
        fileUri = getOutputMediaFileUri(MEDIA_TYPE_VIDEO);

        if (fileUri == null){
            //Toast error was thrown earlier
            return;
        }

        // set video quality
        // 1 for high quality video
        // 0 for low quality
        intent.putExtra(MediaStore.EXTRA_VIDEO_QUALITY, 1);

        intent.putExtra(MediaStore.EXTRA_OUTPUT, fileUri);

        // start the video capture Intent
        startActivityForResult(intent, CAMERA_CAPTURE_VIDEO_REQUEST_CODE);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        // super.onActivityResult(arg0, arg1, arg2);
        // if the result is capturing Image
        if (requestCode == CAMERA_CAPTURE_IMAGE_REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                // successfully captured the image
                // display it in image view
                previewCapturedImage();
            } else if (resultCode == RESULT_CANCELED) {
                // user cancelled Image capture
                Toast.makeText(getApplicationContext(),
                        "User cancelled image capture", Toast.LENGTH_SHORT)
                        .show();
            } else {
                // failed to capture image
                Toast.makeText(getApplicationContext(),
                        "Sorry! Failed to capture image.", Toast.LENGTH_SHORT)
                        .show();
            }
        } else if (requestCode == CAMERA_CAPTURE_VIDEO_REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                // video successfully recorded
                // preview the recorded video
                previewVideo();
            } else if (resultCode == RESULT_CANCELED) {
                // user cancelled recording
                Toast.makeText(getApplicationContext(),
                        "User cancelled video recording", Toast.LENGTH_SHORT)
                        .show();
            } else {
                // failed to capture image
                Toast.makeText(getApplicationContext(),
                        "Sorry! Failed to capture video.", Toast.LENGTH_SHORT)
                        .show();
            }
        }

    }

    /*
     * Display image from a path to ImageView
     */
    private void previewCapturedImage() {
        try {
            previewText.setVisibility(View.VISIBLE);

            // hide video preview
            videoPreview.setVisibility(View.GONE);

            imgPreview.setVisibility(View.VISIBLE);

            // bimatp factory
            BitmapFactory.Options options = new BitmapFactory.Options();

            // downsizing image as it throws OutOfMemory Exception for larger
            // images
            options.inSampleSize = 8;

            final Bitmap bitmap = BitmapFactory.decodeFile(fileUri.getPath(),
                    options);

            imgPreview.setImageBitmap(bitmap);
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
    }

    /*
     * Previewing recorded video
     */
    private void previewVideo() {
        try {
            previewText.setVisibility(View.VISIBLE);
            // hide image preview
            imgPreview.setVisibility(View.GONE);

            videoPreview.setVisibility(View.VISIBLE);
            videoPreview.setVideoPath(fileUri.getPath());
            // start playing
            videoPreview.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Here we store the file url as it will be null after returning from camera
     * app
     */
    @Override
    protected void onSaveInstanceState(Bundle outState) {
         super.onSaveInstanceState(outState); //this was commented out in original code; not sure why
        // save file url in bundle as it will be null on screen orientation
        // changes
        outState.putParcelable("file_uri", fileUri);
    }

    /*
     * Here we restore the fileUri again
     */
    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);
        // get the file url
        fileUri = savedInstanceState.getParcelable("file_uri");
    }

}
