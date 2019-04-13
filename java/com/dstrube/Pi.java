package com.dstrube;

/*
compile:
javac -d bin com/dstrube/Pi.java
run:
java -cp bin com.dstrube.Pi
*/

public class Pi{
	private static float piF = 4.0f;
	private static double piD = 4.0;
	private static long denominator;
	private static boolean minus;
	private static long count;
	
	public static void main(String[] args){
//		System.out.println("Pi: " + pi);
//		System.out.println("Float.SIZE = " + Float.SIZE);		
//		System.out.println("Float.MIN_VALUE = " + Float.MIN_VALUE);
//		System.out.println("Float.MIN_NORMAL = " + Float.MIN_NORMAL);
//		System.out.println("Float.MIN_EXPONENT = " + Float.MIN_EXPONENT);
		
		calcFloatPi();
		//Google says pi =~ 					  3.14159265359
		System.out.println("Float pi: " + piF); //3.1415968
		
		//calcDoublePi(); //This won't end anytime soon
		//System.out.println("Double pi: " + piD);
		//System.out.println("Double.MAX_VALUE = " + Double.MAX_VALUE);//1.7976931348623157E308
	}
	
	//https://en.wikipedia.org/wiki/Pi
	//around "Rate of convergence"
	
	public static void calcFloatPi() {
		float piB4 = 0.0f;
		denominator = 1;
		minus = true;
		count = 0;
		while (piB4 != piF) {
			piB4 = piF;
			denominator += 2;
			if (minus){
				minus = false;
				piF -= (float)4 / denominator;
			} else {
				minus = true;
				piF += (float)4 / denominator;
			}
			count++;
		}
		System.out.println("Float pi stopped changing after this many cycles: " + count); //16,777,216
	}

/*
PROBLEM: this is never true: piB4 != piD
printing out progress once every 1000000000 shows that at some point there is an overflow or some other error
that makes pi have an invalid valid, starting with 9.xxx...

SOLUTION: problem was that denominator was an int, and getting incremented led to an overflow before long;
changing it -and count- to a long made the overflow something that one needn't worry about as soon;
by the time count is very big (790800000000), the calculation is pretty close (3.1415926535872503)
note: 1000000000000000000 is a few orders of magnitude bigger than 790800000000
*/
	public static void calcDoublePi() {
		double piB4 = 0.0;
		denominator = 1;
		minus = true;
		count = 1;
		while (count > 0){//piB4 != piD) {//
			piB4 = piD;
			denominator += 2;
			if (minus){
				minus = false;
				piD -= (double)4 / denominator;
			} else {
				minus = true;
				piD += (double)4 / denominator;
			}
			count++;
			if (count % 100000000 == 0){
				System.out.println("count: "+count+"; Double pi progress: " + piD);
			}
		}
		System.out.println("Double pi stopped calculating after this many cycles: " + count);
	}

}