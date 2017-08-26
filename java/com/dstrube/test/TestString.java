package com.dstrube.test;

/*
commands to compile and run:
from ~/Projects/java
javac -d ~/Projects/java/bin com/dstrube/test/TestString.java 
java -cp ~/Projects/java/bin com.dstrube.test.TestString
*/

public class TestString {
	public static void main(String[] args){
		System.out.println("Testing null: " + reverseString(null));
		System.out.println("Testing empty: " + reverseString(""));		
		System.out.println("Testing 1 character: " + reverseString("1"));		
		String s = "Testing multiple characters: ";
		System.out.println(s + reverseString(s));
  }
  
	private static String reverseString(String s){
	    if (s == null || s.length() == 0) return "";
    
    	if (s.length() == 1) return s;
    
	    String result = "";
    
    	for (int i=s.length()-1; i>=0; i--){
        	result += s.charAt(i);
	    }
    
    	return result;
	}


}

