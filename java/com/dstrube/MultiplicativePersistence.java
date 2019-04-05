/*
#Author: David Strube
#Date: 2019-03-22

From multiplicativePersistence.py:
#According to this:
#https://www.youtube.com/watch?v=Wim9WJeDTHQ
#There is a conjecture that 11 is the limit

#Dumb brute force
#from 4:10 here:
#https://www.youtube.com/watch?v=E4mrC39sEOQ

#A little smarter
#from 10:47 here:
#https://www.youtube.com/watch?v=Wim9WJeDTHQ
#1- Leave out anything with a 5
#2- keep track of what's been tested; compare what is being tested to what has been tested; if digits (regardless of order) match, skip it
3- what else? - Leave out anything with a 0

What does MultiplicativePersistence.java do differently?
Slight improvements over multiplicativePersistence.py:
1- multithreaded - theoretically searches about 4 times faster
2- writes to file when something is found, so I don't have to keep an eye on the terminal
3- instead of storing checked values and comparing them to currently being tested value (CBTV), just check to see if CBTV has digits in ascending order

From ~/java:

Compile:
javac -d bin com/dstrube/MultiplicativePersistence.java
Run:
java -cp bin com.dstrube.MultiplicativePersistence

*/

package com.dstrube;

import java.io.IOException;
import java.io.RandomAccessFile;
//https://docs.oracle.com/javase/7/docs/api/java/io/RandomAccessFile.html

import java.math.BigInteger;
//https://docs.oracle.com/javase/7/docs/api/java/math/BigInteger.html

import java.nio.channels.FileLock;
//https://docs.oracle.com/javase/7/docs/api/java/nio/channels/FileLock.html
import java.nio.channels.FileChannel;
//https://docs.oracle.com/javase/7/docs/api/java/nio/channels/FileChannel.html
import java.nio.channels.OverlappingFileLockException;
//https://docs.oracle.com/javase/7/docs/api/java/nio/channels/OverlappingFileLockException.html

import java.util.Arrays;
import java.util.Date;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.ConcurrentHashMap;

public class MultiplicativePersistence {
//According to Maths.java:
//		LongMax();	//9,223,372,036,854,775,807
//Last known significant persistent (11 steps):
//							277,777,788,888,899
//Long should be good enough for now
//Update: Nope: 12:34 here:
//https://www.youtube.com/watch?v=Wim9WJeDTHQ
//"The current search has gone as far as 233 digits." -_-
	
	private static final long PER_THREAD_LIMIT_MULTIPLIER = 10000000000L;//10 BILLION
	private static final BigInteger PER_THREAD_LIMIT = new BigInteger(String.valueOf(PER_THREAD_LIMIT_MULTIPLIER));
	private static volatile boolean isAnotherThreadWritingToFile = false;
	private static final ConcurrentHashMap<String,String> threadStatuses = new ConcurrentHashMap<>();
	
	public static void main(String[] args) {
		//2019-03-25:
		//Starting with 2 followed by 232 6s
		final StringBuilder sb = new StringBuilder();
		sb.append("2");
		for (int i = 0; i < 232; i++){
			sb.append("6");
		}
		final String str = sb.toString();
		final BigInteger start = new BigInteger(str);
		//System.out.println(str);
		
		final int processors = Runtime.getRuntime().availableProcessors();
		//After completed runs, add 4 to this for each new run
		//2019-03-25 = 0
		//2019-03-?? = 4
		final int nextRunThreadLimitModifier = 0;
		for(int i = (0 + nextRunThreadLimitModifier); i < (processors + nextRunThreadLimitModifier); i++) {
			//call smartPersistence with n threads
			final long multiplier = PER_THREAD_LIMIT_MULTIPLIER * i;
			final BigInteger addend = new BigInteger(String.valueOf(multiplier));
			final BigInteger startN = start.add(addend);
			final MyRunnable myRunnableN = new MyRunnable("thread"+(i - nextRunThreadLimitModifier), startN); 
			final Thread myRunnableThreadN = new Thread(myRunnableN);
			myRunnableThreadN.start();		
		}
	}
	
