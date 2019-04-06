package com.dstrube;

import java.util.Date;
import java.util.concurrent.TimeUnit;

/*
commands to compile and run:
from ~java
javac -d bin com/dstrube/Fibonacci.java
java -cp bin com.dstrube.Fibonacci
*/

public class Fibonacci{
	private static int count;
	
	public static void main(String[] args){
		MyRunnable1 myRunnable1 = new MyRunnable1("inefficientFibCalc", 5); 
		Thread myRunnable1Thread = new Thread(myRunnable1);
		//myRunnable1Thread.start();
		
		//long starts failing at 92
		//next step: BigInteger?
		//MyRunnable2 myRunnable2 = new MyRunnable2("efficientFibCalc_0", 93); 
		//Thread myRunnable2Thread = new Thread(myRunnable2);
		//myRunnable2Thread.start();
		//this is so fast, no point in doing it with threads
		for (int i = 90; i <= 93; i++){
			final long fibI = efficientFibCalc_0(i);
			System.out.println("efficientFibCalc_0(" + i + ") = " + fibI );
			//fib(93) = -6246583658587674878
		}
		
		//Using the "even more efficient" algorithm has some interesting results
		System.out.println();
		for (int i = 90; i <= 93; i++){
			final double fibD = efficientFibCalc_1(i);
			System.out.println("efficientFibCalc_1(" + i + ") = " + Math.round(fibD) );
			//fib(93) = fib(94) = fib(95)... = 9223372036854775807 = (2^63) -1, the maximum value for a 64-bit signed integer
		}
		
		//This is much bigger than that^:
		System.out.println();
		System.out.println("Double.MAX_VALUE = " + Double.MAX_VALUE);
		//Maybe we should use Double instead of double?
		
		//also, 90-92 using efficientFibCalc_1 is off by a few compared to 90-92 using efficientFibCalc_0;
		//my guess is efficientFibCalc_0 is more reliable than efficientFibCalc_1, due to rounding and square rooting;
		//let's see where the discrepancy begins:
		
		System.out.println();
		for (int i = 0; i<=90; i++){
			final long fibI = efficientFibCalc_0(i);
			final double fibD = efficientFibCalc_1(i);
			if (fibD - fibI != 0){
				System.out.println("Discrepancy begins at " + i);
				break;
			}
		}
		
		for (int i = 70; i<=81; i++){
			final long fibI = efficientFibCalc_0(i);
			final double fibD = efficientFibCalc_1(i);
			System.out.println("efficientFibCalc_0(" + i + ") = " + fibI + "; " 
				+ "efficientFibCalc_1(" + i + ") = " + Math.round(fibD) + "; "
				+ "diff = " + (Math.round(fibD) - fibI)); //difference is not exactly fibonacci, but it's starts out close
		}
		
		System.out.println();
		for (int i = 0; i<=11; i++){
			final long fibI = efficientFibCalc_0(i);
			System.out.println("efficientFibCalc_0(" + i + ") = " + fibI);
		}

	}
	
	public static long efficientFibCalc_0(final int start) {
		if (start == 0){
			return 0;
		} 
		
		final long[] array = new long[start+1];
		array[0] = 0;
		array[1] = 1;
		for (int i = 2; i <= start; i++){
			array[i] = array[i - 1] + array[i - 2];
		}
		return array[start];
	}
	
	public static double efficientFibCalc_1(final int start) {
		double result = 0;
		final double A = 1 / Math.pow(5,0.5); //oneSquareRootedFifth
		final double B = (1 + (Math.pow(5,0.5)))/2; //quotientOfSumOfOneAndSquareRootedFiveAndTwo
		final double C = (1 - (Math.pow(5,0.5)))/2; //quotientOfDifferenceOfOneAndSquareRootedFiveAndTwo
		result = (A * Math.pow(B, start)) - (A * Math.pow(C, start));
		return Math.round(result);
	}
	
