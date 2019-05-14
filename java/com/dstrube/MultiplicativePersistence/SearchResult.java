package com.dstrube.MultiplicativePersistence;

/*
From ~/java:

Compile:
javac -d bin com/dstrube/MultiplicativePersistence/SearchResult.java

*/

import java.math.BigInteger;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

public class SearchResult{
	public AtomicReference<BigInteger> biggestFound;
	public AtomicInteger maxStepsFound;
	public String error;
	public SearchResult(){
		biggestFound = new AtomicReference<>(BigInteger.ZERO); 
		maxStepsFound = new AtomicInteger(0);
		error = null;
	}
}