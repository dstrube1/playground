package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle21.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle21

*/

import java.io.File;
import java.util.regex.Matcher;

public class Puzzle21{
	//What's my class, take 2
	
	public static void main(String[] args){
		broken();
		fixed();
	}
	
	public static void broken() {
		System.out.println(
			Puzzle21.class.getName().replaceAll("\\.",File.separator) + ".class");
	}
	
	public static void fixed() {
		//this is broken on OSs where the file separator is something other than /,
		//like Windows where the separator is \
		//Not broken in Unix, Linux, and Mac 
		
		//This is because the second parameter to replaceAll isn't a string 
		//but a replacement string.
		//A backslash in a replacement string escapes whatever character follows.
		//A lone backslash character is invalid.
		//Two solutions:
		//1: Matcher.quoteReplacement
		System.out.println(
			Puzzle21.class.getName().replaceAll("\\.",Matcher.quoteReplacement(File.separator)) 
				+ ".class");
				
		//2: replace(CharSequence,CharSequence) instead of replaceAll(regex,replacementString)
		System.out.println(
			Puzzle21.class.getName().replace(".",File.separator) + ".class");
		
	}
	
}