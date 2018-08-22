package com.test.customList.network;

import android.os.Parcel;
import android.os.Parcelable;

public class MusicVO implements Parcelable {
	
	private String id;
	private String title;
	private String artist;
	private String duration;
	private String thumb_Url;
	
	 public MusicVO(String id, String title, String artist, String duration,String thumb_Url) {
		this.id = id;
		this.title = title;
		this.artist = artist;
		this.duration = duration;
		this.thumb_Url = thumb_Url;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public String getThumb_Url() {
		return thumb_Url;
	}

	public void setThumb_Url(String thumb_Url) {
		this.thumb_Url = thumb_Url;
	}

	public void readFromParcel(Parcel in) {
		id = in.readString();
		title = in.readString();
		artist = in.readString();
		duration = in.readString();
		thumb_Url = in.readString();
	}
	 
	public int describeContents() {
		return 0;
	}

	public void writeToParcel(Parcel dest, int flags) {
		dest.writeString(id);
		dest.writeString(title);
		dest.writeString(artist);
		dest.writeString(duration);
		dest.writeString(thumb_Url);
	}
	
    private MusicVO(Parcel in) {
        super(); 
        readFromParcel(in);
    }
    
    public MusicVO(String none) {

    }

    public static final Parcelable.Creator<MusicVO> CREATOR = new Parcelable.Creator<MusicVO>() {
        public MusicVO createFromParcel(Parcel in) {
            return new MusicVO(in);
        }
        public MusicVO[] newArray(int size) {

            return new MusicVO[size];
        }
    };

}
