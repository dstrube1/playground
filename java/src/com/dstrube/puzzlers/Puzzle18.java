package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle18.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle18

*/

import java.io.UnsupportedEncodingException;

public class Puzzle18{
	//String Cheese
	
	public static void main(String[] args) throws UnsupportedEncodingException{
		broken();
		fixed();
	}
	
	public static void broken() {
		byte[] bytes = new byte[256];
		
		for (int i = 0; i < 256; i++)
			bytes[i] = (byte)i;
			
		String str = new String(bytes);

		for (int i = 0, n = str.length(); i < n; i++)
			System.out.println((int)str.charAt(i) + " "); 
	}
	public static void fixed() throws UnsupportedEncodingException{
		//broken prints out 0-127, then a lot of 65533
		
		//Charset: the combination of a coded character set and character-encoding scheme; 
		//IOW, a bunch of characters, the numerical codes that represent them, and a way to translate back and forth 
		//between a sequence of character codes and a sequence of bytes
		
		//byte sequence -> String always uses a charset.
		//When translating between char sequences and byte sequences, you can specify a charset explicitly
		byte[] bytes = new byte[256];
		
		for (int i = 0; i < 256; i++)
			bytes[i] = (byte)i;
		//try{
			String str = new String(bytes, "ISO-8859-1");
			for (int i = 0, n = str.length(); i < n; i++)
				System.out.println((int)str.charAt(i) + " "); //0 - 255
		//} catch (UnsupportedEncodingException uee) {
		//	System.out.println("UnsupportedEncodingException while converting bytes to String");
		//}

		//only default charset that will print integers from 0 to 255: ISO-8859-1, aka Latin-1
		System.out.println("My default charset is " + java.nio.charset.Charset.defaultCharset());
		
	}
	
}