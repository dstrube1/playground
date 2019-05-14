package com.dstrube.MultiplicativePersistence;

/*
From ~/java:

Compile:
javac -d bin com/dstrube/MultiplicativePersistence/ThreadManager.java

*/

import java.io.IOException;
import java.io.RandomAccessFile;
//https://docs.oracle.com/javase/7/docs/api/java/io/RandomAccessFile.html

import java.nio.channels.FileLock;
//https://docs.oracle.com/javase/7/docs/api/java/nio/channels/FileLock.html
import java.nio.channels.FileChannel;
//https://docs.oracle.com/javase/7/docs/api/java/nio/channels/FileChannel.html
import java.nio.channels.OverlappingFileLockException;
//https://docs.oracle.com/javase/7/docs/api/java/nio/channels/OverlappingFileLockException.html

import java.math.BigInteger;
//https://docs.oracle.com/javase/7/docs/api/java/math/BigInteger.html
import java.math.BigDecimal;
import java.math.RoundingMode;//MathContext;

import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import java.util.concurrent.ConcurrentHashMap;
//https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ConcurrentHashMap.html
import java.util.Random;
//https://docs.oracle.com/javase/8/docs/api/java/util/Random.html
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicReferenceArray;
//https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/atomic/AtomicReferenceArray.html

public class ThreadManager implements INotifyingThreadListener{
	private static ThreadManager instance = null;
	private AtomicInteger numOfTrailingDigits = null;
	private  AtomicInteger limitTrailingDigits = null;
	private int processors = 0;
	private ConcurrentHashMap<String,String> startingTemplates = null;
	private final ConcurrentHashMap<String,String> currentAvailableThreadPoolTemplates = new ConcurrentHashMap<>();
	private final Random random = new Random();
	private int indexLimit = 0;
	
	private final AtomicReference<BigInteger> biggestFound = new AtomicReference<>(BigInteger.ZERO);
	private final AtomicInteger maxStepsFound = new AtomicInteger(0);
	private static volatile boolean isAnotherThreadNotifying = false;
	private static volatile boolean isAnotherThreadNotifyingProgress = false;
	private static volatile boolean isAnotherThreadWritingToFile = false;
	private final Set<IThreadManagerListener> listeners = new CopyOnWriteArraySet<IThreadManagerListener>();
	private AtomicReferenceArray<NotifyingThread> activeThreads = null;
	//Useful for debugging:
// 	private final AtomicReference<String> lockedBy = new AtomicReference<>("");
	//private static final ConcurrentHashMap<String,String> threadStatuses = new ConcurrentHashMap<>();
	
	public static ThreadManager getInstance(){
		if (instance == null){
			instance = new ThreadManager();
		}
		return instance;
	}
	
	private ThreadManager(){}
	
	public void setProcessors(final int num){
		processors = num;
	}
	
	public void setTrailingDigits(final int num, final int limit){
		numOfTrailingDigits = new AtomicInteger(num);
		limitTrailingDigits = new AtomicInteger(limit);
	}
	
	public void setStartingTemplates(final ConcurrentHashMap<String,String> starting){
		startingTemplates = starting;
	}
	
	public void doStuff(){
		if (numOfTrailingDigits == null){
			System.out.println("Null numOfTrailingDigits");
			return;
		}
		
		if (limitTrailingDigits == null){
			System.out.println("Null limitTrailingDigits");
			return;
		}
		
		if (startingTemplates == null){
			System.out.println("Null startingTemplates");
			return;
		}
		
		if (processors == 0){
			System.out.println("Invalid processor count");
			return;
		}
		
		final Set<String> keys = startingTemplates.keySet();
		for (final String key : keys){
			currentAvailableThreadPoolTemplates.put(key, startingTemplates.get(key));
		} 

		final String[] keysArray = keys.toArray(new String[0]);
		if (keysArray.length >= processors){
			indexLimit = processors;
		}
		else{
			indexLimit = keysArray.length;
		}
		
		activeThreads = new AtomicReferenceArray<>(indexLimit);
		for(int i = 0; i < indexLimit; i++) {
			//System.out.println("i: " + i);
			final BigInteger start = new BigInteger(keysArray[i]);			
			final BigInteger end = new BigInteger(currentAvailableThreadPoolTemplates.get(keysArray[i]));
			currentAvailableThreadPoolTemplates.remove(keysArray[i]);
			
			/*
			final NotifyingRunnable myRunnable = new NotifyingRunnable("thread"+i, start, end); 
			myRunnable.addListener(this);
			final Thread myRunnableThread = new Thread(myRunnable);
			//System.out.println("start " + myRunnable.getName() + " from\n" + start + "\n to \n" + end);			
			myRunnableThread.start();		*/
			final NotifyingThread notifyingThread = new NotifyingThread(start, end); 
			notifyingThread.setName("thread"+i);
			notifyingThread.addListener(this);
// 			currentRunningThreads.set(i, notifyingThread);
			activeThreads.set(i, notifyingThread);
			notifyingThread.start();
// 			final String threadName = notifyingThread.getName();
// 			final BigInteger oldStart = notifyingThread.getStart();
// 			System.out.println(threadName + " - " + oldStart.toString());
		}
	}
	
