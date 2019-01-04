/*
From ~/java:

javac -d bin com/dstrube/Maths.java
java -cp bin com.dstrube.Maths

*/

package com.dstrube;

import java.math.BigInteger;

public class Maths {
	
	public static void main(String[] args) {
//		ByteMax(); //127
//		ShortMax(); //32767
//		CharMax(); 	//65535
//		IntMax(); 	//2,147,483,647
//		LongMax();	//9,223,372,036,854,775,807
//		FloatMax(); //3.4028235E38
//		DoubleMax(); //1.7976931348623157E308
		BigIntegerMax(); //complicated
	}
	
    private static void ByteMax() {
        byte c = 1;
        byte c_p = 0;
        long count = 0;
        while (c_p < c)
        {
            c++;
            c_p++;
            count++;
        }
        System.out.println("Authoritative max of byte: " + Byte.MAX_VALUE);
        System.out.println("Max of byte found: " + count);
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
        System.out.println("Authoritative max of short: " + Short.MAX_VALUE);
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
        System.out.println("Authoritative max of char: " + Character.MAX_VALUE);//question mark box
		System.out.println("Max of char found : " + count);
	}
	
	private static void IntMax(){
		int i = 1;
		int i_p = 0;
		long count = 0;
        System.out.println("Authoritative max of int: " + Integer.MAX_VALUE);
		while (i_p < i){
			i++;
			i_p++;
			count++;
			if (count % 100000000 == 0){
				System.out.print(".");
			}
		}
		System.out.println();
		System.out.println("Max of int found : " + count);
	}	
	
	private static void LongMax(){
        System.out.println("Authoritative max of long: " + Long.MAX_VALUE);
		System.out.println("long max is about " + getLongMaxEstimate());
		//1,000,000,000,000,000,000 - 1 quintillion, same as in c++
		
		System.out.println("Recursively calculating long maximum...");
		recursiveLongMaxFinder(1,10);
		//9,223,372,036,854,775,807 - about 9 quintillion, same as in c++
	}
	
	private static long getLongMaxEstimate(){
		long myLong = 1;
	    long ltemp = myLong;
    	while (ltemp > 0){ //when ltemp exceeds the maximum, it loops around to a negative
        	myLong = ltemp;
	        ltemp *= 10;
    	    //System.out.println("long max guess = " + myLong + "\n");
	    }
	    return myLong;
	}
	
	private static boolean recursiveLongMaxFinder(long candidate, int factor){
	    if (factor < 2){
    	    if (candidate < 0){
        	    System.out.println("something went wrong; candidate is " + candidate);;
            	return false;
	        }else{
    	        //System.out.println("Narrowed down to factor " + factor + " and candidate is " + candidate);
        	    long estimate = getLongMaxEstimate();
            	return recursiveLongMaxFinderAdd(candidate, estimate);
	        }
    	}
	    long product = candidate * factor;
    	if (product > 0){
        	return recursiveLongMaxFinder(product, factor);
	    }
    	else{
        	return recursiveLongMaxFinder(candidate, factor-1);
	    }
	}
	
	private static boolean recursiveLongMaxFinderAdd(long candidate, long addend){
		    if (addend == 1){
	        if (candidate < 0){
    	        System.out.println("something went wrong; candidate is " + candidate);
        	    return false;
	        }else{
    	        long count = 0;
        	    long ltemp = candidate;
            	while (ltemp > 0){
                	candidate = ltemp;
	                ltemp++;
    	            count++;
        	    }
            	System.out.println("long max found: " + candidate);
	            return true;
    	    }
	    }
    	long sum = candidate + addend;
	    if (sum > 0){
    	    return recursiveLongMaxFinderAdd(sum, addend);
	    }
    	else{
        	//System.out.println(candidate + " + " + addend + " is too much; trying " + candidate + " + " + (addend / 2));
	        return recursiveLongMaxFinderAdd(candidate, addend / 2);
    	}
	}

	private static void FloatMax(){
		System.out.println("authoritative float max: " + Float.MAX_VALUE);//3.4028235E38
		System.out.println("float max approximately = "+getFloatMaxEstimate());//1e38
	    System.out.println("Recursively calculating float maximum...");//3.4028235E38
    	float estimate = getFloatMaxEstimate();
    	recursiveFloatMaxFinder(estimate, estimate / 10); //3.40282e+38
	}
	
