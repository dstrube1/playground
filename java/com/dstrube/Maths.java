/*
From ~/java:

javac -d bin com/dstrube/Maths.java
java -cp bin com.dstrube.Maths

*/

package com.dstrube;

public class Maths {
	
	public static void main(String[] args) {
//		ShortMax(); //32767
//		CharMax(); 	//65535
//		IntMax(); 	//2,147,483,647
	}
	
	private static void ShortMax(){
		short s = 1;
		short s_p = 0;
		long count = 0;
		while (s_p < s){
			s++;
			s_p++;
			count++;
		}
		System.out.println();
		System.out.println("Max of short found : " + count);
	}
	
	private static void CharMax(){
	/* Can't just print out a char, must cast it as something like an int
		char c = 0;
		int i = (int) c;
		System.out.println("c = " + i);
		c++;
		i = (int) c;
		System.out.println("c = " + i);
		*/
		char c = 1;
		char c_p = 0;
		long count = 0;
		while (c_p < c){
			c++;
			c_p++;
			count++;
		}
		System.out.println();
		System.out.println("Max of char found : " + count);
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