package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle16.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle16

*/

public class Puzzle16{
	//Line Printer
	
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
	//Try with the following two commented lines on one line:
		//Note: \u000A 
		//is Unicode representation of linefeed (LF)
		char c = 0x000A;
		System.out.println("Before char c");
		System.out.print(c);
		System.out.println("After char c");
	}
	public static void fixed() {
		//Avoid Unicode escapes (especially in comments) except where they are truly necessary
		char c0 = 0x000A;
		char c1 = '\n';
		System.out.println("c0 == c1: " + (c0 == c1));
	}
	
}