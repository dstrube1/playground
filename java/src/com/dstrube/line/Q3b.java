/*
From ~/java:

javac -d bin com/dstrube/line/Q3b.java
java -cp bin com.dstrube.line.Q3b

Imagine you are playing a board game. You roll a 6-faced dice and move forward the same
number of spaces that you rolled. If the finishing point is “n” spaces away from the starting
point, please implement a program that calculates how many possible ways are there to
arrive exactly at the finishing point.

If n=610, how many possible ways are there to arrive exactly at the finishing point?
*/

package com.dstrube.line;

import java.math.BigInteger;
import java.util.Hashtable;

public class Q3b{

	private static Hashtable<Integer, BigInteger> list;

	public static void main(String[] args){
		try{
			list = new Hashtable<>();
			for (int i=0; i< 50; i++){
				System.out.println("There are this many ways to get to " + (i+1) + " spaces: " + numWays(i+1));
			}
			
			System.out.println("There are this many ways to get to 610 spaces: " + numWays(610));
		}
		catch (Exception e){
			System.out.println("Exception: " + e);
		}
	}
	
	private static BigInteger numWays(final int n){
    	if (n < 0) throw new IllegalArgumentException("Value must be positive");
    	
		if (n == 0) return BigInteger.ZERO; // or is there 1 way to get to nowhere, just don't throw the die?

		//start from this line:
		//Each positive integer n has 2^(n−1) distinct compositions
		//in this article:
		//https://en.wikipedia.org/wiki/Composition_(combinatorics)
		//BUT, this includes the number itself, which is not an option where n > number of sides on the die
		final int DIE_SIDES = 6;
		//This can be further generalized if we want to make the number of sides on the die arbitrary, e.g., d20
		if (n > DIE_SIDES){
			if (list.containsKey(n)) return list.get(n);
			else{
				BigInteger value = numWays(n-1)
									.add(numWays(n-2))
									.add(numWays(n-3))
									.add(numWays(n-4))
									.add(numWays(n-5))
									.add(numWays(n-6));
				list.put(n,value);
				return value;
			}
		}
		else{
			BigInteger result = BigInteger.valueOf((long)Math.pow(2, (n-1)));
			return result;
		}
	}
}