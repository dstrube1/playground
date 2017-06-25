package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle11.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle11

*/

public class Puzzle11{
	//Title
	
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		System.out.print("H" + "a");
		System.out.print('H' + 'a');
		System.out.println("");
	}
	public static void fixed() {
		/*
		Since neither 'H' nor 'a' are String, they both get turned to ints thru
		widening primitive conversion.
		The + operator performs string concatenation if and only if at least one of its operands is of type String
		*/
		System.out.println("fix 1: ");
		System.out.print("H" + "a");
		StringBuffer sb = new StringBuffer();
		sb.append('H');
		sb.append('a');
		System.out.print(sb.toString());
		System.out.println("");
		System.out.println("fix 2: ");
		System.out.print("H" + "a");
		System.out.print("" + 'H' + 'a');
		System.out.println("");
		System.out.println("fix 3: ");
		System.out.print("H" + "a");
		System.out.printf("%c%c", 'H', 'a');
		System.out.println("");
		System.out.println("fix 4: ");
		System.out.print("H" + "a");
		System.out.printf(String.valueOf('H') + 'a');
		System.out.println("");
		System.out.println("test: 2 + 2 = " + 2 + 2);
		System.out.println("");
	}
	
}