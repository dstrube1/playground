//FizzBuzz in java
//DS 2014-02-02
//with Unit Testing

package com.dstrube;

import java.security.InvalidParameterException;

public class FizzBuzz {

	public static void main(String[] args) {
		boolean isStage2 = false;
		if (args.length > 0) {
			int i = 0;
			
			try {
				String input = args[0];
				i= Integer.parseInt(input.substring(0,1)); //we only care about the first character in the first parameter 
			}
			catch (NumberFormatException e){}
			if (i ==2){
				//default=false
				isStage2 = true;
			}
			
		}
		for (int i=1; i <= 100; i++){
		
			boolean isFizz =isFizz(i, isStage2);
			boolean isBuzz =isBuzz(i, isStage2);
			
			if (isFizz && isBuzz)
				System.out.println("FizzBuzz");
			else if (isFizz)
				System.out.println("Fizz");
			else if (isBuzz)
				System.out.println("Buzz");
			else //(!isFizz && !isBuzz)
				System.out.println(i);
		}

	}
	
	public static boolean isFizz(int i, boolean isStage2) throws InvalidParameterException{

		if (i<=0){
			throw new InvalidParameterException("Invalid parameter in isFizz");
		}
		
		String s = String.valueOf(i);
		
		if (i % 3 == 0  || (isStage2 && s.contains("3")))
			return true;
		return false;
	}
	
	public static boolean isBuzz(int i, boolean isStage2) throws InvalidParameterException{
		if (i<=0){
			throw new InvalidParameterException("Invalid parameter in isBuzz");
		}
		
		String s = String.valueOf(i);
		
		if (i % 5 == 0 || (isStage2 && s.contains("5")))
			return true;
		return false;
	}


}
