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
		LongMax();	//9,223,372,036,854,775,807
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
	
	private static void LongMax(){
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

}