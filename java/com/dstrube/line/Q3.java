/*
From ~/java:

javac -d bin com/dstrube/line/Q3.java
java -cp bin com.dstrube.line.Q3

Imagine you are playing a board game. You roll a 6-faced dice and move forward the same
number of spaces that you rolled. If the finishing point is “n” spaces away from the starting
point, please implement a program that calculates how many possible ways are there to
arrive exactly at the finishing point.

If n=610, how many possible ways are there to arrive exactly at the finishing point?
*/

package com.dstrube.line;

//import java.math.BigInteger;
//import java.util.Hashtable;
//import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicLong;

//Trying to calculate every possible permutation of rolls; failed
//http://math.stackexchange.com/questions/2012677/dice-problem-for-the-n-space

public class Q3{

	public static void main(String[] args){
		try{
	        final int n = 3;
	        //final Hashtable<String,Integer> hashtable = new Hashtable<>();
    	    //volatile ArrayList<String> list = new ArrayList<>();
        	//http://stackoverflow.com/questions/2423622/volatile-vs-static-in-java
	        final AtomicLong count = new AtomicLong(0);

    	    final int dieSides = 6;

    	    MyRunnable[] myRunnables = new MyRunnable[dieSides];
    	    Thread[] myRunnableThreads = new Thread[dieSides];
    	    for (int i = 0; i < dieSides; i++){
        	    myRunnables[i] = new MyRunnable(i + 1, n, count);
            	myRunnableThreads[i] = new Thread(myRunnables[i]);
	            myRunnableThreads[i].start();
    	    }

	        int threadCount = 0;
    	    while (myRunnableThreads[0].isAlive()
        	    || myRunnableThreads[1].isAlive()
            	|| myRunnableThreads[2].isAlive()
	            || myRunnableThreads[3].isAlive()
    	        || myRunnableThreads[4].isAlive()
        	    || myRunnableThreads[5].isAlive()
            	){
	            //wait
    	        threadCount++;
        	    if (threadCount % 100000 == 0)
            	    System.out.println("threads still alive.");
	        }
			
			System.out.println("all threads done; this many ways to arrive to " + n + ": " + count.get());

			/*
			for (int i=0; i<=10; i++){
				System.out.println("n = "+i+"; this many ways to arrive there: "+numWays(i));
				//System.out.println("n! = "+factorial(i));
			}
			//System.out.println("");
		    //roll("", 2); //2nd parameter > 0
			System.out.println("n = 610; this many ways to arrive there: "+numWays(610));
			
			//3! = 6
    		//4! = 24
    		//5! = 120
    		//6! = 720
    		*/
		}
		catch (Exception e){
			System.out.println("Exception: " + e);
		}
	}
	
	private static class MyRunnable implements Runnable {
	    private int startingDie;
	    private int target;
//	    private ArrayList<String> list;
	    private String fails;
	    private int currentTotal;
	    private String currentSequence;
//	    private boolean atStartingDie;
	    private boolean doneTesting;
	    private int currentAppend;
	    private AtomicLong count;

    	public MyRunnable(int startingDie, int target, AtomicLong count){//Hashtable<String,Integer> hashtable) {
        	this.startingDie = startingDie;
        	this.target = target;
        	fails = "";
        	currentTotal = startingDie;
        	currentSequence = "" + startingDie;
        	doneTesting = false;
        	currentAppend = 6;
        	this.count = count; 	
	    }
	    
    	@Override
	    public void run() {
	    	if (startingDie > target){
	    		return;
	    	}
	    	
	    	if (startingDie == target){
	    		count.getAndIncrement();
	    		return;
	    	}
	    	
	    	// && atStartingDie && fails.size() == 0

    		currentSequence += "+" + currentAppend;
			currentTotal += currentAppend;
    		
	    	while(!doneTesting){
	    		if (currentTotal == target){
	    			count.getAndIncrement();
		    		doneTesting = true;
	    		}
	    		else if (currentTotal < target){
	    			if (!fails.contains(currentSequence)){
	    				fails += "," + currentSequence;
			    		testGreater();
			    	}
			    	else
						doneTesting = true;
	    		}
	    		else {//if (currentTotal > target){
	    			if (!fails.contains(currentSequence)){
		    			fails += "," + currentSequence;
			    		testLess();
		    		}
			    	else
						doneTesting = true;
	    		}
	    	}
	    }
	    
	    private void testGreater(){
	    	currentAppend = 6;
    		currentSequence += "+" + currentAppend;
	    	currentTotal += currentAppend;	    	
	    }
	    
	    private void testLess(){
//	    	int lastInt = Integer.parseInt(currentSequence.substring(currentSequence.length() - 2, currentSequence.length() - 1));
	    	if (currentAppend == 1)
	    		//we're done' can't test less
	    		return;
	    	else{
	    		//
                currentTotal -= currentAppend;
                currentAppend--;
                currentTotal += currentAppend;
                currentSequence = currentSequence.substring(0, currentSequence.length() - 1);
                currentSequence += currentAppend;//lastInt - 1;
	    	}
	    }
	    
	}
	
	/*
	private static long numWays(final int n){
		if (n < 1) return 0;
		//start from this line:
		//Each positive integer n has 2^(n−1) distinct compositions
		//in this article:
		//https://en.wikipedia.org/wiki/Composition_(combinatorics)
		//BUT, this includes the number itself, which is not an option where n > number of sides on the die
		final int DIE_SIDES = 6;
		//This can be further generalized if we want to make the number of sides on the die arbitrary, e.g., d20
		if (n > DIE_SIDES){
			BigInteger numerator = factorial(n - 1);
			BigInteger denominator0 = factorial(DIE_SIDES - 1);
			BigInteger denominator1 = factorial(n - DIE_SIDES);
			return numerator.divide(denominator0.multiply(denominator1)).longValue();
		}
		else{
			return (long)Math.pow(2, (n-1));
		}
	}
	
	public static BigInteger factorial(int value){
    	if(value < 0){
	        throw new IllegalArgumentException("Value must be positive");
    	}

	    BigInteger result = BigInteger.ONE;
	    for (int i = 2; i <= value; i++) {
	        result = result.multiply(BigInteger.valueOf(i));
	    }

    	return result;
	}	
	
	//This may come in handy if we want to enumerate all the possible rolls
	public static void roll(String s, int depth) {
        if(depth == 0)
            System.out.println(s.substring(1));
        else
            for(int i = 1; i <= 6; i++)
                roll(s + "," + i, depth - 1);
    }
    */
}