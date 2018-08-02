package com.dstrube.globalvariabletest;

import android.app.Application;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.Log;

//Must implement parcelable if we want this to persist across activity restore / save

public class GlobalClass extends Application implements Parcelable {
    private String name="";
    private String email="";
    private static final String TAG = GlobalClass.class.getName();

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(name);
        dest.writeString(email);
    }

    @Override
    public int describeContents() {
        return 0;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public static final Parcelable.Creator<GlobalClass> CREATOR
            = new Parcelable.Creator<GlobalClass>() {
        public GlobalClass createFromParcel(Parcel in) {
            return new GlobalClass(in);
        }

        public GlobalClass[] newArray(int size) {
            return new GlobalClass[size];
        }
    };

    //default constructor required for application name pointing to this class in manifest
    public GlobalClass(){}

    private GlobalClass(Parcel in){
        int data = in.readInt();
        Log.d(TAG, "Data = " + data);
    }
}
