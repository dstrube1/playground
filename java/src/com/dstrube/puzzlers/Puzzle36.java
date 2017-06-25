package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle36.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle36

*/

import java.util.Date;

public class Puzzle36{
	//Indecision
	
	public static void main(String[] args){
		System.out.println("decision:" + decision());
	}
	
	public static int decision() {
		try{
			return 1;
		} finally {
			/*this was an interesting thought experiment until java said this is an error 
			because it makes return 4 unreachable
			try{
				return 2;
			} finally {
				return 3;
			}*/
			return 4;
		}
	}
	
}