	private static float getFloatMaxEstimate(){
	    float myFloat = 1.0f;
	    float fTemp = myFloat;
	    int count = 0;
	    while (fTemp != Float.POSITIVE_INFINITY){
	        myFloat = fTemp;
	        fTemp *= 10;
//	        System.out.println("float max guess: "+ myFloat);
	        count++;
	    }
	    return myFloat; //1e+38
	}
	
	private static boolean recursiveFloatMaxFinder(float candidate, float addend){
		if (addend <= 1){
        
	        float estimate = getFloatMaxEstimate();
        
    	    if (candidate < estimate){
        	    System.out.println("something went wrong; candidate: " + candidate + "; estimate: " + estimate);
            	return false;
	        }else{
    	        long count = 0;
        	    float fTemp = candidate + 1;
            	//            System.out.println("candidate is " + candidate + " and fTemp is" + fTemp);
            	while (fTemp > candidate){
                	candidate = fTemp;
                	fTemp++;
                	count++;
//                	if (count % INT_MOD == 0) cerr + ".";
//                	System.out.println("candidate is " + candidate + " and fTemp is" + fTemp);
	                if (fTemp == fTemp - 1){
    	                System.out.println("something went wrong; incrementig fTemp doesn't work at fTemp: " + fTemp);
        	            return false;
            	    }
            	}
            	System.out.println("float max found: " + candidate); ////3.40282e+38
            	return true;
        	}
	    }
    
    	float sum = candidate + addend;
    
    //System.out.println("sum: " + sum + " = " + candidate + " + " + addend);
    
	    if (sum != Float.POSITIVE_INFINITY && sum > candidate){
//        System.out.println(candidate + " + " + addend + " is < " + sum);
	        return recursiveFloatMaxFinder(sum, addend);
    	}
    	else{
//        System.out.println(candidate + " + " + addend + " is too much (" + sum + "); trying " + candidate + " + " + (addend / 2));
        	return recursiveFloatMaxFinder(candidate, addend / 2);
	    }
	} 
	
	private static void DoubleMax(){
		System.out.println("authoritative double max: " + Double.MAX_VALUE);		//1.7976931348623157E308
		System.out.println("double max approximately = "+getDoubleMaxEstimate());	//9.999999999999998E307
	    System.out.println("Recursively calculating double maximum...");
    	double estimate = getDoubleMaxEstimate();
    	recursiveDoubleMaxFinder(estimate, estimate / 10); 							//1.7976931348623157E308
	}
	
	private static double getDoubleMaxEstimate(){
	    double myDouble = 1.0f;
	    double dTemp = myDouble;
	    int count = 0;
	    while (dTemp != Double.POSITIVE_INFINITY){
	        myDouble = dTemp;
	        dTemp *= 10;
//	        System.out.println("double max guess: " + myDouble);
	        count++;
	    }
	    return myDouble; //
	}
	
	private static boolean recursiveDoubleMaxFinder(double candidate, double addend){
		if (addend <= 1){
        
	        double estimate = getDoubleMaxEstimate();
        
    	    if (candidate < estimate){
        	    System.out.println("something went wrong; candidate: " + candidate + "; estimate: " + estimate);
            	return false;
	        }else{
    	        long count = 0;
        	    double dTemp = candidate + 1;
            	//System.out.println("candidate is " + candidate + " and dTemp is" + dTemp);
            	while (dTemp > candidate){
                	candidate = dTemp;
                	dTemp++;
                	count++;
//                	if (count % INT_MOD == 0) cerr + ".";
//                	System.out.println("candidate is " + candidate + " and dTemp is" + dTemp);
	                if (dTemp == dTemp - 1){
    	                System.out.println("something went wrong; incrementig dTemp doesn't work at dTemp: " + dTemp);
        	            return false;
            	    }
            	}
            	System.out.println("double max found: " + candidate); ////
            	return true;
        	}
	    }
    
    	double sum = candidate + addend;
    
    //System.out.println("sum: " + sum + " = " + candidate + " + " + addend);
    
	    if (sum != Double.POSITIVE_INFINITY && sum > candidate){
//        System.out.println(candidate + " + " + addend + " is < " + sum);
	        return recursiveDoubleMaxFinder(sum, addend);
    	}
    	else{
//        System.out.println(candidate + " + " + addend + " is too much (" + sum + "); trying " + candidate + " + " + (addend / 2));
        	return recursiveDoubleMaxFinder(candidate, addend / 2);
	    }
	} 

