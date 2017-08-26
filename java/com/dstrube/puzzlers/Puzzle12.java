package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle12.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle12

*/

public class Puzzle12{
	//ABC
	
	private static String letters = "ABC";
	private static char[] numbers = {'1','2','3'}; //not the same as {1,2,3}
		
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
//		String letters = "ABC";
//		char[] numbers = {1,2,3};
		System.out.println(letters + ", easy as " + numbers);
	}
	public static void fixed() {
	/*
		System.out.println("tests: ");
		System.out.println('a');
		System.out.println('2');
	*/
//		String letters = "ABC";
//		char[] numbers = {1,2,3};
		System.out.println("fix 1");
		System.out.println(letters + ", easy as " + String.valueOf(numbers));
		System.out.println("fix 2");
		System.out.print(letters + ", easy as " );
		System.out.println(numbers);
		System.out.println("explicitly broken:");
		Object numObj = new char[] {'1','2','3'};
		System.out.println(letters + ", easy as " +numObj);
		
		/*
		char arrays are not strings. 
		To convert a char array to a string, invoke String.valueOf(char[])
		*/
	}
	
}