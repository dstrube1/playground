package com.dstrube.random;

/*
commands to compile and run:
from ~/java
javac -cp bin:bin/gson-2.8.5.jar -d bin com/dstrube/random/GsonTest.java 
java -cp bin:bin/gson-2.8.5.jar com.dstrube.random.GsonTest
*/

import com.google.gson.Gson;

public class GsonTest {
	public static void main(String[] args){
		//test1();
		test2();
	}

	private static void test1(){
		//https://github.com/google/gson/blob/master/UserGuide.md#TOC-Primitives-Examples
		
		// Serialization
		final Gson gson = new Gson();
		System.out.println(gson.toJson(1));            // ==> 1
		System.out.println(gson.toJson("abcd"));       // ==> "abcd"
		System.out.println(gson.toJson(new Long(10))); // ==> 10
		final int[] values = { 1 };
		System.out.println(gson.toJson(values));       // ==> [1]

		// Deserialization
		final int one_i = gson.fromJson("1", int.class);
		final Integer one_I = gson.fromJson("1", Integer.class);
		final Long one_L = gson.fromJson("1", Long.class);
		final Boolean bool = gson.fromJson("false", Boolean.class);
		final String str = gson.fromJson("\"abc\"", String.class);
		final String[] anotherStr = gson.fromJson("[\"abc\"]", String[].class);
	}
	
	private static void test2(){
		// Serialization
		final BagOfPrimitives obj = new BagOfPrimitives();
		final Gson gson = new Gson();
		final String json = gson.toJson(obj);  
		// ==> json is {"value1":1,"value2":"abc"}
		System.out.println(json);
		
		// Deserialization
		final BagOfPrimitives obj2 = gson.fromJson(json, BagOfPrimitives.class);
		// ==> obj2 is just like obj
	}
	
	static class BagOfPrimitives {
		private int value1 = 1;
		private String value2 = "abc";
		private transient int value3 = 3; //transient = not serialized
		BagOfPrimitives() {
			// no-args constructor
		}
	}
}

