package com.dstrube.multiply;

import java.util.Hashtable;
import java.util.Enumeration;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/multiply/Multiply.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.multiply.Multiply
*/

public class Multiply{
	
	public static void main(String[] args){
		//multiply
		for (int i = 0; i <= 12; i++){
			for (int j = 0; j <= 12; j++){
				//System.out.println(i + " x " + j + " = " + multiply(i,j));
			}
		}
		
		//divide
		System.out.println();
		for (int i = 0; i <= 12; i++){
			for (int j = 0; j <= 12; j++){
				Hashtable<Integer,Integer> result = divide(i,j);
				Enumeration<Integer> keys = result.keys();
				int quotient = -1;
				int count = 0;
				while (keys.hasMoreElements()){
					count++;
					quotient = keys.nextElement();
					if (count > 1){
						System.out.println(count + " quotients. WTF?");
						return;
					}
				}
				if (quotient == -1 || count != 1){
					System.out.println("quotient not found. WTF?");
					return;
				}
				int remainder = result.get(quotient);
				System.out.println(i + " / " + j + " : quotient = " + quotient + ", remainder = " + remainder);
			}
		}

	}
	
	public static void hashtableRefresher(){
		//illustrate hashtable:
		Hashtable<Integer,Integer> result = new Hashtable<Integer,Integer>(1);
		Enumeration<Integer> keys = result.keys();
		while (keys.hasMoreElements()){
			System.out.println("key: " + keys.nextElement());
		}
		result.put(0,1);
		result.put(2,3);
		keys = result.keys();
		int key = 99;
		while (keys.hasMoreElements()){
			key = keys.nextElement();
			System.out.println("key: " + key);
		}
		result.remove(key);
		keys = result.keys();
		while (keys.hasMoreElements()){
			key = keys.nextElement();
			System.out.println("key: " + key);
		}
		int value = result.get(key);
		System.out.println("value: " + value);
	}
	
	public static int multiply(int x, int y){
		if (y == 0) return 0;
		
		int z = multiply(x, y/2);

		if (y%2 == 0) return 2 * z;

		else return x + (2 * z);
	}
	
	public static Hashtable<Integer,Integer> divide(int numerator, int denominator){
		Hashtable<Integer,Integer> result = new Hashtable<Integer,Integer>(1);
		if (numerator == 0){
			result.put(0,0);
			return result;
		}
		result = divide(numerator/2, denominator); //int 1 / 2 = 0
		Enumeration<Integer> keys = result.keys();
		int key = -1;
		int count = 0;
		while (keys.hasMoreElements()){
			count++;
			key = keys.nextElement();
			if (count > 1){
				System.out.println(count + " keys. WTF?");
				return null;
			}
		}
		if (key == -1 || count != 1){
			System.out.println("key not found. WTF?");
			return null;
		}
		int value = result.get(key);
		result.remove(key);
		key /= 2;
		value *= 2;
		if (numerator%2 == 1){
			value++;
		}
		if (value >= denominator){
			value = value - denominator;
			key++;
		}
		result.put(key,value);
		
		return result;
	}
}