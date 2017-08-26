package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle28.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle28

*/

import java.util.Date;

public class Puzzle28{
	//Looper
	
	public static void main(String[] args){
		//System.out.println("Starting makeMeInfinite1...");
		//makeMeInfinite1();
		System.out.println("Starting makeMeInfinite2...");
		makeMeInfinite2();
	}
	
	public static void makeMeInfinite1() {
		//This works because of the overflow behavior shown in Puzzle26
		MyRunnable1 myRunnable1 = new MyRunnable1("makeMeInfinite1Runnable", Integer.MAX_VALUE - 1);
		Thread myRunnable1Thread = new Thread(myRunnable1);
		myRunnable1Thread.start();
		MasterRunnable masterRunnable = new MasterRunnable(myRunnable1Thread, myRunnable1.getName());
		new Thread(masterRunnable).start();
		try{
			//Give it some time to kill after 5 seconds
			Thread.sleep(1000 * 6);
		} catch (InterruptedException ie) {
			System.out.println("InterruptedException while sleeping in makeMeInfinite1");
	    }
		System.out.println("makeMeInfinite1: Done");
	}
	public static void makeMeInfinite2() {
		MyRunnable2 myRunnable2 = new MyRunnable2("makeMeInfinite2Runnable", 
			//(1.0 / 0.0) ); //one way to do it
			//Double.POSITIVE_INFINITY); //better
			1.0e17);/*
				even a sufficiently large number will do; this is because 
				the larger the value, the larger the distance between the value 
				and its successor; adding 1 to a sufficiently large float will not change 
				its value because it doesn't bridge the gap; 
				floating point operations return the floating point that is closest
				to their exact mathematical result;
				for float, the least magnitude beyond which adding 1 will have no effect 
				is 2^25, 33,554,432
				for double, it's 2^54, about 1.8*10^16
				ulp: distance between adjacent floating-point values, acronym for unit in the last place
				See also Math.ulp, for calculating ulp of a float or double
				Binary floating point arithmetic is only an approximation to real arithmetic
				*/
		Thread myRunnable2Thread = new Thread(myRunnable2);
		myRunnable2Thread.start();
		MasterRunnable masterRunnable = new MasterRunnable(myRunnable2Thread, myRunnable2.getName());
		new Thread(masterRunnable).start();
		try{
			//Give it some time to kill after 5 seconds
			Thread.sleep(1000 * 6);
		} catch (InterruptedException ie) {
			System.out.println("InterruptedException while sleeping in makeMeInfinite2");
	    }
		System.out.println("makeMeInfinite2: Done");
	}

	private static class MasterRunnable implements Runnable {
	    private Thread mSlave;
	    private Date masterDate;
	    private String mSlaveName;

    	public MasterRunnable(Thread slave, String slaveName) {
        	mSlave = slave;
        	masterDate = new Date();
        	mSlaveName = slaveName;
	    }
	    
    	@Override
	    public void run() {
            while (true) {
		    	Date slaveDate = new Date();
		    	long diff = slaveDate.getTime() - masterDate.getTime();
        	    long diffSeconds = diff / 1000 % 60;
            
            	System.out.println("diffSeconds = " + diffSeconds);
	            if (mSlave.isAlive()){
    	        	if (diffSeconds >= 5){
        	    		System.out.println("Stopping slave thread " + mSlaveName);
            			mSlave.interrupt();
            			try{
	            			mSlave.join();
		            	} catch (InterruptedException ie) {
		            		System.out.println("InterruptedException while stopping slave thread " + mSlaveName);
	    	        	}
            		} else {
            			try{
            				Thread.sleep(1000);
            			} catch (InterruptedException ie) {
		            		System.out.println("InterruptedException while sleeping in MasterRunnable");
	    	        	}
            		}
	            } else {
	            	System.out.println("Slave thread is not alive. Exiting MasterRunnable");
	            	return;
	            }
            }
	    }
	}

	
	private static class MyRunnable1 implements Runnable {
	    private String mName;
	    private int mSeed;

    	public MyRunnable1(String name, int seed) {
        	mName = name;
        	mSeed = seed;
	    }
	    
	    public String getName(){return mName;}
	    
    	@Override
	    public void run() {
	    	double d = 0;
	    	for (int i = mSeed; i <= mSeed + 1; i++){
	    		if (d % 1.0e7 == 0)
		    		System.out.print("-");
		    	if (Thread.interrupted()){break;}
	    		d++;
	    	}
	    	System.out.println(" Done with " + mName + " ");
	    }
	}
	
	private static class MyRunnable2 implements Runnable {
	    private String mName;
	    private double mSeed;

    	public MyRunnable2(String name, double seed) {
        	mName = name;
        	mSeed = seed;
	    }
	    
	    public String getName(){return mName;}
	    
    	@Override
	    public void run() {
		    double i = mSeed;
		    double d = 0;
	    	while (i == i + 1){
	    		if (d % 1.0e7 == 0)
		    		System.out.print("+");
		    	if (Thread.interrupted()){break;}
	    		d++;
	    	}
	    }
	}

}