	private static void BigIntegerMax(){
		//https://docs.oracle.com/javase/7/docs/api/java/math/BigInteger.html
		//BigInteger bi = new BigInteger("1");
		//System.out.println("BigInteger 1 = " + bi.toString());	//1
		//bi = bi.multiply(BigInteger.TEN);
		//System.out.println("BigInteger 10 = " + bi.toString());	//10
		
		//This seems to have no bottom, limited only by the amount of memory one has
//		while(true){
//			bi = bi.multiply(BigInteger.TEN);
//			System.out.println("BigInteger 10 = " + bi.toString());	
//		}

		//bi = bi.pow(100);
		//System.out.println("BigInteger 10^100 = " + bi.toString());		//[10^100]
		
		//This is weird:
//		System.out.println("BigInteger intValue() = " + bi.intValue());	//0 ???
//		System.out.println("BigInteger toString() = " + bi.toString());	//still [10^100]
		//But kind of makes sense: bottom 32 bits of a googol is 0
	
		//Go big
		//Reset to ten
		//bi = new BigInteger("1");
		//bi = bi.multiply(BigInteger.TEN);
		//This doesn't break, but it also seems stuck; maybe try on a bigger machine
		//System.out.println("BigInteger 10^IntMax... = ");		
		//bi = bi.pow(Integer.MAX_VALUE);
		//System.out.println(bi.toString());		
		
		//Let's try smaller numbers...
//		bi = bi.pow(100000); //10 ^ 100,000
//		System.out.println("BigInteger 10^100k = " + bi.toString());
		//^Fills the screen with zeroes, but completes just fine

		//This is too much:
//		bi = bi.pow(100000000); //10 ^ 100,000,000
//		System.out.println("BigInteger 10^100M = " + bi.toString());

		//Takes a second, but it finishes
//		bi = bi.pow(1000000); //10 ^ 1,000,000
//		System.out.println("BigInteger 10^1M = " + bi.toString());

		//Takes a few seconds, but finishes
		//System.out.println("BigInteger 10^10M...(takes a few seconds) = ");	
		//bi = bi.pow(10000000); //10 ^ 10,000,000
		//System.out.println(bi.toString());
		//Is there a way to indicate its progress?
		//probably not, but next best thing: timer with a separate thread printing out while counting to long max?
		
		final RunnableCounter runnableCounter = new RunnableCounter(); 
        final Thread counterThread = new Thread(runnableCounter);//, "counterThread");
        counterThread.start();
        
        final MultiThreadedBigIntegerTester biTester = new MultiThreadedBigIntegerTester();
        biTester.start();
        
        while (biTester.isAlive()){}
        
        System.out.println("\n biTester is dead; interrupting counter...");
        
	    runnableCounter.stop();
	}
}

class MultiThreadedBigIntegerTester extends Thread 
{ 
    public void run() 
    { 
        try
        { 
			BigInteger bi = new BigInteger("1");
			bi = bi.multiply(BigInteger.TEN);
			System.out.println("BigInteger 10^10M...(takes a few seconds) = ");
			bi = bi.pow(10000000); //10 ^ 10,000,000
			System.out.println(bi.toString());
        } 
        catch (Exception e) 
        { 
            // Throwing an exception 
            System.out.println ("Exception is caught"); 
        } 
    } 
} 

class RunnableCounter implements Runnable 
{ 
	private volatile boolean exit = false;
	
    public void run() 
    { 
        try
        { 
			long count = 0;
			while (!exit){
				count++;
				if (count % 100000000 == 0){
					System.out.print(".");
				}
			}
        } 
        catch (Exception e) 
        { 
            // Throwing an exception 
            System.out.println ("Exception is caught"); 
        } 
    } 
    
    public void stop(){
    	exit = true;
    }
} 