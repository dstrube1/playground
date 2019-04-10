package com.dstrube;

/*
Given a string of numbers, find the next highest number with the same digits

commands to compile and run:
from ~/java
javac -d bin com/dstrube/NextHighest.java
java -cp bin com.dstrube.NextHighest

*/

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class NextHighest{
	
	private static final List<String> tests = new ArrayList<>();
	
	public static void main(String[] args){

		tests.add("1234"); //expected 1243
		tests.add("12"); //expected 21
		tests.add("349861"); //expected 361489
		tests.add("9812864"); //expected 9814268
		tests.add("43"); //expected No higher found
		
		for (String test : tests){
			System.out.println("from " + test + " found " + findNext(test));
		}
	}
	
	private static String findNext(final String original){
		if (original == null || original.length() == 0 || original.length() == 1
			|| !onlyNumbers(original)){
			return original;
		}
		
		String copy = reverse(original);//349861 -> 168943
		//System.out.println("copy: " + copy);
		for (int i = 0; i < copy.length() - 1; i++){
			final int x = Integer.valueOf(copy.substring(i, i + 1));
			final int y = Integer.valueOf(copy.substring(i + 1, i + 2));
			//System.out.println("x = " + x + "; y = " + y);
			if ( y >= x){
				continue;
			}
			final int closestHigherIndex = indexOfClosestHigher(copy, i + 1);
			if (closestHigherIndex == -1){
				System.out.println("No closest higher index found");
				return original;
			}
			copy = swap(copy, i + 1, closestHigherIndex);
			if (i == copy.length() - 1){
				return original;
			}
			copy = sortRemainingAscending(copy, i + 1);
			copy = reverse(copy);
			return copy;
		} 
		return original;
	}
	
	private static boolean onlyNumbers(final String string){
		final String numbers = "1234567890";
		for (int i = 0; i < string.length() - 1; i++){
			if (!numbers.contains(string.substring(i,i+1))){
				return false;
			}
		}
		return true;
	}
	
	private static String reverse(final String string){
		if (string == null || string.length() == 0  || string.length() == 1){
			return string;
		}
		
		String reversed = "";
		for (int i = string.length() - 1; i >= 0; i--){
			reversed += string.charAt(i);
		}
		
		return reversed;
	}
	
	private static int indexOfClosestHigher(final String string, final int indexToCompare){
		final int compare = Integer.valueOf(string.substring(indexToCompare, indexToCompare + 1)); //4
		int closestHigherIndex = -1;
		int lastDiffFound = 10;
		for (int i = 0; i < indexToCompare; i++){
			final int current = Integer.valueOf(string.substring(i, i + 1));
			if (current > compare){
				if (current - compare < lastDiffFound){
					lastDiffFound = current - compare;
					closestHigherIndex = i;
				}
			}
		}
		return closestHigherIndex;
	}
	
	private static String swap(final String string, final int x, final int y){
		final char ch[] = string.toCharArray(); 
        final char temp = ch[x]; 
        ch[x] = ch[y]; 
        ch[y] = temp; 
        
        return new String(ch); 
	}
	
	private static String sortRemainingAscending(final String string, final int index){
		final String toBeSorted = string.substring(0, index);
		final String remainder = string.substring(index);
		final char[] chars = toBeSorted.toCharArray();
		Arrays.sort(chars);
		final String sorted = new String(chars);
		return reverse(sorted) + remainder;
	}
}