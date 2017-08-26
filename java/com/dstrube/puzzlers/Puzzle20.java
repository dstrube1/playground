package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle20.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle20

*/

import java.util.regex.Pattern;

public class Puzzle20{
	//What's my class
	
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		//com.dstrube.puzzlers.Puzzle20
		System.out.println(
			Puzzle20.class.getName());
	
		System.out.println(
			Puzzle20.class.getName().replaceAll(".","/") + ".class");
	}
	
	public static void fixed() {
		//replaceAll takes a regular expression as its first parameter

		//dot must be escaped with a backslash
		//the backslash must be escaped with a backslash
		System.out.println(
			Puzzle20.class.getName().replaceAll("\\.","/") + ".class");
			
		//Alternatively, Pattern.quote takes a string and escapes whatever needs to be escaped
		System.out.println(
			Puzzle20.class.getName().replaceAll(Pattern.quote("."),"/") + ".class");
		
		//Also, a problem with this solution is that it is file system dependent; see Puzzle21
	}
	
}