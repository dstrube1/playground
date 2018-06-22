package com.example.servicecommunication;

// Credit : http://www.chupamobile.com/tutorial/details/154/Android+Service+Tutorial/

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;

public class LocalWordService extends Service {
  private final IBinder mBinder = new MyBinder();
  private ArrayList<String> list = new ArrayList<>();

  @Override
  public int onStartCommand(Intent intent, int flags, int startId) {

    Random random = new Random();
    if (random.nextBoolean()) {
      list.add("Linux");
    }
    if (random.nextBoolean()) {
      list.add("Android");
    }
    if (random.nextBoolean()) {
      list.add("iPhone");
    }
    if (random.nextBoolean()) {
      list.add("Windows7");
    }
    if (list.size() >= 20) {
      list.remove(0);
    }
    return Service.START_NOT_STICKY;
  }

  @Override
  public IBinder onBind(Intent arg0) {
    return mBinder;
  }

  public class MyBinder extends Binder {
    LocalWordService getService() {
      return LocalWordService.this;
    }
  }

  public List<String> getWordList() {

	  if(list.size() == 0) {
	      list.add("Linux - Static");
	      list.add("Android - Static");
	      list.add("iPhone - Static");
	      list.add("Windows7 - Static");
	      return list;
	  }else{
		  return list;
	  }
  }

} 