package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d ~/Projects/java/bin com/dstrube/puzzlers/Puzzle04.java
java -cp ~/Projects/java/bin com.dstrube.puzzlers.Puzzle04

*/

public class Puzzle04{
	//Elementary

	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		System.out.println("12345 + 5432l = " + (12345 + 5432l));
	}
	
	public static void fixed() {
		//Never use "l" as a variable name or in a long literal
		System.out.println("12345 + 5432L = " + (12345 + 5432L));
	}
	
}