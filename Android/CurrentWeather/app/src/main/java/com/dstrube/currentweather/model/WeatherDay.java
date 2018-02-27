package com.dstrube.currentweather.model;

public class WeatherDay {

    //Properties
    public int dt; //Time of data forecasted, unix, UTC
    public WeatherTemp temp; //Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    public double pressure; //Atmospheric pressure on the sea level by default, hPa
    public int humidity; //Humidity, %
    public WeatherObject[] weathers;
    public double speed;//Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
    public int deg;//Wind direction, degrees (meteorological)
    public int clouds;//Cloudiness, %
    public double rain;//Rain volume for last 3 hours, mm

    //Constants
    public static final String TAG_DT = "dt";
    public static final String TAG_TEMP = "temp";
    public static final String TAG_PRESSURE = "pressure";
    public static final String TAG_HUMIDITY = "humidity";
    public static final String TAG_WEATHER = "weather";
    public static final String TAG_SPEED = "speed";
    public static final String TAG_DEG = "deg";
    public static final String TAG_CLOUDS = "clouds";
    public static final String TAG_RAIN = "rain";

    public WeatherDay(){}
}
