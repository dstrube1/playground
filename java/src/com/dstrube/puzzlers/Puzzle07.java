package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d ~/Projects/java/bin com/dstrube/puzzlers/Puzzle07.java
java -cp ~/Projects/java/bin com.dstrube.puzzlers.Puzzle07
*/

public class Puzzle07{
	//Swap Meat
	
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		int x = 1984;
		int y = 2001;
		System.out.println("before swap: \nx = " + x + "; y = " + y);

		//Compound assignment for exclusive OR
		x ^= y ^= x ^= y;
		System.out.println("after broken swamp: \nx = " + x + "; y = " + y);
	}
	public static void fixed() {
		int x = 1984;
		int y = 2001;

		System.out.println("before swap: \nx = " + x + "; y = " + y);

		/*
		Swap variables without a temporary - don't do this
		Unclear and slower than using a temporary variable
		Not guaranteed to work in C or C++; guaranteed to not work in Java
		
		Operands of operators are evaluated from left to right
		
		x ^= expr : x is sampled before expr is evaluated
		in "x ^= y ^= x ^= y;", x is sampled twice, but both samplings occur before any assignments
		Actual behavior:
		int tmp1 = x;
		int tmp2 = y;
		int tmp3 = x ^ y;
		x = tmp3;
		y = tmp2 ^ tmp3;
		x = tmp1 ^ y;
		*/
		x = x ^ y;
		y = y ^ x;
		x = y ^ x;
				
		System.out.println("after fixed (but inadvisable) swap 1: \nx = " + x + "; y = " + y);

		//reset
		x = 1984;
		y = 2001;
		//Still, don't do this
		y = (x ^= (y ^= x)) ^ y;
		System.out.println("after fixed (but inadvisable) swap 2: \nx = " + x + "; y = " + y);

	}
	
}