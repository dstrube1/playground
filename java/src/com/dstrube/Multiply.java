/*
From ~/java:

javac -d bin com/dstrube/Multiply.java
java -cp bin com.dstrube.Multiply

*/

package com.dstrube;

public class Multiply{
	public static void main(String[] args){
		try{
			System.out.println("0 * 0 = " + mutliply(0,0));
			System.out.println("0 * 1 = " + mutliply(0,1));
			System.out.println("1 * 0 = " + mutliply(1,0));
			System.out.println("1 * 1 = " + mutliply(1,1));
			System.out.println("2 * 1 = " + mutliply(2,1));
			System.out.println("1 * 2 = " + mutliply(1,2));
			System.out.println("2 * 2 = " + mutliply(2,2));
			System.out.println("-2 * 2 = " + mutliply(-2,2));
			System.out.println("2 * -2 = " + mutliply(2,-2));
			System.out.println("-1 * -2 = " + mutliply(-1,-2));
			System.out.println("-1 * 1 = " + mutliply(-1,1));
		} catch (Exception e){
	    	System.out.println("Exception");
	    }
	}
	
	private static int mutliply(int a, int b){
		if (a == 0 || b == 0) return 0;
		if (a == 1) return b;
		if (b == 1) return a;
		boolean isBNeg = (b < 0);
		boolean isANeg = (a < 0);
		int result = 0;
		if (isBNeg && isANeg) {
			a = Math.abs(a);
			b = Math.abs(b);
			for (int i = 0; i < a; i++){
				result += b;			
			}
			return result;
		}
		if (isBNeg){ //a is positive
			b = Math.abs(b);
			for (int i = 0; i < a; i++){
				result -= b;
			}
			return result;
		}
		if (isANeg){ //b is positive
			a = Math.abs(a);
			for (int i = 0; i < b; i++){
				result -= a;
			}
			return result;
		}
		
		//else, they’re both positive
		for (int i = 0; i < b; i++){
			result += a;
		}
		return result;
	}
	
}