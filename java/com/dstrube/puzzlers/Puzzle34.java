package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle34.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle34

*/

import java.util.Date;

public class Puzzle34{
	//Down for the Count
	
	public static void main(String[] args){
		System.out.println("broken:");
		broken();
		System.out.println("fixed:");
		fixed();
	}
	
	public static void broken() {
		final int START = 2000000000;
		int count = 0;
		for (float f = START; f < START + 50; f++){
			System.out.println("count1: " + count);
			count++;
		}
		System.out.println("count2: " + count);
	}
	
	public static void fixed() {
	/*
	Initial value of f is close to Integer.MAX_VALUE, requires 31 bits to represent precisely.
	Float gives only 24 bits, so incrementing it at this point should have no effect
	So this should loop infinitely.
	But, promotion from int to float happens automatically when comparing int and float, 
	eg, f < START + 50
	One of 3 widening primitive conversion that can result in loss of precision. 
	(other two are long to float and long to double)
	(float) 2000000000 == (float) 2000000050
	so f < START + 50 is false on first check
	*/
		final int START = 2000000000;
		int count = 0;
		for (double f = START; f < START + 50; f++){ //another solution uses int
			//System.out.println("count1: " + count);
			count++;
		}
		System.out.println("count2: " + count);
	}
	
}