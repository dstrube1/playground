package com.dstrube.currentweather.view;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

import com.dstrube.currentweather.R;
import com.dstrube.currentweather.controller.MainActivity;
import com.dstrube.currentweather.model.WeatherDay;
import com.dstrube.currentweather.model.WeatherTemp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomAdapter5Day extends SimpleAdapter {
    private Context context;
    private LayoutInflater inflater;
    private ArrayList<HashMap<String, String>> data;

    public CustomAdapter5Day(Context context, List<? extends Map<String, ?>> data, int resource,
                             String[] from, int[] to) {
        super(context, data, resource, from, to);

        this.context = context;
        inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.data = (ArrayList<HashMap<String, String>>)data;
    }

    @Override
    public int getCount() {
        return data.size();
    }

    @Override
    public Object getItem(int position) {
        return super.getItem(position);
    }

    @Override
    public long getItemId(int position) {
        return super.getItemId(position);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View view;

        if (convertView == null)
            view = inflater.inflate(R.layout.little_day, parent, false);
        else
            view = convertView;

        final Map<String, String> map = (HashMap<String, String>) getItem(position);

        final ImageView imageView = view.findViewById(R.id.little_day_image);
        final TextView day = view.findViewById(R.id.little_day_day);
        final TextView description = view.findViewById(R.id.little_day_description);
        final TextView high = view.findViewById(R.id.little_day_high);
        final TextView low = view.findViewById(R.id.little_day_low);
        final TextView date = view.findViewById(R.id.little_day_date);
        final TextView humidity = view.findViewById(R.id.little_day_humidity);
        final TextView pressure = view.findViewById(R.id.little_day_pressure);
        final TextView wind = view.findViewById(R.id.little_day_wind);
        final TextView degree = view.findViewById(R.id.little_day_degree);
        final TextView icon = view.findViewById(R.id.little_day_icon);

        final Drawable drawable = context.getDrawable(MainActivity.getImage(map.get(MainActivity.TAG_IMAGE)));
        imageView.setImageDrawable(drawable);

        day.setText(map.get(MainActivity.TAG_DAY));
        description.setText(map.get(WeatherDay.TAG_WEATHER));
        high.setText(map.get(WeatherTemp.TAG_MAX));
        low.setText(map.get(WeatherTemp.TAG_MIN));
        date.setText(map.get(MainActivity.TAG_DATE));
        humidity.setText(map.get(WeatherDay.TAG_HUMIDITY));
        pressure.setText(map.get(WeatherDay.TAG_PRESSURE));
        wind.setText(map.get(WeatherDay.TAG_SPEED));
        degree.setText(map.get(WeatherDay.TAG_DEG));
        icon.setText(map.get(MainActivity.TAG_IMAGE));

        return view;
    }
}
