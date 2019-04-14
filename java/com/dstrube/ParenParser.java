package com.dstrube;

/*
This checks to see if a string contains a valid set of parens
commands to compile and run:
from ~/java
javac -d bin com/dstrube/ParenParser.java
java -cp bin com.dstrube.ParenParser
*/

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class ParenParser{
	
	private static List<String> tests;
	
	public static void main(String[] args){
		//parenParser1();
		parenParser2();
	}
	
	//Using () {} and []
	private static void parenParser1(){
		final Stack<Character> stack = new Stack<>();
		final char openParen = '(';
		final char closeParen = ')';
		final char openBracket = '[';
		final char closeBracket = ']';
		final char openBrace = '{';
		final char closeBrace = '}';
		
		tests = new ArrayList<>();
		tests.add("()");
		tests.add("({)");
		tests.add("(})");
		tests.add("(){}");
		tests.add("(){}[]([])");
		tests.add("(){}[]([])");
		
		for (String test : tests){
			System.out.println("testing " + test);
			boolean valid = true;
			for (int i = 0; i < test.length(); i++){
				char c = test.charAt(i);
				if (c == openParen || c == openBracket || c == openBrace){
					//System.out.println("pushing " + c);
					stack.push(c);
				}else if (c == closeParen){
					char d = stack.pop();
					if (d != openParen){
						valid = false;
						break;
					}
				}else if (c == closeBracket){
					char d = stack.pop();
					if (d != openBracket){
						valid = false;
						break;
					}
				}else if (c == closeBrace){
					char d = stack.pop();
					if (d != openBrace){
						valid = false;
						break;
					}
				}else {
					valid = false;
					break;
				}
			}
			if (!valid){
				System.out.println("invalid");
			}else{
				System.out.println("valid");
			}
		}
	}
	
	//Using just ()
	private static void parenParser2(){
		final char openParen = '(';
		final char closeParen = ')';
		
		tests = new ArrayList<>();
		tests.add("()");
		tests.add(")(");
		tests.add("()()()()");
		tests.add("(((()))");
		tests.add("((((())))");
		tests.add("(((())))");
		
		for (String test : tests){
			System.out.println("testing " + test);
			int counter = 0;
			boolean valid = true;
			for (int i = 0; i < test.length(); i++){
				char c = test.charAt(i);
				if (c == openParen){
					counter++;
				}else if (c == closeParen){
					counter--;
				}else{
					valid = false;
					break;
				}
				if (counter < 0){
					valid = false;
					break;
				}
			}
			if (counter != 0 || !valid){
				System.out.println("invalid");
			}else{
				System.out.println("valid");
			}
		}
	}
}