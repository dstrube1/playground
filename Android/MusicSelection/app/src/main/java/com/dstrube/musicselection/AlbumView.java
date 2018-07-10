package com.dstrube.musicselection;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;

public class AlbumView extends LinearLayout {
    private TextView albumNameText,songNameText;

    //	private String albumImage="", albumName="",songName="";
    public AlbumView(Context context) {
        super(context);
    }

    public AlbumView(Context context, AttributeSet attrs) {
        super(context, attrs);
        finishConstruction(context, attrs);
    }

    //@SuppressLint("NewApi")
    public AlbumView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        finishConstruction(context, attrs);
    }

    private void finishConstruction(Context context, AttributeSet attrs){

        LayoutInflater inflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        inflater.inflate(R.layout.album_view, this);
        TypedArray arr = context.obtainStyledAttributes(attrs, R.styleable.AlbumView);
//		http://stackoverflow.com/questions/4495511/how-to-pass-custom-component-parameters-in-java-and-xml
        //we call these *_cs because CharSequence is apparently interchangable with String,
        //and this is a less-confusing name for local vars
        String albumImage_cs = arr.getString(R.styleable.AlbumView_albumImage);
        if (albumImage_cs  != null) {
            setAlbumImage(albumImage_cs);
        }
        String albumName_cs = arr.getString(R.styleable.AlbumView_albumName);
        if (albumName_cs  != null) {
            setAlbumName(albumName_cs);
        }
        String songName_cs = arr.getString(R.styleable.AlbumView_songName);
        if (songName_cs  != null) {
            setSongName(songName_cs);
        }
        arr.recycle();
    }

    public void setAlbumImage(String albumImage){
        ImageButton albumImageButton = findViewById(R.id.albumImage);
        //in ListView
        if (albumImageButton == null){
            albumImageButton = new ImageButton(getContext());
        }
//		this.albumImage = albumImage;
        final Resources res = getResources();
        final int resID = res.getIdentifier(albumImage , "drawable","com.dstrube.musicselection");
        final Drawable drawable = res.getDrawable(resID );
        albumImageButton.setImageDrawable(drawable );
    }
    public void setAlbumName(String albumName){
        albumNameText = findViewById(R.id.albumName);
        if (albumNameText == null){
            albumNameText = new TextView(getContext());
        }
        albumNameText.setText(albumName);
    }
    public void setSongName(String songName){
        songNameText = findViewById(R.id.songName);
        if (songNameText == null){
            songNameText = new TextView(getContext());
        }
        songNameText.setText(songName);
    }
    public String getAlbumImage(){return "";}//albumImage;}
    public String getAlbumName(){return albumNameText.getText().toString();}
    public String getSongName(){return songNameText.getText().toString();}
}