	public int getIndexLimit(){
		return indexLimit;
	}
	
	public void setListener(IThreadManagerListener listener){
		listeners.add(listener);
	}
	
	public void notifyOfThreadProgress(final Thread thread){
		final int sleep = 100 + random.nextInt(900);
		try{
			while (isAnotherThreadNotifyingProgress){
				thread.sleep(sleep);
			}
		}catch(InterruptedException interruptedException){
			System.out.println("Caught InterruptedException: " + interruptedException);
		}
		isAnotherThreadNotifyingProgress = true;
		
		final NotifyingThread notifyingThread = (NotifyingThread) thread;
		for (IThreadManagerListener listener : listeners) {
			listener.notifyOfThreadManagerProgress(notifyingThread);
		}
		
		isAnotherThreadNotifyingProgress = false;
	}
	
	public void notifyOfThreadComplete(final Thread thread){
		try{
			final int sleep = 100 + random.nextInt(900);
			if (isAnotherThreadNotifying){
// 				System.out.println(thread.getName() + " is waiting, locked out by " + lockedBy.get() + "; sleeping for " + sleep);
			}
			while (isAnotherThreadNotifying){
				thread.sleep(sleep);
			}
		}catch(InterruptedException interruptedException){
			System.out.println("Caught InterruptedException: " + interruptedException);
		}
		isAnotherThreadNotifying = true;
// 		System.out.println(thread.getName() + " is proceeding and locking...");
// 		lockedBy.set(thread.getName());

		NotifyingThread notifyingThread = (NotifyingThread) thread;

		for (IThreadManagerListener listener : listeners) {
			listener.notifyOfThreadComplete(notifyingThread);
		}
		
		notifyingThread.removeListener(this);
		final String threadName = notifyingThread.getName();
		final BigInteger oldStart = notifyingThread.getStart();
		//System.out.println(threadName + " - " + oldStart.toString() + " X - digits: " + numOfTrailingDigits + "; stabs: " + notifyingThread.getStabs().toString());

		final AtomicInteger tempMaxStepsFound = notifyingThread.getMaxStepsFound();
		if (tempMaxStepsFound.get() > maxStepsFound.get()){
			biggestFound.set(notifyingThread.getBiggestFound().get());
			maxStepsFound.set(tempMaxStepsFound.get());
			final String content = "Greater max steps found by " + threadName + ": " + maxStepsFound.get() + "; value: " + biggestFound.get().toString();
			System.out.println(content);
			//Note, from 11:15 here:
			//https://www.youtube.com/watch?v=Wim9WJeDTHQ
			//These threads don't always give the most accurate calculations where steps <= 10; but it always guesses 11 correctly
			if (maxStepsFound.get() > 11){
				try{
					writeToFile(content + "\n");
		 		}catch(final IOException exception){
 					System.out.println("Caught IOException: " + exception);
 				}
			}
		}
		
		//when creating a new thread, do so by removing a key from the currentAvailableThreadPoolTemplates until it's empty, 
		//then refill it from startingTemplates, tacking on the last digit
		if (currentAvailableThreadPoolTemplates.isEmpty()){
// 			System.out.println(threadName + " - currentAvailableThreadPoolTemplates.isEmpty");
			final Set<String> startingKeys = startingTemplates.keySet();
			for (final String key : startingKeys){
				String newKey = key;
				//TODO Use StringBuilder
				for (int i = 0; i < numOfTrailingDigits.get(); i++){
					newKey += key.substring(1);
				}
				
				if (currentAvailableThreadPoolTemplates.containsKey(newKey)){
					System.out.println("Warning: new key (" + newKey + ") found in currentAvailableThreadPoolTemplates");
					break;
				}
				String newValue = startingTemplates.get(key);
				//TODO Use StringBuilder
				for (int i = 0; i < numOfTrailingDigits.get(); i++){
					newValue += startingTemplates.get(key).substring(1);
				}
				currentAvailableThreadPoolTemplates.put(newKey, newValue);
				if (newKey.contains("33") || newValue.contains("33")){
					System.err.println("Invalid newKey ("+newKey+") or newValue ("+newValue+") at " + threadName + "; numOfTrailingDigits: " + numOfTrailingDigits);
					return;
				}
			} 
			numOfTrailingDigits.getAndIncrement();
			if (maxStepsFound.get() > 10){
				System.out.println("numOfTrailingDigits: " + numOfTrailingDigits);
			}
		}
			
// 		System.out.println(threadName + " - currentAvailableThreadPoolTemplates.size(): " + currentAvailableThreadPoolTemplates.size());
		final Set<String> currentKeys = currentAvailableThreadPoolTemplates.keySet();
		for (final String key : currentKeys){
			if (key == null || key.length() == 0){
				System.out.println("Invalid key at " + threadName + "; numOfTrailingDigits: " + numOfTrailingDigits);
				//Some other thread may have taken this key up while this thread was trying to; skip it and try again
				continue;
			}		
			final BigInteger start = new BigInteger(key);
			if (currentAvailableThreadPoolTemplates.get(key) == null || currentAvailableThreadPoolTemplates.get(key).length() == 0){
				System.out.println("Invalid currentAvailableThreadPoolTemplates.get("+key+") at " + threadName + "; numOfTrailingDigits: " + numOfTrailingDigits);
				//Some other thread may have taken this key up while this thread was trying to; skip it and try again
				continue;
			}
			final BigInteger end = new BigInteger(currentAvailableThreadPoolTemplates.get(key));
				
			currentAvailableThreadPoolTemplates.remove(key);
			notifyingThread = new NotifyingThread(start, end); 
			//System.out.println(threadName + " : " + start.toString() + " - " + end.toString());
			notifyingThread.setName(threadName);
			notifyingThread.addListener(this);
			notifyingThread.start();

			break;
		} 
			
		isAnotherThreadNotifying = false;
// 		System.out.println("lock released by " + lockedBy.get());
	}
	
