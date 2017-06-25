/*
From ~/java:

javac -d bin com/dstrube/line/Q1a.java
java -cp bin com.dstrube.line.Q1a

f(n) satisfies the following:

f(0) = 0

f(1) = 1

f(n) = f(n − 1) + f(n − 2)

*/

package com.dstrube.line;

import java.math.BigInteger;

public class Q1a {

	public static void main(String[] args){
		try{
/*			System.out.println("f(0) = " + f(0));
			System.out.println("f(1) = " + f(1));
			System.out.println("f(2) = " + f(2));
			System.out.println("f(8) = " + f(8));
			System.out.println("f(28) = " + f(28));
			System.out.println("f(40) = " + f(40));
			System.out.println("f(41) = " + f(41));*/
			
			/*for (int i=0; i<10; i++){
				System.out.println("f0("+i+") = " + f0(i));
			}
			for (int i=0; i<10; i++){
				System.out.println("f1("+i+") = " + f1(i));
			}
			for (int i=0; i<10; i++){
				System.out.println("f2("+i+") = " + f2(i));
			}*/
			
			System.out.println("f1(8181) = " + f1(8181));
		}
		catch (Exception e){
			System.out.println("Exception: " + e);
		}
	}

/*
Inefficient - lots of duplicate calculations */
	public static int count = 0;

	public static long f0(final int n){
		if (n < 0) throw new IllegalArgumentException();
		if (n == 0) return 0;
		if (n == 1) return 1;
		count++;
		if (count % 100000 == 0)
			System.out.print(".");//ln("f("+n+"-1) + f("+n+"-2)");
		return f0(n - 1) + f0(n - 2);
	}
/**/
	/*
	//Better - keep track of previous calculations*/
	public static BigInteger f1(final int n){
		if (n < 0) throw new IllegalArgumentException();

		if (n == 0){
			return BigInteger.ZERO;
		} 
		
		final BigInteger[] array = new BigInteger[n + 1];
		array[0] = BigInteger.ZERO;
		array[1] = BigInteger.ONE;
		for (int i = 2; i <= n; i++){
			array[i] = array[i - 1].add( array[i - 2]);
		}
		return array[n];
	}
	/**/
	public static BigInteger f2(int n) {
		BigInteger a = BigInteger.valueOf(1);
		BigInteger b = BigInteger.valueOf(0);
		for(int i = n; i > 0; i-- ) {
			BigInteger tmp = a.add(b);
			b = a;
			a = tmp;
		}
		return b;
	}
}