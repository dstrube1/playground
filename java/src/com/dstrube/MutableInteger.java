/*
From ~/java:

javac -d bin com/dstrube/MutableInteger.java
java -cp bin com.dstrube.MutableInteger

//http://algs4.cs.princeton.edu/12oop/MutableInteger.java.html
*/

package com.dstrube;

import java.lang.reflect.Field; 

public class MutableInteger {

    public static void main(String[] args) { 
        final Integer x = 17;
        System.out.println(x); 
        mutate(x);
        System.out.println(x);
    } 

    // change the Integer to 9999999
    public static void mutate(final Integer x) {
        try {
            final Field value = Integer.class.getDeclaredField("value"); 
            value.setAccessible(true); 
            value.setInt(x, 999999999);
        }
        catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
    } 

} 