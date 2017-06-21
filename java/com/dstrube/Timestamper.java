/*
From ~/java:

javac -d bin com/dstrube/Timestamper.java
java -cp bin com.dstrube.Timestamper <file0> [file1...]

This program parses one or more text file inputs, and outputs a text file for each input.
The input is the initial text file from an automatically transcribed youtube video.

The input file has an expected format of
<number>
<HH:MM:SS,NNN timestamp> --> <HH:MM:SS,NNN timestamp>
text
... 

The output file (named [input]_out.txt will be as follows:
<T=S.NNN>
<HH:MM:SS,NNN timestamp> --> <HH:MM:SS,NNN timestamp>
text
... 

*/

package com.dstrube;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Timestamper {
	
	private static final String FILE_TYPE = ".txt";
	private static final String NEW_FILE_APPEND = "_out";
	private static final boolean DEBUG = false;
	private static Scanner scanner;
	private static List<String> lines;
	
	public static void main(String[] args) {
		if (args == null || args.length == 0){
			System.out.println("Input file required.");
			return;
		}
		try{

			for (int i=0; i < args.length; i++){
				System.out.println("Processing file " + args[i] + ".");
				processFile(args[i]);
			}
			System.out.println("Done.");
			
		} catch (Exception e){
			System.out.println("Exception caught: " + e);
		}

	}
	
	private static void processFile(String fileName){
		File file = new File(fileName);
		if (!file.exists()){
			System.out.println("Input file " + fileName + " doesn't exist.");
			return;
		}
		if (!file.isFile()){
			System.out.println("Input file " + fileName + " is not a file.");
			return;
		}
		if (!file.canRead()){
			System.out.println("Input file " + fileName + " can't be read.");
			return;
		}
		if (file.length() == 0){
			System.out.println("Input file " + fileName + " is empty.");
			return;
		}
		if (file.isHidden() && DEBUG){
			System.out.println("Warning: Input file " + fileName + " is hidden...");
		}
		String newFileName;
		if (!fileName.toLowerCase().endsWith(FILE_TYPE)){
			if (DEBUG) System.out.println("Warning: Input file " + fileName + " doesn't end with " + FILE_TYPE + " ...");
			newFileName = fileName + NEW_FILE_APPEND + FILE_TYPE;
		}
		else{
			int index = fileName.toLowerCase().indexOf(FILE_TYPE);
			newFileName = fileName.substring(0,index) + NEW_FILE_APPEND + FILE_TYPE;
		}
		File newFile = new File(newFileName);
		if (newFile.exists()){
			System.out.println("Output file " + newFileName + " already exists. Skipping input file " + fileName + ".");
			return;
		}
		/*
		try{
        	newFile.createNewFile();
		} catch (IOException e){
			System.out.println("Caught exception trying to create " + newFileName + ".");
			return;
		}

		if (!newFile.canWrite()){
			System.out.println("Output file " + newFileName + " can't be written.");
			return;
		}*/
		
		lines = new ArrayList<>();
        
        try{
        	scanner = new Scanner(file);
        }catch(FileNotFoundException e){
        	System.out.println("File not found by scanner.");
			return;
        }
        
		while(scanner.hasNextLine()){
			if (!processLine()) break;
		}

        Path path = Paths.get(newFileName);
		try{
	        Files.write(path, lines, Charset.forName("UTF-8"));
		} catch (IOException e){
			System.out.println("Caught exception trying to write to "+newFileName+".");
			return;
		}

	}
	
	private static boolean processLine(){
		String line0 = scanner.nextLine();
		boolean isInt = false;
		try{
			int num = Integer.parseInt(line0);
			isInt = true;
		}
		catch(Exception e){}
		if (isInt){
			if (scanner.hasNextLine()){
				String line1 = scanner.nextLine();
				//ex: 00:19:18,820 --> 00:19:19,360
				if (line1.startsWith("00:") && line1.contains("-->")){//TODO: use regex to better identify this line
					//this assumes all interviews take less than 1 hour
					int index = line1.indexOf(" -->");
					String time = line1.substring(3, index); //3 = size of "00:"
					//System.out.println("time: "+time+".");
					if (time.indexOf(":") == -1 || time.indexOf(",") == -1){
						if (DEBUG) System.out.println("Unexpected time: "+time+".");
						lines.add(line0);
						lines.add(line1);						
						return true;
					}
					int minutes = Integer.parseInt(time.substring(0, time.indexOf(":")));
					int seconds = Integer.parseInt(time.substring(time.indexOf(":")+1, time.indexOf(",")));
					int totalSeconds = (minutes * 60) + seconds;
					String milliseconds = time.substring(time.indexOf(",")+1);
					line0 = "<T=" + totalSeconds + "." + milliseconds + ">";
					lines.add(line0);
					lines.add(line1);						
				}else{
					if (DEBUG) System.out.println("Unexpected line1: "+line1+", where line0= " + line0);
					lines.add(line0);
					lines.add(line1);						
					return true;
				}
			}else{
				if (DEBUG) System.out.println("Line0 was number ("+line0+"), but line1 doesn't exist.");
				lines.add(line0);
				return false;
			}
		}
		else{
			lines.add(line0);
		}
		return true;
	}
}