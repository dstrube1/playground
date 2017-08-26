/*
From ~/java:

javac -d bin com/dstrube/Combos.java
java -cp bin com.dstrube.Combos

Given “n” number of elements, please demonstrate how to output a permutation with a length of n.
(Duplications acceptable; please use only pseudo-code and/or algorithms in your answer.)


Input example: data = {'a', 'b', 'c' }
Output example: aaa, aab, aac, aba, abb, abc, ... , cca, ccb, ccc

*/

package com.dstrube;

public class Combos {

	static int startingIndex = 0;
	
	public static void main(String[] args) {
		char [] arr = null;
		/*
		System.out.println("Testing null");
		printCombinations(arr, 0, 0);

		System.out.println("Testing {}");
		arr = new char[] {};
		printCombinations(arr, arr.length, arr.length);

		System.out.println("Testing {a}");
		arr = new char[] {'a'};
		printCombinations(arr, arr.length, arr.length);
*/
		System.out.println("Testing {a,b}");
		arr = new char[] {'a','b'};
		//printCombinations(arr, arr.length, arr.length);

/*
		System.out.println("Testing {a,b,c}");
		arr = new char[] {'a','b','c'};
		printCombinations(arr, arr.length, arr.length);
		*/	
	}
	
 
}