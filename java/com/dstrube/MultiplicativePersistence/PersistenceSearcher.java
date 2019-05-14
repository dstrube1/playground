package com.dstrube.MultiplicativePersistence;

/*
From ~/java:

Compile:
javac -d bin com/dstrube/MultiplicativePersistence/PersistenceSearcher.java

*/

import java.io.IOException;
import java.math.BigInteger;
import java.util.concurrent.atomic.AtomicInteger;

public class PersistenceSearcher{
	public static SearchResult Search(final int steps, final AtomicInteger maxStepsFound, final BigInteger... candidates) throws IOException {
		BigInteger start = BigInteger.ZERO;
		//Java not having default parameters makes this a little messier than Python
		if (candidates == null){
			System.out.println("Error: candidates must not be null");
			return null;
		}
		
		if (candidates.length == 0){
			System.out.println("Error: candidates must not be empty");
			return null;
		}
		
		if (candidates.length > 2){
			System.out.println("Error: candidates should not be more than 2 elements");
			return null;
		}
		
		if (candidates.length == 1){
			start = candidates[0];
		}else{
			start = candidates[1];
		}
		
		if (!NumberUtil.IsAllGood(start).equals("G")){
			// final String goodResult = NumberUtil.IsAllGood(start);
// 			if (goodResult.equals("9")){
// 				final SearchResult searchResult = new SearchResult();
// 				searchResult.error = "9";
// 				return searchResult;
// 			}else{
				return null;
// 			}
		}
		
		if (candidates[0].toString().length() == 1){
			if (steps > maxStepsFound.get()){
		    	//final String content = "start was " + start + "; \nsteps = " + steps + "\n";
				//write to file when anything significant is found
				//writeToFile(content);
				//System.out.print(content);
				final SearchResult searchResult = new SearchResult();
				//TODO: confirm this works as expected:
				//https://stackoverflow.com/questions/32577311/is-biginteger-thread-safe
				searchResult.biggestFound.set(new BigInteger(start.toString()));
				searchResult.maxStepsFound.set(steps);
				return searchResult;
			}	
			return null;
		}
		
		final String digits = candidates[0].toString();
		BigInteger result = BigInteger.ONE;
		for (int i = 0; i < digits.length(); i++){
			result = result.multiply(new BigInteger(digits.substring(i, i + 1)));
		}
		return Search(steps + 1, maxStepsFound, result, start);
	}
}