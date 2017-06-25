package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle26.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle26

*/

public class Puzzle26{
	//In the loop
	
	public static void main(String[] args){
		//broken();
		fixed();
	}
	
	public static final int END = Integer.MAX_VALUE;
	public static final int START = END - 100;
	
	public static void broken() {
		int count = 0;
		for (int i = START; i <= END; i++){
			count++;
		}
		System.out.println("count = " + count);
	}
	
	public static void fixed() {
		//for loop condition is if i <= END; when i gets to END, it wraps around back to MIN_VALUE
		//broken = infinite loop
		
		//Solution 1: use long when comparing to INT _MAX
		int count = 0;
		for (long i = START; i <= END; i++){
			count++;
		}
		System.out.println("count = " + count);
		
		//Solution 2: using only ints, but not as pretty
		int i = START;
		count = 0;
		do {
			count++;
		} while (i++ != END);
		System.out.println("count = " + count);

		//Using int instead of long is only advisable (faster) if applying a function to all (or nearly all)
		//four billion int values
	}
	
}