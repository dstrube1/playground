package com.dstrube.currentweather.model;

public class WeatherTemp {
    //Properties
    public double day;//daily averaged temperature
    public double min;
    public double max;
    public double night;
    public double eve;
    public double morn;

    //Constants
    public static final String TAG_DAY = "day";
    public static final String TAG_MIN = "min";
    public static final String TAG_MAX = "max";
    public static final String TAG_NIGHT = "night";
    public static final String TAG_EVE = "eve";
    public static final String TAG_MORN = "morn";
    //these are the tags from the one-day json call
    public static final String TAG_DAY_MIN = "temp_min";
    public static final String TAG_DAY_MAX = "temp_max";
    public static final String TAG_DAY_WIND = "wind";

    public WeatherTemp(){}
}
