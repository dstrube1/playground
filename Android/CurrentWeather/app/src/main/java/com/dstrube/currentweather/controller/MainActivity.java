package com.dstrube.currentweather.controller;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;

import com.dstrube.currentweather.R;
import com.dstrube.currentweather.model.WeatherDay;
import com.dstrube.currentweather.model.WeatherObject;
import com.dstrube.currentweather.model.WeatherTemp;
import com.dstrube.currentweather.service.JSONParser;
import com.dstrube.currentweather.view.CustomAdapter5Day;
import com.dstrube.currentweather.view.CustomAdapterToday;
import com.dstrube.currentweather.view.DayDetailActivity;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.DateFormatSymbols;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    //region Constants

    private static final String TAG = MainActivity.class.getName();
    private static final String URL_TODAY = "http://api.openweathermap.org/data/2.5/weather?"
            + "q=Atlanta,ga&units=imperial&appid=5a74263019c57d625641028e4ecdbf4f";
    private static final String URL_5_DAYS = "http://api.openweathermap.org/data/2.5/forecast/daily?"
            + "q=Atlanta,ga&units=imperial&cnt=5&appid=5a74263019c57d625641028e4ecdbf4f";
    private static final String DEGREE = "\u00B0";

    private static final String TAG_LIST = "list";
    public static final String TAG_DAY = "day";
    public static final String TAG_DATE = "date";
    public static final String TAG_IMAGE = "image";

    private static final Calendar calendar = Calendar.getInstance();
    private static final DateFormatSymbols dateFormatSymbols = new DateFormatSymbols();
    private static final JSONParser parser = new JSONParser();

    //endregion

    //region Variables

    private JSONObject weatherToday;
    private JSONObject weather5Days;

    private ArrayList<HashMap<String, String>> data5Days;
    private ArrayList<HashMap<String, String>> dataToday;
    private static Map<String, Integer> images;

    //endregion

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        setImages();
    }

    @Override
    protected void onResume() {
        super.onResume();

        new NetworkJSONCall().execute(URL_TODAY, URL_5_DAYS);
    }


    private class NetworkJSONCall extends AsyncTask<String, Void, Void> {

        @Override
        protected Void doInBackground(String... urls) {
            weatherToday = parser.getJSONFromUrl(urls[0], MainActivity.this);
            weather5Days = parser.getJSONFromUrl(urls[1], MainActivity.this);

            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            populateListFromJSON();
        }

        private void populateListFromJSON() {
            try {

                if (weatherToday == null || weatherToday.length() == 0) {
                    Log.e(TAG, "Null or empty weather today JSON Object");
                    return;
                }

                if (weather5Days == null || weather5Days.length() == 0) {
                    Log.e(TAG, "Null or empty weather 5 days JSON Object");
                    return;
                }

                //region Get Today data from JSON
                dataToday = new ArrayList<>();
                HashMap<String, String> map = new HashMap<>();

                final String date = dateFormatSymbols.getMonths()[calendar.get(Calendar.MONTH)]
                        + " " + calendar.get(Calendar.DAY_OF_MONTH);
                final JSONObject todayTempObject = weatherToday.getJSONObject(WeatherObject.TAG_MAIN);
                final JSONArray todayWeatherArray = weatherToday.getJSONArray(WeatherDay.TAG_WEATHER);
                final JSONObject todayMainObject = weatherToday.getJSONObject(WeatherObject.TAG_MAIN);
                final JSONObject todayWindObject = weatherToday.getJSONObject(WeatherTemp.TAG_DAY_WIND);
                map.put(TAG_DATE, date);

                map.put(WeatherTemp.TAG_DAY_MAX, "" + Double.valueOf(
                        todayTempObject.getDouble(WeatherTemp.TAG_DAY_MAX)).intValue() + DEGREE);
                map.put(WeatherTemp.TAG_DAY_MIN, "" + Double.valueOf(
                        todayTempObject.getDouble(WeatherTemp.TAG_DAY_MIN)).intValue() + DEGREE);
                map.put(WeatherObject.TAG_DESCRIPTION, todayWeatherArray.getJSONObject(0)
                        .getString(WeatherObject.TAG_MAIN));
                map.put(TAG_IMAGE, todayWeatherArray.getJSONObject(0).getString(WeatherObject.TAG_ICON));
                map.put(WeatherDay.TAG_HUMIDITY, todayMainObject.getString(WeatherDay.TAG_HUMIDITY));
                map.put(WeatherDay.TAG_SPEED, todayWindObject.getString(WeatherDay.TAG_SPEED));
                map.put(WeatherDay.TAG_DEG, todayWindObject.getString(WeatherDay.TAG_DEG));
                map.put(WeatherDay.TAG_PRESSURE, todayMainObject.getString(WeatherDay.TAG_PRESSURE));

                dataToday.add(map);
                //endregion

                setTodayAdapterAndListener();

                final JSONArray weatherArray = weather5Days.getJSONArray(TAG_LIST);
                if (weatherArray.length() == 0) {
                    Log.e(TAG, "Empty weather JSON Array");
                    return;
                }

                //Get 5 day data from JSON
                data5Days = new ArrayList<>();

                //region looping through All Days
                for (int i = 0; i < weatherArray.length(); i++) {
                    final JSONObject day = weatherArray.getJSONObject(i);
                    final WeatherDay weatherDay = new WeatherDay();

                    weatherDay.dt = day.getInt(WeatherDay.TAG_DT);

                    final JSONObject tempObject = day.getJSONObject(WeatherDay.TAG_TEMP);
                    weatherDay.temp = new WeatherTemp();
                    weatherDay.temp.day = tempObject.getDouble(WeatherTemp.TAG_DAY);
                    weatherDay.temp.min = tempObject.getDouble(WeatherTemp.TAG_MIN);
                    weatherDay.temp.max = tempObject.getDouble(WeatherTemp.TAG_MAX);
                    weatherDay.temp.night = tempObject.getDouble(WeatherTemp.TAG_NIGHT);
                    weatherDay.temp.eve = tempObject.getDouble(WeatherTemp.TAG_EVE);
                    weatherDay.temp.morn = tempObject.getDouble(WeatherTemp.TAG_MORN);

                    weatherDay.pressure = day.getDouble(WeatherDay.TAG_PRESSURE);
                    weatherDay.humidity = day.getInt(WeatherDay.TAG_HUMIDITY);

                    final JSONArray weatherObjects = day.getJSONArray(WeatherDay.TAG_WEATHER);
                    weatherDay.weathers = new WeatherObject[weatherObjects.length()];
                    for (int j = 0; j < weatherObjects.length(); j++) {
                        JSONObject weatherObject = weatherObjects.getJSONObject(j);
                        weatherDay.weathers[j] = new WeatherObject();
                        weatherDay.weathers[j].id = weatherObject.getInt(WeatherObject.TAG_ID);
                        weatherDay.weathers[j].main = weatherObject.getString(WeatherObject.TAG_MAIN);
                        weatherDay.weathers[j].description = weatherObject.getString(WeatherObject.TAG_DESCRIPTION);
                        weatherDay.weathers[j].icon = weatherObject.getString(WeatherObject.TAG_ICON);
                    }
                    weatherDay.speed = day.getDouble(WeatherDay.TAG_SPEED);
                    weatherDay.deg = day.getInt(WeatherDay.TAG_DEG);
                    weatherDay.clouds = day.getInt(WeatherDay.TAG_CLOUDS);
                    if (day.has(WeatherDay.TAG_RAIN))
                        weatherDay.rain = day.getDouble(WeatherDay.TAG_RAIN);

                    // creating a new single-row HashMap that will represent a row
                    // in the ListView
                    map = new HashMap<>();

                    // add each child node to HashMap key => value
                    map.put(TAG_IMAGE, weatherDay.weathers[0].icon);
                    if (i == 0)
                        map.put(TAG_DAY, "Tomorrow");
                    else
                        map.put(TAG_DAY, dateFormatSymbols.getWeekdays()[calendar.get(Calendar.DAY_OF_WEEK) + i + 1]);
                    map.put(WeatherDay.TAG_WEATHER, weatherDay.weathers[0].main);
                    map.put(WeatherTemp.TAG_MAX, "" + Double.valueOf(weatherDay.temp.max).intValue() + DEGREE);
                    map.put(WeatherTemp.TAG_MIN, "" + Double.valueOf(weatherDay.temp.min).intValue() + DEGREE);
                    map.put(TAG_DATE, date);
                    map.put(WeatherDay.TAG_HUMIDITY, "" + weatherDay.humidity);
                    map.put(WeatherDay.TAG_SPEED, "" + weatherDay.speed);
                    map.put(WeatherDay.TAG_DEG, "" + weatherDay.deg);
                    map.put(WeatherDay.TAG_PRESSURE, "" + Double.valueOf(weatherDay.pressure).intValue());

                    // add HashList to ArrayList
                    data5Days.add(map);

                }
                //endregion

                set5DayAdapterAndListener();


            } catch (JSONException e) {
                Log.e(TAG, "JSONException: " + e.getMessage());
            } catch (Exception e0) {
                Log.e(TAG, "Exception: " + e0.getMessage());
            }
        }

        private void setTodayAdapterAndListener() {
            final CustomAdapterToday adapterToday = new CustomAdapterToday(getApplicationContext(), dataToday, R.layout.big_day,
                    new String[]{TAG_DATE, WeatherTemp.TAG_DAY_MAX, WeatherTemp.TAG_DAY_MIN,
                            WeatherObject.TAG_DESCRIPTION, TAG_IMAGE, WeatherDay.TAG_HUMIDITY,
                            WeatherDay.TAG_SPEED, WeatherDay.TAG_DEG, WeatherDay.TAG_PRESSURE
                    },
                    new int[]{R.id.big_day_date, R.id.big_day_temp_high, R.id.big_day_temp_low,
                            R.id.big_day_description, R.id.big_day_image, R.id.big_day_humidity,
                            R.id.big_day_wind, R.id.big_day_degree, R.id.big_day_pressure
                    });




            final ListView listView = findViewById(R.id.listViewToday);

            try {
                listView.setAdapter(adapterToday);

                listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                    @Override
                    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                        String image = ((TextView) view.findViewById(R.id.big_day_icon))
                                .getText().toString();
                        String day = "Today";
                        String date = ((TextView) view.findViewById(R.id.big_day_date))
                                .getText().toString();
                        String high = ((TextView) view.findViewById(R.id.big_day_temp_high))
                                .getText().toString();
                        String low = ((TextView) view.findViewById(R.id.big_day_temp_low))
                                .getText().toString();
                        String description = ((TextView) view.findViewById(R.id.big_day_description))
                                .getText().toString();
                        String humidity = ((TextView) view.findViewById(R.id.big_day_humidity))
                                .getText().toString();
                        String wind = ((TextView) view.findViewById(R.id.big_day_wind))
                                .getText().toString();
                        String degree = ((TextView) view.findViewById(R.id.big_day_degree))
                                .getText().toString();
                        String pressure = ((TextView) view.findViewById(R.id.big_day_pressure))
                                .getText().toString();

                        Intent intent = new Intent(getApplicationContext(), DayDetailActivity.class);
                        intent.putExtra(TAG_IMAGE, image);
                        intent.putExtra(TAG_DAY, day);
                        intent.putExtra(TAG_DATE, date);
                        intent.putExtra(WeatherTemp.TAG_MAX, high);
                        intent.putExtra(WeatherTemp.TAG_MIN, low);
                        intent.putExtra(WeatherDay.TAG_WEATHER, description);
                        intent.putExtra(WeatherDay.TAG_HUMIDITY, humidity);
                        intent.putExtra(WeatherDay.TAG_SPEED, wind);
                        intent.putExtra(WeatherDay.TAG_DEG, degree);
                        intent.putExtra(WeatherDay.TAG_PRESSURE, pressure);

                        startActivity(intent);
                    }
                });
            } catch (NullPointerException e){
                Log.e(TAG, "NullPointerException");
            }
        }

        private void set5DayAdapterAndListener() {
            CustomAdapter5Day adapter5Day = new CustomAdapter5Day(getApplicationContext(), data5Days, R.layout.little_day,
                    new String[]{TAG_IMAGE, TAG_DAY, WeatherDay.TAG_WEATHER,
                            WeatherTemp.TAG_MAX, WeatherTemp.TAG_MIN, TAG_DATE, WeatherDay.TAG_HUMIDITY,
                            WeatherDay.TAG_DEG, WeatherDay.TAG_SPEED, WeatherDay.TAG_PRESSURE
                    },
                    new int[]{R.id.little_day_image, R.id.little_day_day, R.id.little_day_description,
                            R.id.little_day_high, R.id.little_day_low, R.id.little_day_date, R.id.little_day_humidity,
                            R.id.little_day_degree, R.id.little_day_wind, R.id.little_day_pressure
                    }
            );

            ListView listView = findViewById(R.id.listView5Day);
            listView.setAdapter(adapter5Day);
            listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                @Override
                public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                    String image = ((TextView) view.findViewById(R.id.little_day_icon))
                            .getText().toString();
                    String day = ((TextView) view.findViewById(R.id.little_day_day))
                            .getText().toString();
                    String date = ((TextView) view.findViewById(R.id.little_day_date))
                            .getText().toString();
                    String high = ((TextView) view.findViewById(R.id.little_day_high))
                            .getText().toString();
                    String low = ((TextView) view.findViewById(R.id.little_day_low))
                            .getText().toString();
                    String description = ((TextView) view.findViewById(R.id.little_day_description))
                            .getText().toString();
                    String humidity = ((TextView) view.findViewById(R.id.little_day_humidity))
                            .getText().toString();
                    String wind = ((TextView) view.findViewById(R.id.little_day_wind))
                            .getText().toString();
                    String degree = ((TextView) view.findViewById(R.id.little_day_degree))
                            .getText().toString();
                    String pressure = ((TextView) view.findViewById(R.id.little_day_pressure))
                            .getText().toString();

                    Intent intent = new Intent(getApplicationContext(), DayDetailActivity.class);
                    intent.putExtra(TAG_IMAGE, image);
                    intent.putExtra(TAG_DAY, day);
                    intent.putExtra(TAG_DATE, date);
                    intent.putExtra(WeatherTemp.TAG_MAX, high);
                    intent.putExtra(WeatherTemp.TAG_MIN, low);
                    intent.putExtra(WeatherDay.TAG_WEATHER, description);
                    intent.putExtra(WeatherDay.TAG_HUMIDITY, humidity);
                    intent.putExtra(WeatherDay.TAG_SPEED, wind);
                    intent.putExtra(WeatherDay.TAG_DEG, degree);
                    intent.putExtra(WeatherDay.TAG_PRESSURE, pressure);
//                intent.putExtra(WeatherObject.TAG_ICON, wind);

                    startActivity(intent);
                }
            });
        }

    }

    private static void setImages() {
        images = new HashMap<>();
        images.put("01d", R.drawable.art_clear);
        images.put("01n", R.drawable.ic_clear);
        images.put("02d", R.drawable.art_light_clouds);
        images.put("02n", R.drawable.ic_light_clouds);
        images.put("03d", R.drawable.art_clouds);
        images.put("03n", R.drawable.ic_cloudy);
        images.put("04d", R.drawable.art_clouds);
        images.put("04n", R.drawable.ic_cloudy);
        images.put("09d", R.drawable.art_light_rain);
        images.put("09n", R.drawable.ic_light_rain);
        images.put("10d", R.drawable.art_rain);
        images.put("10n", R.drawable.ic_rain);
        images.put("11d", R.drawable.art_storm);
        images.put("11n", R.drawable.ic_storm);
        images.put("13d", R.drawable.art_snow);
        images.put("13n", R.drawable.ic_snow);
        images.put("50d", R.drawable.art_fog);
        images.put("50n", R.drawable.ic_fog);
    }

    public static int getImage(final String key) {
        return images.get(key);
    }
}