	private void writeToFile(final String content) throws IOException{
		while (isAnotherThreadWritingToFile){}
		
		//Different ways of writing to a file (and reasons)
		//https://www.baeldung.com/java-write-to-file
		
		//if locking isn't good enough for multithreaded writing, maybe use this:
		//https://docs.oracle.com/javase/7/docs/api/java/nio/channels/AsynchronousFileChannel.html
		
	    isAnotherThreadWritingToFile = true;
		final String fileName = "MultiplicativePersistenceFind.txt";
		RandomAccessFile stream = null;
	    FileChannel channel = null;
 		try{
 			stream = new RandomAccessFile(fileName, "rw");
			//rwd may be needed in the future:
			//https://docs.oracle.com/javase/7/docs/api/java/io/RandomAccessFile.html#mode
 			channel = stream.getChannel();
	    	FileLock lock = null;
    		try {
	    	    lock = channel.tryLock();
	    	} catch (final OverlappingFileLockException exception) {
				System.out.println("Caught OverlappingFileLockException: " + exception);
        		stream.close();
        		channel.close();
		    }
    		final long length = stream.length();
    		stream.seek(length);
    		stream.writeBytes(content);
    		
    		lock.release();
 		}catch(final IOException exception){
 			System.out.println("Caught IOException: " + exception);
 		}finally{
			try {
				if (stream != null) {
					stream.close();
				}
			} finally {
				if (channel != null) {
					channel.close();
				}
			}
			isAnotherThreadWritingToFile = false;
		} 
	}
}