	private static void writeToFile(final String content) throws IOException{
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
	
	private static void smartPersistence(final int steps, final BigInteger... candidates) throws IOException {
		BigInteger start = BigInteger.ZERO;
		//Java not having default parameters makes this a little messier than Python
		if (candidates == null){
			System.out.println("Error: candidates must not be null");
			return;
		}
		
		if (candidates.length == 0){
			System.out.println("Error: candidates must not be empty");
			return;
		}
		
		if (candidates.length > 2){
			System.out.println("Error: candidates should not be more than 2 elements");
			return;
		}
		
		if (candidates.length == 1){
			start = candidates[0];
		}else{
			start = candidates[1];
		}
		
		if (start.toString().contains("0")){
			//System.out.print("0");
			return;
		}
		
		if (start.toString().contains("5") && containsEven(start)){
			//System.out.print("5");
			return;
		}
		
		///Maybes:
		//from about 12:00 here
		//https://www.youtube.com/watch?v=Wim9WJeDTHQ
		if (start.toString().contains("1")){
			//System.out.print("1");
			return;
		}
		
		if (start.toString().contains("2") && start.toString().contains("3")){
			//System.out.print("6");
			return;
		}
		
		if (start.toString().contains("2") && start.toString().contains("4")){
			//System.out.print("8");
			return;
		}
		
		if (contains2Twos(start)){
			//System.out.print("4");
			return;
		}
		
		if (contains2Threes(start)){
			//System.out.print("9");
			return;
		}
		
		//Never more than 1 four? why?
		
		///END Maybes
		
		if (!areDigitsAscending(start)){
			//System.out.print("D");
			return;
		}
		
		if (candidates[0].toString().length() == 1){
			if (steps > 10){
				//write to file when anything significant is found
		    	final String content = "start was " + start + "; \nsteps = " + steps + "\n";
				writeToFile(content);
				System.out.print(content);
			}	
			return;
		}
		
		final String digits = candidates[0].toString();
		BigInteger result = BigInteger.ONE;
		for (int i = 0; i < digits.length(); i++){
			result = result.multiply(new BigInteger(digits.substring(i, i + 1)));
		}
		smartPersistence(steps + 1, result, start);
	}
	
	private static boolean containsEven(final BigInteger candidate){
		final String candidateStr = candidate.toString();
		if (candidateStr.contains("2") ||
			candidateStr.contains("4") ||
			candidateStr.contains("6") ||
			candidateStr.contains("8")){
			return true;
		}
		return false;
	}
	
	private static boolean contains2Twos(final BigInteger candidate){
		final String candidateStr = candidate.toString();
		long count = candidateStr.chars().filter(ch -> ch == '2').count();
		if (count >= 2){
			return true;
		}
		return false;
	}
	
	private static boolean contains2Threes(final BigInteger candidate){
		final String candidateStr = candidate.toString();
		long count = candidateStr.chars().filter(ch -> ch == '3').count();
		if (count >= 2){
			return true;
		}
		return false;
	}
	
	private static boolean areDigitsAscending(final BigInteger candidate){
		final String testStr = candidate.toString();
		final String candidateStr = candidate.toString();
		final char[] chars0 = testStr.toCharArray();
		final char[] chars1 = candidateStr.toCharArray();
        Arrays.sort(chars0);
        final String sorted = new String(chars0);
        final String unsorted = new String(chars1);
        if (sorted.equals(unsorted)){
        	//System.out.println(candidate + " digits are ascending");
        	return true;
        }
        //System.out.println(candidate + " digits are NOT ascending");
        return false;
	}
	
	private static class MyRunnable implements Runnable {
	    private String name;
	    private BigInteger start;
	    private Date masterDate;
		private long lastHourCount = 0;
	
    	public MyRunnable(final String name, final BigInteger start) {
        	this.name = name;
        	this.start = start;
        	if (name.equals("thread0")){
	        	masterDate = new Date();
        	}
        }
	    
	    public String getName(){return name;}
	    
    	@Override
	    public void run() {
	    	BigInteger limit = PER_THREAD_LIMIT;
	    	final BigInteger PROGRESS_MOD = new BigInteger("100000");//100K
			int progressCount = 0;
			BigInteger pos = start;
			System.out.println("Starting " + name);// + "; searching from " + start.toString());
			try{
				while (limit.compareTo(BigInteger.ZERO) >= 0){
					smartPersistence(0, pos);
					pos = pos.add(BigInteger.ONE);
					limit = limit.subtract(BigInteger.ONE);
					final BigInteger mod = limit.mod(PROGRESS_MOD);
					if (mod.compareTo(BigInteger.ZERO) == 0){
						final String status = "" + progressCount + " / " + limit.toString();
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
						progressCount++;
						if (name.equals("thread0")){
							final Date slaveDate = new Date();
							final long diff = slaveDate.getTime() - masterDate.getTime();
							final long diffHours = TimeUnit.MILLISECONDS.toHours(diff);
							if (diffHours != lastHourCount){
								System.out.println("\n"+diffHours + " hours have passed, as of " + slaveDate);
								lastHourCount = diffHours;
							}
						}
					}
				}
				System.out.println();	
				final String content = name + " finished searching \n" + start + "\n - \n" + pos;
				System.out.println(content);	
				writeToFile(content + "\n");
			}catch (IOException ioException){
				System.out.println("Caught IOException: " + ioException);
			}
	    }
	    
	}
}













