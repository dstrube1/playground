package com.dstrube.puzzlers;

/*
commands to compile and run:
from /Users/dstrubex/Projects/java
javac -d /Users/dstrubex/Projects/java/bin com/dstrube/puzzlers/Puzzle31.java
java -cp /Users/dstrubex/Projects/java/bin com.dstrube.puzzlers.Puzzle31

*/

import java.util.Date;

public class Puzzle31{
	//Ghost of Looper
	
	public static void main(String[] args){
		System.out.println("Starting makeMeInfinite1...");
		makeMeInfinite1();
	}
	
	public static void makeMeInfinite1() {
		MyRunnable1 myRunnable1 = new MyRunnable1("makeMeInfinite1Runnable", 
			(short)-1); //Must cast as short or byte here because otherwise it thinks it's an int.
			//(byte)-1);
			//(char)-1); //Byte and short work here, but not char because it's unsigned
				/*
				This works because compound assignment can silently perform a narrowing primitive conversion.
				Narrowing primitive conversions can lose info about magnitude or precision.
				This works for any negative byte or short
				Do not use compound assignment on short, byte or char
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
	    private short mSeed;

    	public MyRunnable1(String name, short seed) {
        	mName = name;
        	mSeed = seed;
	    }
	    
	    public String getName(){return mName;}
	    
    	@Override
	    public void run() {
	    	double d = 0;
	    	short i = mSeed;
	    	while (i != 0){
	    		i >>>= 1;
	    		if (d % 1.0e7 == 0)
		    		System.out.print("-");
		    	if (Thread.interrupted()){break;}
	    		d++;
	    	}
	    	System.out.println(" Done with " + mName + " ");
	    }
	}

}