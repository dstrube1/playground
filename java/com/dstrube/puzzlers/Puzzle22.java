package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle22.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle22

*/

public class Puzzle22{
	//Dupe of URL
	
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		System.out.print("iexplore:");
		http://www.google.com;
		System.out.println(":maximize");
		
	}
	
	public static void fixed() {
		//it doesn't do anything in any OS except print out iexplore::maximize
		//Point is the URL is a statement label followed by an end-of-line comment

		//Clearer separation of label and comment:
		System.out.print("iexplore:");
		http:	//www.google.com;
		System.out.println(":maximize");

		//Clearer still:
		System.out.print("iexplore:");
		label:	//comment
		System.out.println(":maximize");
		
		//Make code clear and useful; remove dead code
		//If something seems to weird to be true, it's probably false
	}
	
}