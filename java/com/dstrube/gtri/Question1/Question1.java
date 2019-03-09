/*
Author: David Strube
Date: 2019-03-02

Compile:
javac -d bin com/dstrube/gtri/Question1/Question1.java
Run:
java -cp bin com.dstrube.gtri.Question1 [file]

This is a console application that:

 - Accepts as an argument the name of a file containing a newline-delimited
   list of integers.

 - Prints "true" if the file contains any two integers that sum to zero.

*/

package com.dstrube.gtri;

import java.io.File;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.FileInputStream;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Question1
{
	private static List<Integer> _list = null;

	public static void main(String[] args)
	{
		if (args.length == 0)
		{
			System.out.println("Empty args");
			return;
		}
		
		try
		{
			if (!isFileOK(args[0]))
			{
				return;
			}
			
			final File file = new File(args[0]);
			if (!populateList(file))
			{
				return;
			}
			
			System.out.println(findZeroSum());

		} 
		catch (FileNotFoundException fileNotFoundException)
		{
			System.out.println("File not found: " + args[0]);
		} 
		catch (IOException ioException)
		{
	    	System.out.println("IOException caught: " + ioException);
	    } 
	    catch (Exception exception)
	    {
	    	System.out.println("Exception caught: " + exception);
	    }
	    //System.out.println("Done.");
	}
	
	//This method returns false if the file doesn't exist, is a folder, isn't readable, or is empty.
	//Else returns true
	public static boolean isFileOK(final String path) throws IOException
	{
		if (path == null)
		{
			System.out.println("Null file path");
			return false;
		}
		if (path.length() == 0)
		{
			System.out.println("Empty file path");
			return false;
		}
		final File file = new File(path);
		if (!file.exists())
		{
			System.out.println("File does not exist: " + file);
			return false;
		}
			
		if (!file.isFile())
		{
			System.out.println("This is not a file: " + file);
			return false;
		}
			
		if (!file.canRead())
		{
			System.out.println("Cannot read file: " + file);
			return false;
		}
		
		final FileInputStream fileInputStream = new FileInputStream(file);
		final Scanner scanner = new Scanner(fileInputStream);
		
		try
		{		
			if (!scanner.hasNextLine())
			{
				System.out.println("Empty file: " + file);
				return false;
			}
			//File is OK
			return true;
		}
		finally
		{
			//Debug statement to confirm that the scanner and fileInputStream are closed 
			//regardless of return value
			//System.out.println("Finally");
			
			scanner.close();
			fileInputStream.close();
		}
	}
	
	//This method populates a list of integers, returns false if an error is encountered along the way.
	public static boolean populateList(final File file) throws IOException
	{
		if (file == null)
		{
			System.out.println("Null file");
			return false;
		}
		final FileInputStream fileInputStream = new FileInputStream(file);
		final Scanner scanner = new Scanner(fileInputStream);
		String line = "";
		
		try
		{
			_list = new ArrayList<>();
			while(scanner.hasNextLine())
			{
				line = scanner.nextLine();
				//System.out.println("Line: " + line);
				final int i = Integer.parseInt(line);
				//System.out.println("Number: " + i);
				_list.add(i);
			}
			return true;
		} 
		catch (NumberFormatException numberFormatException)
		{
			//Possible improvement: ignore empty lines
	    	System.out.println("Invalid input: caught NumberFormatException at line " + line);
	    	return false;
		}
		finally
		{
			scanner.close();
			fileInputStream.close();
		}
	}
	
	//This method returns true if the list of integers contains any two integers that sum to zero.
	//Else returns false
	public static boolean findZeroSum()
	{
		if (_list == null)
		{
			System.out.println("List is null");
			return false;
		}
		if (_list.size() == 0)
		{
			System.out.println("Empty list");
			return false;
		}
		if (_list.size() == 1)
		{
			System.out.println("List has only 1 element");
			return false;
		}
		
		for (int i = 0; i < _list.size() - 1; i++)
		{
			for (int j = i + 1; j < _list.size(); j++)
			{
				final int sum = _list.get(i) + _list.get(j);
				//System.out.println("sum = " + _list.get(i) + " + " + _list.get(j) + " = " + sum);
				
				//One possible optimization is to keep track of sums already tested, 
				//in case the file has duplicate numbers
				if (sum == 0)
				{
					return true;
				}
				//Interestingly, this handles arithmetic overflow correctly:
				//Int.MAX (2147483647) + Int.MAX = -2
				//(Int.MAX) + (Int.MAX - 1) = -3
				//(Int.MAX) + (Int.MAX + 1) = NumberFormatException
			}
			
		}
		return false;
	}
}