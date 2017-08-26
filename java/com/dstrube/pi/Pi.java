package com.dstrube.pi;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/pi/Pi.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.pi.Pi
*/

public class Pi{
	private static float piF = 4.0f;
	private static double piD = 4.0;
	private static int denominator;
	private static boolean minus;
	private static int count;
	
	public static void main(String[] args){
//		System.out.println("Pi: " + pi);
//		System.out.println("Float.SIZE = " + Float.SIZE);		
//		System.out.println("Float.MIN_VALUE = " + Float.MIN_VALUE);
//		System.out.println("Float.MIN_NORMAL = " + Float.MIN_NORMAL);
//		System.out.println("Float.MIN_EXPONENT = " + Float.MIN_EXPONENT);
		
		calcFloatPi();
		//Google says pi =~ 					  3.14159265359
		System.out.println("Float pi: " + piF); //3.1415968
		
		calcDoublePi();
		System.out.println("Double pi: " + piD);
		
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
LEFTOFF: this is never true: piB4 != piD
printing out progress once every 1000000000 shows that at some point there is an overflow or some other error
that makes pi have an invalid valid, starting with 9.xxx...
*/
	public static void calcDoublePi() {
		double piB4 = 0.0;
		denominator = 1;
		minus = true;
		count = 0;
		while (piB4 != piD) {//count < 100000000){//
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
			if (count % 1000000000 == 0){
				System.out.println("Double pi progress: " + piD);
			}
		}
		System.out.println("Double pi stopped changing after this many cycles: " + count);
	}

}