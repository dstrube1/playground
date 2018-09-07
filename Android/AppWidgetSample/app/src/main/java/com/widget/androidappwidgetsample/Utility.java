package com.widget.androidappwidgetsample;


import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class Utility {
         public static String getCurrentTime(String timeFormat){
                    Format formatter = new SimpleDateFormat(timeFormat, Locale.US);
                return formatter.format(new Date());
            }
}