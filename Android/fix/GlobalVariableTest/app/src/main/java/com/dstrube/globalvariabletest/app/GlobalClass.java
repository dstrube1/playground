package com.dstrube.globalvariabletest.app;

import android.app.Application;
import android.os.Parcel;
import android.os.Parcelable;

/**
 * Created by unbounded on 6/11/2014.
 * Must implement parcelable if we want this to persist across activity restore / save
 */
public class GlobalClass extends Application implements Parcelable {
    private String name="";
    private String email="";

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

}
