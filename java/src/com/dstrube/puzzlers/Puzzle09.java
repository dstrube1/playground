package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d ~/Projects/java/bin com/dstrube/puzzlers/Puzzle09.java
java -cp ~/Projects/java/bin com.dstrube.puzzlers.Puzzle09

*/

public class Puzzle09{
	//Tweedledum
	
	//string int - both good
	//int string - both bad
	//byte int - first good, second bad - smaller mem req to larger = lossy conversion
	//int byte - both good
	//byte string - both bad
	//string byte - both good
	//char int - first good, second bad 
	//int char
	//byte char  - first good, second bad
	//char byte
	//string char
	//char string
	//Object int
	//int Object
	//short int - first good, second bad 
	//short char - first good, second bad
	//double
	//float
	
	private static short x;
	private static char i;

	public static void main(String[] args){
		
		reset();

		x += i;
		System.out.println("x += i => " + x);
		
		reset();
		
		x = x + i;
		System.out.println("x = x + i => " + x);
	}
	
	/*
	Compound assignment expressions automatically cast the result of the computation they perform
	to the type of the variable on the left.
	
	Avoid compound assignment on type byte, short, or char on the left. 
	If left side is int, then avoid long, float, and double on the right.
	*/
	
	private static void reset(){
		x = 0;
		i = 0;
	}
	
}