/*
From ~/java:

javac -d bin com/dstrube/Maths.java
java -cp bin com.dstrube.Maths

*/

package com.dstrube;

public class Maths {
	public static void main(String[] args) {
		IntMax();
	}
	private static void IntMax(){
		int i = 1;
		int i_p = 0;
		long count = 0;
		while (i_p < i){
			i++;
			i_p++;
			count++;
			if (count % 100000000 == 0)
				System.out.print(".");
		}
		System.out.println();
		System.out.println("Max of int found : " + count);
	}	
}