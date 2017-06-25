package com.dstrube.puzzlers;

import java.math.BigDecimal;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d ~/Projects/java/bin com/dstrube/puzzlers/Puzzle02.java
java -cp ~/Projects/java/bin com.dstrube.puzzlers.Puzzle02
*/

public class Puzzle02{
	//Time for a Change
	
	public static void main(String[] args){
//		System.out.println("Puzzle 2");
		System.out.println(2.00 - 1.10);
		/*
		Program prints the shortest decimal fraction sufficient to distinguish the double 
		value from its nearest neighbor, with at least one digit before and after the 
		decimal point.
		
		1.1 can't be represented exactly as a double, so is represented by the closest 
		double value. Not all decimals can be represented exactly using binary floating 
		point.
		*/
		
		//Poor solution - still uses binary floating point:
		System.out.printf("%.2f%n", 2.00 - 1.10);
		
		/*
		Binary floating point is particularly ill-suited to monetary calculations. It is 
		impossible to represent 0.1 - or any other negative power of 10 - exactly as a 
		finite-length binary fraction.
		*/
		
		//better solution: use integral type, like int or long
		System.out.println(200 - 110 + " cents");
		
		//BigDecimal performs exact decimal arithmetic, usually slower than primitives
		//Always use BigDecimal(String) constructor, never BigDecimal(double)
		System.out.println("Using BigDecimal double constructor: " + new BigDecimal(2.00).subtract(new BigDecimal(1.10)));
		System.out.println("Using BigDecimal String constructor: " + new BigDecimal("2.00").subtract(new BigDecimal("1.10")));
		
	}
	
}