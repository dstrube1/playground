package com.dstrube.hellovolley;

import android.arch.lifecycle.LiveData;
import android.arch.lifecycle.MediatorLiveData;
import android.arch.lifecycle.ViewModel;

import com.dstrube.hellovolley.Model.Contact;
import com.dstrube.hellovolley.util.MyLogger;

public class UserModel extends ViewModel {
    public final LiveData<Contact> userLiveData;

    public UserModel() {
        MyLogger.Log(MyLogger.Level.INFO, "Constructor");
        userLiveData = new MediatorLiveData<>();
    }

    void doAction() {
        // depending on the action, do necessary business logic calls and update the
        // userLiveData.
    }
}