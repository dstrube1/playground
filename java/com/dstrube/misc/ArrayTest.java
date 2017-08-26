package com.dstrube;

public class ArrayTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		int[] i = new int[9];
		System.out.println("Populating array");
		for (int j=0;j<i.length; j++){
			i[j]=j*2;
		}
		System.out.println("Printing array");
		for (int k=0;k<i.length; k++){
			System.out.println("i["+k+"]: "+i[k]);
		}
	}

}
