/*
Author: David Strube
Date: 2019-03-02

Compile:
javac -cp bin:bin/junit-4.12.jar -d bin tests/Question1UnitTests.java
Run:
java -cp bin:bin/junit-4.12.jar com.dstrube.gtri.Question1UnitTests

These are the unit tests for a console application that:

 - Accepts as an argument the name of a file containing a newline-delimited
   list of integers.

 - Prints "true" if the file contains any two integers that sum to zero.

*/

package com.dstrube.gtri;

import java.io.File;

import junit.framework.TestCase;

public class Question1UnitTests extends TestCase
{
	
	public static void main(String[] args)
	{
	    System.out.println("Testing isFileOK...");
		testIsFileOK();

	    System.out.println("\nTesting populateList...");
		testPopulateList();

	    System.out.println("\nTesting findZeroSum...");
		testFindZeroSum();
	}
	
	public static void testIsFileOK()
	{
	    try
	    {
			boolean result = false;

		    result = Question1.isFileOK(null);
			assertEquals("Method isFileOK tested with null.", result, false);

		    result = Question1.isFileOK("");
			assertEquals("Method isFileOK tested with blank.", result, false);

		    result = Question1.isFileOK(".");
			assertEquals("Method isFileOK tested with folder.", result, false);

		    result = Question1.isFileOK("files/empty.txt");
			assertEquals("Method isFileOK tested with empty file.", result, false);

		    result = Question1.isFileOK("files/invalid1.txt");
			assertEquals("Method isFileOK tested with valid file with invalid content.", result, true);

		    result = Question1.isFileOK("files/x1.txt");
			assertEquals("Method isFileOK tested with valid file with valid content.", result, true);
	    }
	    catch(Exception exception)
	    {
		    System.out.println("Caught exception: " + exception);
	    }
	}
	
	public static void testPopulateList()
	{
	    try
	    {
			boolean result = false;

		    result = Question1.populateList(null);
			assertEquals("Method populateList tested with null.", result, false);

		    File file = new File("files/invalid1.txt");

		    result = Question1.populateList(file);
			assertEquals("Method populateList tested with invalid file.", result, false);

			file = new File("files/x1.txt");
		    result = Question1.populateList(file);
			assertEquals("Method populateList tested with valid file.", result, true);

	    }
	    catch(Exception exception)
	    {
		    System.out.println("Caught exception: " + exception);
	    }
	}
	
	public static void testFindZeroSum()
	{
		try
		{
			boolean result = false;
			
		    File file = new File("files/x1.txt");
		    Question1.populateList(file);
		    result = Question1.findZeroSum(); 
			assertEquals("Method findZeroSum tested with file x1.txt.", result, false);

		    file = new File("files/x2.txt");
		    Question1.populateList(file);
		    result = Question1.findZeroSum(); 
			assertEquals("Method findZeroSum tested with file x2.txt.", result, true);
		    
		    file = new File("files/x3.txt");
		    Question1.populateList(file);
		    result = Question1.findZeroSum();
			assertEquals("Method findZeroSum tested with file x3.txt.", result, true);

		    file = new File("files/x4.txt");
		    Question1.populateList(file);
		    result = Question1.findZeroSum(); 
			assertEquals("Method findZeroSum tested with file x4.txt.", result, false);
	    }
	    catch(Exception exception)
	    {
		    System.out.println("Caught exception: " + exception);
	    }
	}
}