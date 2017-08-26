/*
From ~/java:

javac -d bin com/dstrube/Hexify.java
java -cp bin com.dstrube.Hexify

http://stackoverflow.com/questions/2817752/java-code-to-convert-byte-to-hexadecimal
http://stackoverflow.com/questions/9655181/how-to-convert-a-byte-array-to-a-hex-string-in-java

*/

package com.dstrube;

import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;

public class Hexify {
	public static void main(String[] args) {
		String input = "01=";//23456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
		try{
			for (int i=0; i< input.length(); i++){
				hexify(""+input.charAt(i),Charset.defaultCharset().name());
			}
		}catch (Exception e){
			System.out.println("exception caught");
		}	
	}
	
	private static String hexify(String input, String charsetName) throws UnsupportedEncodingException{
		if (input == null){
			throw new IllegalArgumentException();
		}
		
		if (input.length() == 0) return input;
		
        if (!Charset.isSupported(charsetName)) throw new UnsupportedEncodingException();
        
        Charset charset = Charset.forName(charsetName);
        
        byte[] bytes = input.getBytes(charset);
        
        //System.out.println("printing...");
        for (byte b : bytes){
            System.out.println(b);
    	}
    	
    	//System.out.println("Done");
    	return "";
        
    }

	    
}