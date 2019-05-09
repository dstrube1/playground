package com.dstrube;

/*
commands to compile and run:
from ~/java
javac -d bin com/dstrube/Basics.java 
java -cp bin com.dstrube.Basics

Some java basics for quick reference
*/
import java.math.BigInteger;
//https://docs.oracle.com/javase/7/docs/api/java/math/BigInteger.html
import java.math.BigDecimal;
import java.math.RoundingMode;//MathContext;

import java.util.Arrays;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.concurrent.ConcurrentHashMap;
import java.util.List;
import java.util.Set;

public class Basics{
	private static final ConcurrentHashMap<String,String> startingTemplates = new ConcurrentHashMap<>();
	private static final ConcurrentHashMap<String,String> currentThreadPoolTemplates = new ConcurrentHashMap<>();
	
	public static void main(String[] args){
	/*
		String string = "string";
		//https://docs.oracle.com/javase/7/docs/api/java/lang/String.html
		System.out.println(string);
		System.out.println("length: " + string.length());
		
		int[] array = new int[1];
		//https://docs.oracle.com/javase/tutorial/java/nutsandbolts/arrays.html
		System.out.println(array);
		System.out.println("length: " + array.length);
		for (int i : array){
			System.out.println("element: " + i);
		}	
		for (int i = 0; i < array.length; i++){
			System.out.println("element at " + i + " = " + array[i]);
		}	
	*/	
		//https://docs.oracle.com/javase/8/docs/api/java/util/ArrayList.html
		
		//https://stackoverflow.com/questions/40471/differences-between-hashmap-and-hashtable
		
		//https://www.geeksforgeeks.org/java/
		
		/*
		final List<Integer> list = new ArrayList<>();
		list.add(1);
		for (int i : list){
			System.out.println("element: " + i);
		}	
		manipList(list);
		for (int i : list){
			System.out.println("element: " + i);
		}
		*/
		
		/*BigInteger pos = new BigInteger("1");
		final BigInteger limit = new BigInteger("11");
		while (limit.compareTo(pos) > 0){
			System.out.println("pos " + pos + " => " + getNext(pos));
			pos = getNext(pos);
		}
		System.out.println("limit is " + limit.toString() + " and pos is " + pos.toString());*/

	}
	
	private static void manipList(List<Integer> list){
		list.add(2);
		final Comparator<Integer> cd = new SortByIntDescending();
		final Comparator<Integer> ca = new SortByIntAscending();
		list.sort(cd);
	}
	
	static final class SortByIntDescending implements Comparator<Integer> 	{ 
    	public int compare(Integer a, Integer b) {
	    	//to sort descending:
	    	return b.compareTo(a);
	    } 
	}
	
	static final class SortByIntAscending implements Comparator<Integer> { 
    	public int compare(Integer a, Integer b) {
	    	//to sort ascending:
	    	return a.compareTo(b);
	    	/* 
			if(a.compareTo(b)>0)
		        return -1;
	        else if(a.compareTo(b)<0)
    	        return 1; 
	        else 
    	        return 0;*/
	    } 
	} 
	
	//Objective: Efficiently find the next number with digits in ascending order
	private static BigInteger getNext(final BigInteger pos){
		String posStr = pos.toString();
		posStr = reverse(posStr);
		
		for (int index = 0; index < posStr.length(); index++){
			char charAtIndex = posStr.charAt(index);
			if (charAtIndex == '9'){
				if (index == posStr.length() -1){
					//special
					break;
				}
				char nextChar = posStr.charAt(index+1);
				if (nextChar == '9'){
					continue;
				}
				int nextCharAsInt = Character.digit(nextChar, 10);
				nextCharAsInt++;
				final StringBuilder posStrB0 = new StringBuilder(posStr);
				for (int index0 = 0; index0 <= index + 1; index0++){
					posStrB0.setCharAt(index0, Character.forDigit(nextCharAsInt, 10));
				}
				posStr = posStrB0.toString();
				break;
			}
			int charAsInt = Character.digit(charAtIndex, 10);
			charAsInt++;
			final StringBuilder posStrB = new StringBuilder(posStr);
			posStrB.setCharAt(index, Character.forDigit(charAsInt, 10));
			posStr = posStrB.toString();
			break;
		}
		
		posStr = reverse(posStr);
		BigInteger nextPos = new BigInteger(posStr);
		if (nextPos.compareTo(pos) == 0){		
			int charAtStartAsInt = 2;
			final StringBuilder posStrB1 = new StringBuilder();
			posStrB1.append(charAtStartAsInt);
			charAtStartAsInt = 6;
			for (int i = 0; i < posStr.length(); i++){
				posStrB1.append(charAtStartAsInt);
			}
			nextPos = new BigInteger(posStrB1.toString());
		}

		return nextPos;
	}
	private static String reverse(String input){
		String reverse = "";
        for(int i = input.length() - 1; i >= 0; i--)
        {
            reverse = reverse + input.charAt(i);
        }
        return reverse;
	}
	
