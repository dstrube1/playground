/*
From ~/java:

javac -d bin com/dstrube/IntMax.java
java -cp bin com.dstrube.IntMax

*/

package com.dstrube;

public class IntMax {
	public static void main(String[] args) {
		int i = 1;
		int i_p = 0;
		long count = 0;
		while (i_p < i){
			i++;
			i_p++;
			count++;
			if (count % 10000000 == 0)
				System.out.print(".");
		}
		System.out.println();
		System.out.println("Max of int found : " + count);
	}
	
}