package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d ~/Projects/java/bin com/dstrube/puzzlers/Puzzle05.java
java -cp ~/Projects/java/bin com.dstrube.puzzlers.Puzzle05

*/

public class Puzzle05{
	//Joy of Hex

	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		System.out.println("0x100000000L + 0xcafebabe = " + Long.toHexString(0x100000000L + 0xcafebabe));
	}
	
	public static void fixed() {
		//Decimal literals are all positive
		//To write a negative decimal constant, use -
		//You can write any int of long value, positive or negative, in decimal form
		//Negative decimal constants are clearly identifiable by the presence of a minus sign; not so for hex and octal
		//Hex and octal are negative if their high-order bit is set
		//0xcafebabe is an int constant with its high-order bit set, so it is negative:
		//   11111111
		// 0xffffffffcafebabeL
		//+0x0000000100000000L
		//----------------------
		//0x00000000cafebabeL
		
		//Avoid mixed-type computations
		
		System.out.println("0x100000000L + 0xcafebabeL = " + Long.toHexString(0x100000000L + 0xcafebabeL));
	}
	
}