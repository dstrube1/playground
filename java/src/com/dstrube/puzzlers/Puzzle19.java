package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle19.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle19

*/

public class Puzzle19{
	//Classy Fire
	
	public static void main(String[] args){
		System.out.println("classify('n') + classify('+') + classify('2'): "
			+ classify('n') + classify('+') + classify('2'));
	}
	static String classify(char ch){
		if ("0123456789".indexOf(ch) >= 0)
			return "NUMERAL ";
		if ("abcdefghijklmnopqrstuvwxyz".indexOf(ch) >= 0)
			return "LETTER ";
	//Swap the / and * in the list of characters below, and the program becomes uncompilable
	/* (Operators not supported yet
		if ("+-/*&|!=".indexOf(ch) >= 0)
			return "OPERATOR";
	*/
	
	//Sometimes better to use a block of line comments than block comments
	
		return "UNKNOWN ";
	}
	
}