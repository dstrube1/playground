package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle14.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle14

*/

public class Puzzle14{
	//Escape Rout
	
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		// \u0022 is the Unicode escape for double quote (")
		System.out.println("a\u0022.length() + \u0022b".length());
	}
	public static void fixed() {
		//Java provides no special treatment for Unicode escapes within string literals
		//Prefer escape sequences to Unicode escapes in string and character literals
		//Do not use Unicode escapes to represent ASCII characters
		
		//		System.out.println("a\u0022.length() + \u0022b".length());
		// = 
		//		System.out.println("a".length() + "b".length()); // = 2
		
		System.out.println("a\\u0022.length() + \\u0022b".length()); // = 26
		System.out.println("a\".length() + \"b".length()); // = 16
	}
	
}