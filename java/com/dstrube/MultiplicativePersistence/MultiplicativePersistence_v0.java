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

public class MultiplicativePersistence {
//According to Maths.java:
//		LongMax();	//9,223,372,036,854,775,807
//Last known significant persistent (9 steps):
//							277,777,788,936,677
//Long should be good enough for now
//Update: Nope: 12:34 here:
//https://www.youtube.com/watch?v=Wim9WJeDTHQ
//"The current search has gone as far as 233 digits." -_-
	
	private static final long PER_THREAD_LIMIT = 10000000000000L;//10 TRILLION
	private static volatile boolean isAnotherThreadWritingToFile = false;
	public static void main(String[] args) {		
		final StringBuilder sb = new StringBuilder();
		sb.append("2");
		for (int i=0; i<232; i++){
			sb.append("6");
		}
		final String str = sb.toString();
		final BigInteger start = new BigInteger(str);
		
		/*
		TODO;
		handle these inevitables:
		Caught OverlappingFileLockException: java.nio.channels.OverlappingFileLockException
		Caught IOException: java.io.IOException: Stream Closed

		*/
		
		//call smartPersistence with n threads
		final long start1 = 277777788888899L;
		final MyRunnable myRunnable1 = new MyRunnable("thread1", start1); 
		final Thread myRunnable1Thread = new Thread(myRunnable1);
		myRunnable1Thread.start();

		final long start2 = start1;// + PER_THREAD_LIMIT;
		final MyRunnable myRunnable2 = new MyRunnable("thread2", start2); 
		final Thread myRunnable2Thread = new Thread(myRunnable2);
		myRunnable2Thread.start();

		final long start3 = start2 + PER_THREAD_LIMIT;
		final MyRunnable myRunnable3 = new MyRunnable("thread3", start3); 
		final Thread myRunnable3Thread = new Thread(myRunnable3);
		myRunnable3Thread.start();

		final long start4 = start3 + PER_THREAD_LIMIT;
		final MyRunnable myRunnable4 = new MyRunnable("thread4", start4); 
		final Thread myRunnable4Thread = new Thread(myRunnable4);
		myRunnable4Thread.start();

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
	
	private static void smartPersistence(final int steps, final long... candidates) throws IOException {
		long start = 0;
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
		
		if (String.valueOf(start).contains("0")){
			//System.out.print("0");
			return;
		}
		
		if (String.valueOf(start).contains("5") && containsEven(start)){
			//System.out.print("5");
			return;
		}
		
		///Maybes:
		//from about 12:00 here
		//https://www.youtube.com/watch?v=Wim9WJeDTHQ
		if (String.valueOf(start).contains("1")){
			//System.out.print("1");
			return;
		}
		
		if (String.valueOf(start).contains("2") && String.valueOf(start).contains("3")){
			//System.out.print("6");
			return;
		}
		
		if (String.valueOf(start).contains("2") && String.valueOf(start).contains("4")){
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
		
		if (String.valueOf(candidates[0]).length() == 1){
			if (steps > 10){
				//write to file when anything significant is found, starting with 277777788888899
		    	final String content = "start was " + start + "; steps = " + steps + "\n";
				writeToFile(content);
				System.out.print(content);
			}	
			return;
		}
		
		final String digits = String.valueOf(candidates[0]);
		long result = 1;
		for (int i = 0; i < digits.length(); i++){
			result *= Long.parseLong(digits.substring(i, i + 1));
		}
		smartPersistence(steps + 1, result, start);
	}
	
	private static boolean containsEven(final long candidate){
		final String candidateStr = String.valueOf(candidate);
		if (candidateStr.contains("2") ||
			candidateStr.contains("4") ||
			candidateStr.contains("6") ||
			candidateStr.contains("8")){
			return true;
		}
		return false;
	}
	
	private static boolean contains2Twos(final long candidate){
		final String candidateStr = String.valueOf(candidate);
		long count = candidateStr.chars().filter(ch -> ch == '2').count();
		if (count >= 2){
			return true;
		}
		return false;
	}
	
	private static boolean contains2Threes(final long candidate){
		final String candidateStr = String.valueOf(candidate);
		long count = candidateStr.chars().filter(ch -> ch == '3').count();
		if (count >= 2){
			return true;
		}
		return false;
	}
	
	private static boolean areDigitsAscending(final long candidate){
		final String testStr = String.valueOf(candidate);
		final String candidateStr = String.valueOf(candidate);
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
	    private long start;
	
    	public MyRunnable(final String name, final long start) {
        	this.name = name;
        	this.start = start;
        }
	    
	    public String getName(){return name;}
	    
    	@Override
	    public void run() {
	    	long limit = PER_THREAD_LIMIT;
	    	final long TEN_MIL = 10000000L;
			int progressCount = 0;
			long pos = start;
			try{
				while (limit >= 0){
					smartPersistence(0, pos);
					pos++;
					limit--;
					if (limit % TEN_MIL == 0){
						System.out.print("\r " + name + " : " + progressCount);
						progressCount++;
					}
				}
				System.out.println();	
				final String content = name + " finished searching " + start + " - " + pos;
				System.out.println(content);	
				writeToFile(content + "\n");
			}catch (IOException ioException){
				System.out.println("Caught IOException: " + ioException);
			}
	    }
	    
	}
}
















