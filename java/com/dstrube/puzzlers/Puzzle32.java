package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle32.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle32

*/

import java.util.Date;

public class Puzzle32{
	//Curse of Looper
	
	public static void main(String[] args){
		System.out.println("Starting makeMeInfinite1...");
		makeMeInfinite1();
	}
	
	public static void makeMeInfinite1() {
		MyRunnable1 myRunnable1 = new MyRunnable1("makeMeInfinite1Runnable", 
			0,0);
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
	    private int mSeed2;

    	public MyRunnable1(String name, int seed1, int seed2) {
        	mName = name;
        	mSeed1 = seed1;
        	mSeed2 = seed2;
	    }
	    
	    public String getName(){return mName;}
	    
    	@Override
	    public void run() {
	    	double d = 0;
	    	Integer i = new Integer(mSeed1);
	    	Integer j = new Integer(mSeed2);
	    	/*
	    	Java's <= operator used to be antisymmetric before 5.0, but no more
	    	(What about other comparisons?)
	    	Pre 5.0: Operands must be primitives
	    	Post 5.0: Operands must be convertible to primitives; 
	    	autoboxing and auto-unboxing
	    	Boxed numeric types: Byte, Character, Short, Int, Long, Float, Double;
	    	<= is not antisymmetric on these types because equality operators (== & !=) 
	    	perform reference identity comparison rather than value comparison
	    	identity comparison between two objects which are not from the same object = not equal
	    	
	    	*/
	    	while (i <= j && j <= i && i != j){
	    		if (d % 1.0e7 == 0)
		    		System.out.print("-");
		    	if (Thread.interrupted()){break;}
	    		d++;
	    	}
	    	System.out.println(" Done with " + mName + " ");
	    }
	}

}