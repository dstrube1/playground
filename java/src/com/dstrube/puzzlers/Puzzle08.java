package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d ~/Projects/java/bin com/dstrube/puzzlers/Puzzle08.java
java -cp ~/Projects/java/bin com.dstrube.puzzlers.Puzzle08

*/

public class Puzzle08{
	//Dos Equis
	
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		char x = 'X';
		int i = 0;
		System.out.print(true ? x : 0);
		System.out.print(false ? i : x);
		System.out.println();
	}
	public static void fixed() {
		/*
		Mixed-type computation is confusing.
		
		If both operands are the same type, use that type.
		
		Else If one of the operands is of type T (short, byte or char) 
		and the other is const int and representable as a type T, 
		then the type of the conditional expression is T.
		Example: 
		System.out.print(true ? x : 0);
		Return type is char
		
		Else, binary numeric promotion
		Example:
		System.out.print(false ? i : x);
		Return type is int
		
		Solution: make i final
		*/
		char x = 'X';
		final int i = 0;
		System.out.print(true ? x : 0);
		System.out.print(false ? i : x);
		System.out.println();
	}
	
}