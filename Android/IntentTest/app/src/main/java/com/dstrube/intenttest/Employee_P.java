package com.dstrube.intenttest;

import android.os.Parcel;
import android.os.Parcelable;

public class Employee_P implements Parcelable {
    private String name;
    private String emailAddress;
    private String phoneNumber;
    //private String[] array;

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(name);
        dest.writeString(emailAddress);
        dest.writeString(phoneNumber);
        //array = new String[]{name,emailAddress,phoneNumber};
        //dest.writeStringArray(array);
    }

    private void readFromParcel(Parcel in) {
        name = in.readString();
        emailAddress = in.readString();
        phoneNumber = in.readString();
    }

    private Employee_P(Parcel in){
        super();
        //in.readStringArray(array);
//		in.readString()
        readFromParcel(in);
    }

    public static final Parcelable.Creator<Employee_P> CREATOR = new Parcelable.Creator<Employee_P>() {
        public Employee_P createFromParcel(Parcel in) {
            return new Employee_P(in);
        }

        public Employee_P[] newArray(int size) {
            return new Employee_P[size];
        }
    };

    public Employee_P() {
        setName("");
        setEmailAddress("");
        setPhoneNumber("");
        //array = new String[]{name,emailAddress,phoneNumber};
    }

    public Employee_P(String name, String emailAddress, String phoneNumber) {
        setName(name);
        setEmailAddress(emailAddress);
        setPhoneNumber(phoneNumber);
        //array = new String[]{name,emailAddress,phoneNumber};
    }

    public String getName() {
        return name;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setName(String name) {
        this.name = name;
    }

    private void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    private void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}

