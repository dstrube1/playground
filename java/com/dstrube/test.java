/*
From ~/java:

javac -d bin com/dstrube/test.java
java -cp bin com.dstrube.test

*/
package com.dstrube;

import java.util.Date;
import java.util.concurrent.TimeUnit;

public class test{
	
	public static void main(String[] args){
		System.out.println("Done");
	}
	
	private static void minuteThread(){
		final Date masterDate = new Date();
		long lastMinuteCount = 0;
		while (true){
			final Date slaveDate = new Date();
			final long diff = slaveDate.getTime() - masterDate.getTime();
        	final long diffSeconds = TimeUnit.MILLISECONDS.toSeconds(diff) % 60;
        	final long diffMinutes = TimeUnit.MILLISECONDS.toMinutes(diff);
    	    final long diffHours = TimeUnit.MILLISECONDS.toHours(diff);
    	    
			if (diffMinutes == lastMinuteCount){
				System.out.println("Less than 1 minute ("+diffSeconds+" seconds) has passed; sleeping for a bit...");
			}else{
				System.out.println("1 minute has passed; total minutes: " + diffMinutes + " at " + slaveDate);
				lastMinuteCount = diffMinutes;
//				break;
			}
			try{
				Thread.sleep(10000);
			}catch(InterruptedException exception){
				System.out.println("Caught InterruptedException:" + exception);
			}
		}
	}
	
	private static void charCount(){
		String someString = "elephant";
		long count = someString.chars().filter(ch -> ch == 'e').count();
		long count2 = someString.codePoints().filter(ch -> ch == 'e').count();
		System.out.println("count = " + count + "; count2 = " + count2);
	}
	
	private static void printOdds(){
 	   for (int i=1; i<=99; i++){
    	    if (i % 2 == 1)
        	    System.out.println(i);
	    }
	}
	
	public static String replace(String str, char oldChr, char newChr) {
       if (str == null || str.length() == 0) return str;
       if (str.indexOf(oldChr) == -1) return str;
       for (int i =0; i< str.length(); i++){
           if (str.charAt(i) == oldChr){
			    String firstHalf = str.substring(0,i);
               String secondHalf = str.substring(i+1);
               str = firstHalf + newChr + secondHalf;
               }
       }
       return str;
	}
}