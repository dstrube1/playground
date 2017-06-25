package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d ~/Projects/java/bin com/dstrube/puzzlers/Puzzle03.java
java -cp ~/Projects/java/bin com.dstrube.puzzlers.Puzzle03

*/

public class Puzzle03{
	//Long division
	
	public static void main(String[] args){
		final long MICROS_PER_DAY = 24 * 60 * 60 * 1000 * 1000;
		final long MILLIS_PER_DAY = 24 * 60 * 60 * 1000;
		System.out.println("Microseconds per day / milliseconds per day = " + MICROS_PER_DAY / MILLIS_PER_DAY);
		
		//Problem: factors are treated as ints (by default), so the product MICROS_PER_DAY overflows before assignment
		final long MICROS_PER_DAY_fixed = 24L * 60 * 60 * 1000 * 1000;
		final long MILLIS_PER_DAY_fixed = 24L * 60 * 60 * 1000;
		System.out.println("Microseconds per day / milliseconds per day (fixed) = " + MICROS_PER_DAY_fixed / MILLIS_PER_DAY_fixed);
		
		//When working with large numbers, watch out for overflow
		System.out.println("Integer.MAX_VALUE:    " + formatNumber(Integer.MAX_VALUE));
		System.out.println("MICROS_PER_DAY_fixed: " + formatNumber(MICROS_PER_DAY_fixed ));
		System.out.println("MICROS_PER_DAY:       " + formatNumber(MICROS_PER_DAY));
		
	}
	
	private static String formatNumber(int number){
		String numS = "" + number;
		return formatNumberBase(numS);
	}
	private static String formatNumber(long number){
		String numS = "" + number;	
		return formatNumberBase(numS);
	}
	private static String formatNumberBase(String number){
		if (number.length() < 4){
			return number;
		}
		int moved=0;
		for (int i = number.length(); i > 0; i--){
			if (moved != 0 && moved % 3 == 0){
				String numberLeft = number.substring(0, i);
				String numberRight = number.substring(i);
				
				number = numberLeft + "," + numberRight;
			}
			moved++;
		}
		return number;
	}
	
}