package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle25.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle25

*/

public class Puzzle25{
	//Inclement increment
	
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		int j = 0;
		for (int i = 0; i < 100; i++){
			j = j++;
		}
		System.out.println("j = " + j);
	}
	
	public static void fixed() {
		int j = 0;
		//this:
		j = j++;
		//is the same as this:
		int tmp = j;
		j = j + 1;
		j = tmp;
		
		for (int i = 0; i < 100; i++){
			j++;
		}
		System.out.println("j = " + j);
	}
	
}