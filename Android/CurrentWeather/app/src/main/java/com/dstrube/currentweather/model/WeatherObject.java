package com.dstrube.currentweather.model;

public class WeatherObject {
    //Properties
    public long id; //Weather condition id
    public String main; //Group of weather parameters (Rain, Snow, Extreme etc.)
    public String description; //Weather condition within the group
    public String icon; //Weather icon id

    //Constants
    public static final String TAG_ID = "id";
    public static final String TAG_MAIN = "main";
    public static final String TAG_DESCRIPTION = "description";
    public static final String TAG_ICON = "icon";

    public WeatherObject(){}

}
