package com.dstrube.hellovolley;

import com.dstrube.hellovolley.util.MyLogger;

import org.junit.Test;

public class MyLoggerUnitTest {
    @Test
    public void log_with_nulls() {
        MyLogger.Log(null, null);
    }
    @Test
    public void log_with_null_level() {
        MyLogger.Log(null, "");
    }
    @Test
    public void log_with_null_message() {
        MyLogger.Log(MyLogger.Level.INFO, null);
    }
    @Test
    public void log_with_non_nulls() {
        MyLogger.Log(MyLogger.Level.INFO, "");
    }
}
