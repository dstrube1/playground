package com.dstrube.MultiplicativePersistence;

/*
From ~/java:

Compile:
javac -d bin com/dstrube/MultiplicativePersistence/NumberUtil.java

*/

import java.math.BigInteger;
import java.util.Arrays;

public class NumberUtil{
	public static String IsAllGood(BigInteger number){
		if (number.toString().contains("0")){
			// System.out.print("#0#");
// 			return false;
			return "0";
		}
		
		if (number.toString().contains("5") && containsEven(number)){
			//System.out.print("#5#");
// 			return false;
			return "5";
		}
		
		///Maybes:
		//from about 12:00 here
		//https://www.youtube.com/watch?v=Wim9WJeDTHQ
		if (number.toString().contains("1")){
// 			System.out.print("#1#");
// 			return false;
			return "1";
		}
		
		if (number.toString().contains("2") && number.toString().contains("3")){
// 			System.out.print("#6#");
// 			return false;
			return "6";
		}
		
		if (number.toString().contains("2") && number.toString().contains("4")){
// 			System.out.print("#8#");
// 			return false;
			return "8";
		}
		
		if (contains2Twos(number)){
// 			System.out.print("#4#");
// 			return false;
			return "4";
		}
		
		if (contains2Threes(number)){
// 			System.out.print("9: " + number);
// 			return false;
			return "9";
		}
		
		//Never more than 1 four? why?
		
		///END Maybes
		
		if (!areDigitsAscending(number)){
// 			System.out.print("D");
// 			return false;
			return "D";
		}
		
		return "G";//true;
	}
	
	private static boolean containsEven(final BigInteger candidate){
		final String candidateStr = candidate.toString();
		if (candidateStr.contains("2") ||
			candidateStr.contains("4") ||
			candidateStr.contains("6") ||
			candidateStr.contains("8")){
			return true;
		}
		return false;
	}
	
	private static boolean contains2Twos(final BigInteger candidate){
		final String candidateStr = candidate.toString();
		long count = candidateStr.chars().filter(ch -> ch == '2').count();
		if (count >= 2){
			return true;
		}
		return false;
	}
	
	private static boolean contains2Threes(final BigInteger candidate){
		final String candidateStr = candidate.toString();
		long count = candidateStr.chars().filter(ch -> ch == '3').count();
		if (count >= 2){
// 			System.out.println("3 count >=2: " + candidate.toString());
			return true;
		}
		return false;
	}
	
	private static boolean areDigitsAscending(final BigInteger candidate){
		final String testStr = candidate.toString();
		final String candidateStr = candidate.toString();
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
	
	public static BigInteger GetNext(final BigInteger pos){
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
			int charAtStartAsInt = 1;
			final StringBuilder posStrB1 = new StringBuilder();
			for (int i = 0; i <= posStr.length(); i++){
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
	

}