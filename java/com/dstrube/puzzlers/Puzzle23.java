package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle23.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle23

*/

import java.util.Random;

public class Puzzle23{
	//No pain, no gain
	
	private static Random rnd = new Random();
	
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		StringBuffer word = null;
		switch (rnd.nextInt(2)) { 
			case 1: word = new StringBuffer('P');
			case 2: word = new StringBuffer('G');
			default: word = new StringBuffer('M');
		}
		word.append('a');
		word.append('i');
		word.append('n');
		System.out.println(word);	
	}
	
	public static void fixed() {
		StringBuffer word = null;
		//bug #1: nextInt(x) returns an int from 0 (inclusive) to x (exclusive)
		switch (rnd.nextInt(3)) { 
			case 1: 
				word = new StringBuffer("P");
				//bug #2: missing breaks
				break;
			case 2: 
				//bug #3: there is no constructor StringBuffer(char);
				//StringBuffer(int) indicates the size of the buffer
				//char -> int = widening primitive conversion
				word = new StringBuffer("G");
				break;
			default: 
				word = new StringBuffer("M");
				break;
		}
		word.append('a');
		word.append('i');
		word.append('n');
		System.out.println(word);	
		
		//More elegant solution:
		System.out.println("PGM".charAt(rnd.nextInt(3)) + "ain");
		
		//a more generic solution:
		String a[] = {"Main","Pain","Gain"};
		System.out.println(randomElement(a));
	}
	
	private static Random random = new Random();
	private static String randomElement(String[] a){
		return a[random.nextInt(a.length)];
	}
	
}