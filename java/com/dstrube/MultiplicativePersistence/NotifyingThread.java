package com.dstrube.MultiplicativePersistence;

/*
From ~/java:

Compile:
javac -d bin com/dstrube/MultiplicativePersistence/NotifyingThread.java

*/

import java.io.IOException;

import java.math.BigInteger;
//https://docs.oracle.com/javase/7/docs/api/java/math/BigInteger.html

import java.util.Date;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
//https://stackoverflow.com/questions/702415/how-to-know-if-other-threads-have-finished
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import java.util.concurrent.TimeUnit;


public class NotifyingThread extends Thread {

	    private BigInteger start;
	    private BigInteger end;
	    private BigInteger stabs = new BigInteger("0");
	    private Date masterDate;
		private long lastHourCount = 0;
		private final Set<INotifyingThreadListener> listeners = new CopyOnWriteArraySet<INotifyingThreadListener>();
		private static final AtomicReference<BigInteger> biggestFound = new AtomicReference<>(BigInteger.ZERO);
		private static final AtomicInteger maxStepsFound = new AtomicInteger(0);
		private BigInteger progress = new BigInteger("0");
		
    	public NotifyingThread(final BigInteger start, final BigInteger end) {
        	this.start = start;
        	this.end = end;
        }
	    
		public final void addListener(final INotifyingThreadListener listener) {
			listeners.add(listener);
		}
		
		public final void removeListener(final INotifyingThreadListener listener) {
			listeners.remove(listener);
		}
		
		private final void notifyListenersComplete(final boolean caughtException) {
			for (INotifyingThreadListener listener : listeners) {
				listener.notifyOfThreadComplete(this);
			}
		}
		
		private final void notifyListenersProgress(final Thread thread){
			for (INotifyingThreadListener listener : listeners) {
				listener.notifyOfThreadProgress(this);
			}
		}
		
		public BigInteger getStart(){
			return start;
		}
		
		public BigInteger getEnd(){
			return end;
		}
		
		public AtomicReference<BigInteger> getBiggestFound(){
			return biggestFound;
		}
		
		public AtomicInteger getMaxStepsFound(){
			return maxStepsFound;
		}
		
		public BigInteger getStabs(){return stabs;}
		
		public BigInteger getProgress(){return progress;}
	    
    	@Override
	    public final void run() {
	    	BigInteger count = new BigInteger("0");
	    	boolean caughtException = false;
	    	System.out.println(getName() + " - " + start.toString().substring(0,2) + " - digits: " + start.toString().length());
			try{
				BigInteger pos = start;
				while (end.compareTo(pos) > 0){
					count = count.add(BigInteger.ONE);
					final SearchResult searchResult = PersistenceSearcher.Search(0, maxStepsFound, pos);
					stabs = stabs.add(BigInteger.ONE);
					if (searchResult != null){
						if (searchResult.error == null){
							maxStepsFound.set(searchResult.maxStepsFound.get());
							biggestFound.set(searchResult.biggestFound.get());
						}else{
							System.out.println("Error encountered on " + getName() + " starting from " + start.toString() + "; error: " + searchResult.error);
							break;
						}
					}
// 					System.out.print("pos was " + pos.toString());
					pos = NumberUtil.GetNext(pos);
					if (count.mod(new BigInteger("10000")).toString().equals(BigInteger.ZERO.toString())){
						progress = pos;
						notifyListenersProgress(this);
					}
// 					System.out.println(" but now is " + pos.toString());
				}
			}catch (Exception exception){
				caughtException = true;
				System.out.println("Caught Exception: " + exception);
				exception.printStackTrace();
			} finally {
				notifyListenersComplete(caughtException);
			}

	    }
	    
	}