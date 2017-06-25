package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle35.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle35

*/

import java.util.Date;

public class Puzzle35{
	//Minute by Minute
	
	public static void main(String[] args){
		System.out.println("broken:");
		broken();
		System.out.println("fixed:");
		fixed();
	}
	
	public static void broken() {
		int minutes = 0;
		for (int ms = 0; ms <60*60*1000; ms++){
			if (ms % 60 * 1000 == 0){
				minutes++;
				System.out.println("minutes: " + minutes);
			}
		}
	}
	
	public static void fixed() {
	//Solution 1: put parentheses around whatever is being modulused
		int minutes = 0;
		for (int ms = 0; ms <60*60*1000; ms++){
			if (ms % (60 * 1000) == 0) {
				minutes++;
				System.out.println("S1: minutes: " + minutes);
			}
		}
	//Solution 2: use constants
		final int MS_PER_HOUR = 60 * 60 * 1000;
		final int MS_PER_MINUTE = 60 * 1000;
		
		minutes = 0;
		for (int ms = 0; ms < MS_PER_HOUR; ms++){
			if (ms % MS_PER_MINUTE == 0) {
				minutes++;
				System.out.println("S2: minutes: " + minutes);
			}
		}
	}
	
}