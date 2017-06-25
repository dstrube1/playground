package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle33.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle33

*/

import java.util.Date;

public class Puzzle33{
	//Looper Meets the Wolfman
	
	public static void main(String[] args){
		System.out.println("Integer.toHexString(Integer.MIN_VALUE) = " + Integer.toHexString(Integer.MIN_VALUE));
		System.out.println("Integer.toHexString(-1) = " + Integer.toHexString(-1));
		System.out.println("Starting makeMeInfinite1...");
		makeMeInfinite1();
	}
	
	public static void makeMeInfinite1() {
		MyRunnable1 myRunnable1 = new MyRunnable1("makeMeInfinite1Runnable", 
			Integer.MIN_VALUE);
	    	/*
	    	Integer.MIN_VALUE is its own negation.
	    	Same is true for Long.MIN_VALUE
	    	Two's-complement arithmetic: To negate a value, flip every bit and add 1
	    	0
	    	-1 int in binary:	0xffffffff
	    	flip the bits:		0x00000000
	    	+1:					0x00000001
	    	
	    	8 in binary: 1000
	    	7 in binary: 0111
	    	
	    	Integer.MIN_VALUE:  0x80000000
	    	flip the bits: 	    0x7fffffff
	    	+1 = 				0x80000000
	    	
	    	NOTE: Typo found on page 72: says Integer.MIN_VALUE = 
	    	0x8000000, it's actually
	    	0x80000000
	    	sent email to puzzlers@javapuzzlers.com on 2015-09-11 from dstrube@gmail.com
	    	
	    	*/
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
	    private int mSeed1;

    	public MyRunnable1(String name, int seed1) {
        	mName = name;
        	mSeed1 = seed1;
	    }
	    
	    public String getName(){return mName;}
	    
    	@Override
	    public void run() {
	    	double d = 0;
	    	int i = mSeed1;
	    	while (i == -i && i != 0){
	    		if (d % 1.0e7 == 0)
		    		System.out.print("-");
		    	if (Thread.interrupted()){break;}
	    		d++;
	    	}
	    	System.out.println(" Done with " + mName + " ");
	    }
	}

}