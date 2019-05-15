//FizzBuzz in java
//DS 2014-00-00

package com.dstrube;

import java.util.ArrayList;

public class FizzBuzz {

	static boolean isStage2 = false;
	
	public static void main(String[] args) {
		if (args.length > 0) {
			int i = 0;
			
			try {
				String input = args[0];
				i= Integer.parseInt(input.substring(0,1)); 
			}
			catch (NumberFormatException e){}
			if (i ==2){
				isStage2 = true;
			}
		}
		ArrayList<Integer> numbers = new ArrayList<Integer>();
		for (int i=1; i <=100; i++){
			numbers.add(i);
		}
		
		for (Integer j : numbers){
			boolean isFizz =isFizz(j);
			boolean isBuzz =isBuzz(j);
			
			if (isFizz && isBuzz)
				System.out.println("FizzBuzz");
			else if (isFizz)
				System.out.println("Fizz");
			else if (isBuzz)
				System.out.println("Buzz");
			else //(!isFizz && !isBuzz)
				System.out.println(j);
			
		}
		
	}
	
	public static boolean isFizz(int i) {
		String s = String.valueOf(i);
		
		if (i % 3 == 0  || (isStage2 && s.contains("3")))
			return true;
		return false;
	}
	
	public static boolean isBuzz(int i) {
		String s = String.valueOf(i);
		
		if (i % 5 == 0  || (isStage2 && s.contains("5")))
			return true;
		return false;
	}


}