	private static class MyRunnable1 implements Runnable {
	    private String mName;
	    private long mSeed;
	    private Date masterDate;

    	public MyRunnable1(String name, long seed) {
        	mName = name;
        	mSeed = seed;
        	masterDate = new Date();
	    }
	    
	    public String getName(){return mName;}
	    
    	@Override
	    public void run() {
	    	for (long i=0; i < mSeed; i++){
        	    final long fibI = inefficientFibCalc(i);
	    		final Date slaveDate = new Date();
		    	final long diff = slaveDate.getTime() - masterDate.getTime();
        	    final long diffMinutes = TimeUnit.MILLISECONDS.toMinutes(diff);
        	    final long diffSeconds = TimeUnit.MILLISECONDS.toSeconds(diff) % 60;
        	    final long millis = diff % 1000; //right?
				System.out.println(getName() + "(" + i + ") = " + fibI 
					+ " calculated in " + diffMinutes + ":" + diffSeconds + "." + millis);
				masterDate = new Date();
			}
	    }
	    
	    public static long inefficientFibCalc(final long start) {
			if (start == 0){
				return 0;
			} else if (start == 1){
				return 1;
			} else {
				return (inefficientFibCalc(start - 1)) + (inefficientFibCalc(start - 2));
			}
		}
	}
	
	private static class MyRunnable2 implements Runnable {
	    private String mName;
	    private long mSeed;
	    private Date masterDate;

    	public MyRunnable2(String name, long seed) {
        	mName = name;
        	mSeed = seed;
        	masterDate = new Date();
	    }
	    
	    public String getName(){return mName;}
	    
    	@Override
	    public void run() {
	    	for (int i=0; i < mSeed; i++){
        	    final long fibI = efficientFibCalc_0(i);
	    		final Date slaveDate = new Date();
		    	final long diff = slaveDate.getTime() - masterDate.getTime();
        	    final long diffMinutes = TimeUnit.MILLISECONDS.toMinutes(diff);
        	    final long diffSeconds = TimeUnit.MILLISECONDS.toSeconds(diff) % 60;
        	    final long millis = diff % 1000; //right?
				System.out.println(getName() + "(" + i + ") = " + fibI );
				//It's so fast, there's no point in printing how long it took
//					+ " calculated in " + diffMinutes + ":" + diffSeconds + "." + millis);
				masterDate = new Date();
			}
	    }
	    
	    /*public static long efficientFibCalc_0(final int start) {
			if (start == 0){
				return 0;
			} 
			
			final long[] array = new long[start+1];
			array[0] = 0;
			array[1] = 1;
			for (int i = 2; i <= start; i++){
				array[i] = array[i - 1] + array[i - 2];
			}
			return array[start];
		}*/
	}
	
	private static class MyRunnable3 implements Runnable {
	    private String mName;
	    private long mSeed;
	    private Date masterDate;

    	public MyRunnable3(String name, long seed) {
        	mName = name;
        	mSeed = seed;
        	masterDate = new Date();
	    }
	    
	    public String getName(){return mName;}
	    
    	@Override
	    public void run() {
	    	for (int i=0; i < mSeed; i++){
        	    final double fibI = efficientFibCalc_1(i);
	    		final Date slaveDate = new Date();
		    	final long diff = slaveDate.getTime() - masterDate.getTime();
        	    final long diffMinutes = TimeUnit.MILLISECONDS.toMinutes(diff);
        	    final long diffSeconds = TimeUnit.MILLISECONDS.toSeconds(diff) % 60;
        	    final long millis = diff % 1000; //right?
				System.out.println(getName() + "(" + i + ") = " + fibI );
				//It's so fast, there's no point in printing how long it took
//					+ " calculated in " + diffMinutes + ":" + diffSeconds + "." + millis);
				masterDate = new Date();
			}
	    }
	    
	    public static double efficientFibCalc_1(final int start) {
			final double result = 0;
			
			return result;
		}
	}

	
}