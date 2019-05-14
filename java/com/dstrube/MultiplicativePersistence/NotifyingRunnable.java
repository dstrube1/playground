package com.dstrube.MultiplicativePersistence;

/*
From ~/java:

Compile:
javac -d bin com/dstrube/MultiplicativePersistence/NotifyingRunnable.java

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


public class NotifyingRunnable implements Runnable {

	    private String name;
	    private BigInteger start;
	    private BigInteger end;
	    private Date masterDate;
		private long lastHourCount = 0;
		private final Set<IRunnableCompleteListener> listeners = new CopyOnWriteArraySet<IRunnableCompleteListener>();
		private static final AtomicReference<BigInteger> biggestFound = new AtomicReference<>(BigInteger.ZERO);
		private static final AtomicInteger maxStepsFound = new AtomicInteger(0);
	
    	public NotifyingRunnable(final String name, final BigInteger start, final BigInteger end) {
        	this.name = name;
        	this.start = start;
        	this.end = end;
        	if (name.equals("thread0")){
	        	masterDate = new Date();
        	}
        }
	    
		public final void addListener(final IRunnableCompleteListener listener) {
			listeners.add(listener);
		}
		
		public final void removeListener(final IRunnableCompleteListener listener) {
			listeners.remove(listener);
		}
		
		private final void notifyListeners(boolean caughtException) {
			for (IRunnableCompleteListener listener : listeners) {
				listener.notifyOfRunnableComplete(this);
			}
		}
		
		public String getName(){
			return name;
		}
		
		public BigInteger getStart(){
			return start;
		}
		
		public AtomicReference<BigInteger> getBiggestFound(){
			return biggestFound;
		}
		
		public AtomicInteger getMaxStepsFound(){
			return maxStepsFound;
		}
	    
    	@Override
	    public void run() {
	    	boolean caughtException = false;
			try{
		    	//final long PROGRESS_MOD = 10000L;//100
				//long progressCount = 0L;
				BigInteger pos = start;
				System.out.println(name + "; start: " + start.toString());
				while (end.compareTo(pos) > 0){
					//System.out.println('\r' + name + " tested " + pos.toString());
					final SearchResult searchResult = PersistenceSearcher.Search(0, maxStepsFound, pos);
					if (searchResult != null){
						if (searchResult.error == null){
							maxStepsFound.set(searchResult.maxStepsFound.get());
							biggestFound.set(searchResult.biggestFound.get());
						}else{
							System.out.println("Error encountered on " + name + " starting from " + start.toString() + "; error: " + searchResult.error);
							break;
						}
					}
					pos = NumberUtil.GetNext(pos);
					/*progressCount++;
					if (progressCount % PROGRESS_MOD == 0){
						final String status = "" + progressCount + ": checking " + pos;
						if (!threadStatuses.containsKey(name)){
							threadStatuses.put(name, status);
						}else{
							threadStatuses.replace(name, status);
						}
						final StringBuilder threadStatus = new StringBuilder();
						final Set<String> keys = threadStatuses.keySet();
						for (final String key : keys){
							threadStatus.append(key);
							threadStatus.append(":");
							threadStatus.append(threadStatuses.get(key));
							threadStatus.append("; ");
						} 
						System.out.print("\r " + threadStatus.toString());// + "; testing " + pos);
						if (name.equals("thread0")){
							final Date slaveDate = new Date();
							final long diff = slaveDate.getTime() - masterDate.getTime();
							final long diffHours = TimeUnit.MILLISECONDS.toHours(diff);
							if (diffHours != lastHourCount){
								System.out.println("\n"+diffHours + " hours have passed, as of " + slaveDate);
								lastHourCount = diffHours;
							}
						}
					}*/
				}
				//System.out.println();	
				//final String content = name + " finished searching \n" + start + "\n - \n" + pos;
				//System.out.println(content);	
				//writeToFile(content + "\n");
			}catch (IOException ioException){
				caughtException = true;
				//System.out.println("Caught IOException: " + ioException);
			}catch (Exception exception){
				caughtException = true;
				System.out.println("Caught Exception: " + exception);//);//getStackTrace().toString());
				exception.printStackTrace();
			} finally {
				notifyListeners(caughtException);
			}

	    }
	    
	}