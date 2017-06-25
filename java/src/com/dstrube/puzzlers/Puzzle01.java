package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d ~/Projects/java/bin com/dstrube/puzzlers/Puzzle01.java
java -cp ~/Projects/java/bin com.dstrube.puzzlers.Puzzle01
*/

public class Puzzle01{
	//Oddity
	
	public static void main(String[] args){
		System.out.println("Puzzle 1");
		for (int i = -4; i < 4; i++){
			System.out.println("isOdd("+i+"): " + isOdd(i));
		}
		
		System.out.println("\nAnd fixed:");
		for (int i = -4; i < 4; i++){
			System.out.println("isOddFixed("+i+"): " + isOddFixed(i));
		}
		
		System.out.println("\nAnd fixed for performance:");
		for (int i = -4; i < 4; i++){
			System.out.println("isOddFixedForPerformance("+i+"): " + isOddFixedForPerformance(i));
		}
		
	}
	
	public static boolean isOdd(int i) {
		return i % 2 == 1;
	}
	
	/*
	Why? Because the % operator works like this:
	for all ints a, and all non-zero ints b,
	(a / b) * b + (a % b) == a
	
	Long story short, for negative numbers, negative remainder is -1, not 1
	*/
	
	public static boolean isOddFixed(int i) {
		return i % 2 != 0;
	}
	
	//Bitwise operator
	public static boolean isOddFixedForPerformance(int i) {
		return (i & 1) != 0;
	}

}