	private static void percentDoneFinder(){
		//These work fine		
		//BigInteger start = new BigInteger(   "100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
		//BigInteger end = new BigInteger(     "200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
		//BigInteger progress = new BigInteger("150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
		//This does not:
		BigInteger start = new BigInteger(   "7777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777");
		BigInteger end = new BigInteger(	 "8888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888");
		BigInteger progress = new BigInteger("7777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777788888888889999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999");
		//Method 1:
/*		BigDecimal endMinusStart = new BigDecimal(end.subtract(start)); //100
		System.out.println("endMinusStart: " + endMinusStart);
		BigDecimal endMinusProgress = new BigDecimal(end.subtract(progress)); //50
		System.out.println("endMinusProgress: " + endMinusProgress);
		BigDecimal percentDone = endMinusProgress.divide(endMinusStart, 2, RoundingMode.HALF_DOWN).multiply(new BigDecimal(100));
		System.out.println("digits: " + start.toString().length() + "; percentDone: " + percentDone);
		
		//Better way of calculating, but still not great:
		BigDecimal progressMinusStart = new BigDecimal(progress.subtract(start)); //50
		BigDecimal percentDoneStage1 = progressMinusStart.divide(endMinusProgress, 200, RoundingMode.HALF_DOWN).multiply(new BigDecimal(100));
		System.out.println("percentDoneStage1: " + percentDoneStage1);
*/
		//Even better:
		//1: Get count of all same digits after 1st digit in start
		//2: Get count of that digit in progress  
		//3: % changed = % done
		char c = start.toString().charAt(1);
		double startCount = start.toString().chars().filter(ch -> ch == c).count();
		double progressCount = progress.toString().chars().filter(ch -> ch == c).count();
		double percentDone = 100 * (progressCount / startCount);
		System.out.println("percentDone: " + percentDone);
	}
	
	/*
	private static boolean areDigitsAscending(final String testStr){
		final String candidateStr = testStr;
		final char[] chars0 = testStr.toCharArray();
		final char[] chars1 = candidateStr.toCharArray();
        Arrays.sort(chars0);
        final String sorted = new String(chars0);
        final String unsorted = new String(chars1);
        if (sorted.equals(unsorted)){
        	//System.out.println(candidate + " digits are ascending");
        	return true;
        }
        //System.out.println(candidate + " digits are NOT ascending");
        return false;
	}
	
	private static BigInteger getNext0(final BigInteger pos){
		String posStr = pos.toString();
		for (int index = posStr.length() - 1; index > 0; index--){
			char charAtIndex = posStr.charAt(index);
			if (charAtIndex == '9'){
				continue;
			}
			int charAsInt = Character.digit(charAtIndex, 10);
			boolean incrementedWithin = false;
			for (int index0 = index - 1; index0 >= 0; index0--){
				char charAtIndex0 = posStr.charAt(index0);
				int charAsInt0 = Character.digit(charAtIndex0, 10);
				if (charAsInt0 == charAsInt){
					continue;
				}
				charAsInt0++;
				if (index0 == 0){
					final StringBuilder posStrB0 = new StringBuilder();
					for (int i = 0; i < posStr.length(); i++){
						posStrB0.append(charAsInt0);
					}
					posStr = posStrB0.toString();
				}else{
					final StringBuilder posStrB0 = new StringBuilder(posStr);
					posStrB0.setCharAt(index0, Character.forDigit(charAsInt0, 10));
					posStr = posStrB0.toString();
				}
				incrementedWithin = true;
				break;
			}
			if (incrementedWithin){
				break;
			}
			charAsInt++;
			final StringBuilder posStrB = new StringBuilder(posStr);
			posStrB.setCharAt(index, Character.forDigit(charAsInt, 10));
			posStr = posStrB.toString();
			break;
		}
		BigInteger nextPos = new BigInteger(posStr);
		if (nextPos.compareTo(pos) == 0){
			nextPos = new BigInteger("1" + posStr);
		}
		return nextPos;
	}
	*/
}