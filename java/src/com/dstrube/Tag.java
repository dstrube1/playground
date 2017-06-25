/*
From ~/java:

javac -d bin com/dstrube/Tag.java
java -cp bin com.dstrube.Tag

http://algs4.cs.princeton.edu/13stacks/

8. Tag systems. Write a program that reads in a binary string from the command line and 
applies the following (00, 1101) tag-system: if the first bit is 0, delete the first three 
bits and append 00; if the first bit is 1, delete the first three bits and append 1101. 
Repeat as long as the string has at least 3 bits. Try to determine whether the following 
inputs will halt or go into an infinite loop: 10010, 100100100100100100. Use a queue.

*/

package com.dstrube;

//import java.util.Queue;
import java.util.*;
import java.io.*;

public class Tag {
	public static void main(String[] args) {
		Scanner in = new Scanner(new BufferedReader(new InputStreamReader(System.in)));
		
    	System.out.println("Input binary");
    	String t = in.next();  // Scanner has functions to read ints, longs, strings, chars, etc.
    	
		Queue<Character> queue = new ArrayDeque<Character>();
    	for (int i=0; i< t.length(); i++){
    		if (t.charAt(i) != '0' && t.charAt(i) != '1'){
	    		System.out.println("That's not binary!: " + t.charAt(i));
	    		return;
	    	}
	    	else{
	    		//System.out.println(t.charAt(i));
	    		queue.add(t.charAt(i));
	    	}
    	}
    	if (queue.size()>=3)
	    	System.out.println("Got binary. Now we do the thing...");
	    else{
	    	System.out.println("Got binary. It's too small.");
	    	return;
	    }
    	
    	/*
    	System.out.println("Print the queue:");
    	for (char c : queue){
    		System.out.println(c);
    	}
    	
    	char c0 = queue.remove();
    	queue.add(c0);
    	
    	System.out.println("Remove something. Add the thing. Print the queue:");
    	for (char c : queue){
    		System.out.println(c);
    	}
    	*/
    	
    	while(queue.size()>=3){
    		char c = queue.remove();
    		if (c == '0'){
    			//delete the 1st 3 (including the 0?)
    			queue.remove();
    			queue.remove();
    			//append 00
    			queue.add('0');
    			queue.add('0');
    		}
    		else {//if (c == '1'){
    			//delete the 1st 3 (including the 0?)
    			queue.remove();
    			queue.remove();
    			//append 1101
    			queue.add('1');
    			queue.add('1');
    			queue.add('0');
    			queue.add('1');
    		}
	    	System.out.println("Remaining queue:");
	    	for (char c0 : queue){
    			System.out.print(c0);
    		}
	    	System.out.println();
    	}
		
	}
	    
}