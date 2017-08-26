/*
From ~/java:

javac -d bin com/dstrube/line/Q1.java
java -cp bin com.dstrube.line.Q1

f(n) satisfies the following:

f(0) = 0

f(1) = 1

f(n) = f(n − 1) + f(n − 2)

*/

package com.dstrube.line;

public class Q1 {

	public static void main(String[] args){
		try{
			System.out.println("f(0) = " + f(0));
			System.out.println("f(1) = " + f(1));
			System.out.println("f(2) = " + f(2));
			System.out.println("f(8) = " + f(8));
			System.out.println("f(28) = " + f(28));
			System.out.println("f(40) = " + f(40));
			System.out.println("f(41) = " + f(41));
			System.out.println("f(8181) = " + f(8181));
			//System.out.println("f(-1) = " + f(-1));
		}
		catch (Exception e){
			System.out.println("Exception: " + e);
		}
	}

/*
Inefficient - lots of duplicate calculations
	public static int count = 0;

	public static long f(final int n){
		if (n < 0) throw new IllegalArgumentException();
		if (n == 0) return 0;
		if (n == 1) return 1;
		count++;
		if (count % 100000 == 0)
			System.out.print(".");//ln("f("+n+"-1) + f("+n+"-2)");
		return f(n - 1) + f(n - 2);
	}
*/
	
	//Better - keep track of previous calculations
	public static long f(final int n){
		if (n < 0) throw new IllegalArgumentException();

		if (n == 0){
			return 0;
		} 
		
		final long[] array = new long[n + 1];
		array[0] = 0;
		array[1] = 1;
		for (int i = 2; i <= n; i++){
			array[i] = array[i - 1] + array[i - 2];
		}
		return array[n];
	}
}