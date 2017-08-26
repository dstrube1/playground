package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle24.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle24

*/

public class Puzzle24{
	//A big delight in every byte
	
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		for (byte b = Byte.MIN_VALUE; b < Byte.MAX_VALUE; b++){
			if (b == 0x90)
				System.out.println("Joy!");
		}
		System.out.println("Done");
	}
	
	public static void fixed() {
		//0x90 = 144
		//each hex digit takes up 4 bits
		//two hex digits = 8 bits = 1 byte
		//byte is a signed type: -128 to 127
		
		//without the cast (byte), error; this is value based; 0x1, and 0x11 work fine without the cast
		final byte TARGET = (byte)0x90;
		for (byte b = Byte.MIN_VALUE; b < Byte.MAX_VALUE; b++){
			if (b == TARGET)
				System.out.println("Joy!");
		}
		System.out.println("Done");
	}
	
}