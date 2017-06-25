package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle13.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle13

*/

public class Puzzle13{
	//Animal Farm
	
	private final static String pig = "length: 10";
	private final static String dog = "length: " + pig.length();

	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		System.out.println("Animals are equal: " 
			+ pig == dog);
	}
	public static void fixed() {
		//Original print compared dog to everything else
		
		//Fixed, but not really, because it compares identity, not value
		System.out.println("Animals are equal: " 
			+ (pig == dog));
		
		//Fixed for realsies
		System.out.println("Animals are equal: " 
			+ pig.equals(dog));
	}
	
}