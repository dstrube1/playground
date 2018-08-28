package com.dstrube.currentweather.view;

import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;
import android.widget.TextView;

import com.dstrube.currentweather.R;
import com.dstrube.currentweather.controller.MainActivity;
import com.dstrube.currentweather.model.WeatherDay;
import com.dstrube.currentweather.model.WeatherTemp;

public class DayDetailActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.day_detail);

        Intent intent = getIntent();

        TextView day = findViewById(R.id.day_detail_day);
        TextView date = findViewById(R.id.day_detail_date);
        TextView high = findViewById(R.id.day_detail_high);
        TextView low = findViewById(R.id.day_detail_low);
        TextView description = findViewById(R.id.day_detail_description);
        TextView humidity = findViewById(R.id.day_detail_humidity);
        TextView wind = findViewById(R.id.day_detail_wind);
        TextView pressure = findViewById(R.id.day_detail_pressure);

        day.setText(intent.getStringExtra(MainActivity.TAG_DAY));
        date.setText(intent.getStringExtra(MainActivity.TAG_DATE));
        if (date.getText().toString().startsWith("Today"))
            date.setText(date.getText().toString().substring(5));
        high.setText(intent.getStringExtra(WeatherTemp.TAG_MAX));
        low.setText(intent.getStringExtra(WeatherTemp.TAG_MIN));
        description.setText(intent.getStringExtra(WeatherDay.TAG_WEATHER));

        final Drawable drawable = getDrawable(MainActivity.getImage(
                intent.getStringExtra(MainActivity.TAG_IMAGE)));
        final ImageView imageView = findViewById(R.id.day_detail_image);
        imageView.setImageDrawable(drawable);

        humidity.setText("Humidity: " + intent.getStringExtra(WeatherDay.TAG_HUMIDITY) + "%");

        float degree = Float.parseFloat(intent.getStringExtra(WeatherDay.TAG_DEG));
        //http://climate.umn.edu/snow_fence/components/winddirectionanddegreeswithouttable3.htm
        String direction;
        if (degree >= 348.75 || degree < 11.25)
            direction = "N";
        else if (degree >= 11.25 && degree < 33.75)
            direction = "NNE";
        else if (degree >= 33.75 && degree < 56.25)
            direction = "NE";
        else if (degree >= 56.25 && degree < 78.75)
            direction = "ENE";
        else if (degree >= 78.75 && degree < 101.25)
            direction = "E";
        else if (degree >= 101.25 && degree < 123.75)
            direction = "ESE";
        else if (degree >= 123.75 && degree < 146.25)
            direction = "SE";
        else if (degree >= 146.25 && degree < 168.75)
            direction = "SSE";
        else if (degree >= 168.75 && degree < 191.25)
            direction = "S";
        else if (degree >= 191.25 && degree < 213.75)
            direction = "SSW";
        else if (degree >= 213.75 && degree < 236.25)
            direction = "SW";
        else if (degree >= 236.25 && degree < 258.75)
            direction = "WSW";
        else if (degree >= 258.75 && degree < 281.25)
            direction = "W";
        else if (degree >= 281.25 && degree < 303.75)
            direction = "WNW";
        else if (degree >= 303.75 && degree < 326.25)
            direction = "NW";
        else if (degree >= 326.25 && degree < 348.75)
            direction = "NNW";
        else
            direction = "invalid direction";

        wind.setText("Wind: " + intent.getStringExtra(WeatherDay.TAG_SPEED) + " km/H " + direction);
        pressure.setText("Pressure: " + intent.getStringExtra(WeatherDay.TAG_PRESSURE) + " hPa");

    }
}
