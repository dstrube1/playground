package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle27.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle27

*/

public class Puzzle27{
	//Shifty i's
	
	public static void main(String[] args){
		//broken(); //infinite loop
		fixed();
	}
	
	public static void broken() {
		int i = 0;
		while (-1 << i != 0) i++;
		System.out.println("i = " + i);
	}
	
	public static void fixed() {
	/*
	-1 is int with all 32 bits set, 0xffffffff
	The left shift operator shifts zeroes in from the right to fill lower-order bits
	(-1 << i) has its rightmost i bits set to 0
	(-1 << 32) == -1, not 0, because shift operators use only the five lower-order bits
		of their right operand as the shift distance (six bits if the operand is a long)
	This applies to <<, >>, and >>>
	Attempting to shift an int value 32 bits just returns the value itself
	
	Solution:
	Instead of repeatedly shifting -1 by a different shift distance, save the result of
	the previous shift operation and shift it one more bit to the left on each iteration.
	
	*/
		int distance = 0;
		for (int value = -1; value != 0; value <<= 1) distance++;
		System.out.println("distance = " + distance);
		
		//This puzzle requires more studying / practice
	}
	
}