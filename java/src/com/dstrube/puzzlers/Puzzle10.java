package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle10.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle10

*/

public class Puzzle10{
	//Tweedledee
	
	//string int - both good
	//int string - both bad
	//byte int - first good, second bad - smaller mem req to larger = lossy conversion
	//int byte - both good
	//byte string - both bad
	//string byte - both good
	//char int - first good, second bad 
	//int char - both good
	//byte char  - first good, second bad
	//char byte  - first good, second bad
	//string char - both good
	//char string - both bad
	//Object int - both bad
	//int Object - both bad
	//short int - first good, second bad 
	//short char - first good, second bad
	//double byte - both good
	//byte double  - first good, second bad
	//float byte - both good
	//byte float - first good, second bad
	//Object String - both good
	//String Object - both good
	
	private static Object x;
	private static String i;

	public static void main(String[] args){
		
		reset();

		//Book says this first assignment should fail , but it doesn't. :-/
		x += i;
		System.out.println("x += i => " + x);
		
		reset();
		
		x = x + i;
		System.out.println("x = x + i => " + x);
	}
	
	private static void reset(){
		x = "blah ";
		i = " blah";
	}
	
}