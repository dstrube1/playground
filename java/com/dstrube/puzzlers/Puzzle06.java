package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d ~/Projects/java/bin com/dstrube/puzzlers/Puzzle06.java
java -cp ~/Projects/java/bin com.dstrube.puzzlers.Puzzle06

*/

public class Puzzle06{
	//Multicast

	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		System.out.println("(int) (char) (byte) -1 = " + (int) (char) (byte) -1 );
	}
	
	public static void fixed() {
		/*
		Java uses two's-complement binary arithmetic, so the int value -1 has all 32 bits set.
		int to byte = narrowing primitive conversion: lops off all but the low-order 8 bits
		byte to char: byte is a signed type, char is unsigned; 
			usually possible to convert from integral type to a wider one while preserving the value, 
			but impossible to represent a negative byte as a char
			byte to char is not widening, but widening and narrowing primitive conversion: byte to int, int to char
		Sign extension is performed if the type of the original value is signed; zero extension if it is char, 
			regardless of the type to which it is being converted
		-1 as byte to char = all 16 bits set = 65,535 as int - zero extension if the original value is char
		*/
		byte b = -1;
		char c = (char) b;
		//no sign extension, bitmask for clarity
		int i1 = c & 0xffff;
		//or clarify with comment
		int i2 = c;  //no sign extension
		//with sign extension
		int i3 = (short) c;
		
		//if you don't want sign extension from byte to char:
		char c1 = (char) (b & 0xff);
		
		System.out.println("(int) (char) (byte) -1 = " + i1 + " or " + i2 + " or " + i3 );
		System.out.println("byte to char without sign extension = " + c1 );
	}
	
}