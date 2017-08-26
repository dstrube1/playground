/*
From ~/java:

javac -d bin com/dstrube/Tests.java
java -cp bin com.dstrube.Tests

*/

package com.dstrube;

import java.util.*;
import java.math.BigInteger;
import java.io.*;

public class Tests {
	public static void main(String[] args) {
		//ArrayTest();
		
//		int i = 3;
//		System.out.println("3 / 2 = " + (i/2));

		//dotTest();
		
//		long m = 64;
//		long n = 2;
//		System.out.println("greatest common denominator of "+m+","+n+": " + gcd(m,n));
//		System.out.println("least common multiple of "+m+","+n+": " + lcm(m,n));

//		selfListAdd();
		
//		queueTest();

		//scannerTest();
		
		//ioTest();
		
		
	}
	
	private static void xTest(){
		//
	}
	
	private static void ioTest(){
		System.out.println("Enter a number > 0 and <= 100:");
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		try{
			String input = br.readLine();
		    int num = Integer.parseInt(input);
	    	while (num < 1 || num > 100){
	    		System.out.println("Invalid. Try again: ");
		    	input = br.readLine();
		    	num = Integer.parseInt(input);
	    	}
		    System.out.println("Valid!: " + num);
	    } catch (IOException e0){
	    	System.out.println("Caught exception: " + e0);
	    } catch (NumberFormatException e1){
   	    	System.out.println("Caught exception: " + e1);
	    }
	}
	
	private static void scannerTest(){
		System.out.println("enter a number");
		Scanner scanner = new Scanner(System.in);
		//	String temp = scanner.next();
		//	System.out.println("temp: " + temp);
		try{
			int i = scanner.nextInt();
			System.out.println("i: " + i);
		} catch (InputMismatchException e){
			System.out.println("exception " + e);
		}
	}
	
	private static void queueTest(){
		Queue<Long> q = new ArrayDeque<Long>();
		q.add(0L);
		q.add(1L);
		for (int i = 0; i < 8181; i++) {
		    long a = q.remove();
		    long b = q.remove();
		    q.add(b);
		    q.add(a + b);
		    System.out.println(a);
		}
		
		Queue<BigInteger> q0 = new ArrayDeque<>();
		q0.add(BigInteger.ZERO);
		q0.add(BigInteger.ONE);
		for (int i = 0; i < 8181; i++) {
		    BigInteger a = q0.remove();
		    BigInteger b = q0.remove();
		    q0.add(b);
		    q0.add(a.add(b));
		    System.out.println(b+"\n");
		}
	}
	
	private static void selfListAdd(){
		//while it is permissible for lists to contain themselves as elements, 
		//extreme caution is advised: 
		//the equals and hashCode methods are no longer well defined on a such a list
		List list1 = new ArrayList();
		List list2 = new ArrayList();
		list1.add(list2);
		list2.add(list1);
		try{
			System.out.println(list1.equals(list2));
		}catch (StackOverflowError e){
			System.out.println(e.getClass().getSimpleName());
		}
		
		List list = new ArrayList();
		list.add(list);
		try{
			System.out.println(list.hashCode());
		}catch (StackOverflowError e){
			System.out.println(e.getClass().getSimpleName());
		}
	}
	
	// return gcd(|m|, |n|)
    private static long gcd(long m, long n) {
        if (m < 0) m = -m;
        if (n < 0) n = -n;
        if (0 == n) return m;
        else return gcd(n, m % n);
    }
	
	// return lcm(|m|, |n|)
    private static long lcm(long m, long n) {
        if (m < 0) m = -m;
        if (n < 0) n = -n;
        return m * (n / gcd(m, n));    // parentheses important to avoid overflow
    }
    
	private static void dotTest(){
		threeDots();
		threeDots(1);
		threeDots(0,1);
		//threeDots(null); //this throws a NPE
	}

	//private static void twoDots(int.. i){} invalid syntax
	
	private static void threeDots(int... i){
		for (int j = 0; j < i.length; j++)
			System.out.println("threeDots: " + i[j]);
	}
	
	private static void ArrayTest(){
		int[] a = {1};
		int[] b = a;
		System.out.println("a[0] = " + a[0] + "; b[0] = " + b[0]);
		a[0] = 2;
		System.out.println("a[0] = " + a[0] + "; b[0] = " + b[0]);
		changeArray(a);
		System.out.println("a[0] = " + a[0] + "; b[0] = " + b[0]);
	}
	
	private static void changeArray(int[] c){
		c[0] = 0;
	}
}