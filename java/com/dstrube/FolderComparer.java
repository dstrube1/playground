/*
From ~/java:

javac -d bin com/dstrube/FolderComparer.java
java -cp bin com.dstrube.FolderComparer

This compares two folders, first comparing the file counts, then the file contents.
*/

package com.dstrube;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.FileInputStream;
import java.util.Scanner;

public class FolderComparer{

	private static FilenameFilter fileNameFilter;
	private static final String[] ignoreFolders = {"/obj/","/bin","/.vs/"};
	private static final String[] ignoreFiles = {".DS_Store",".csproj",".vs"};//TODO: this doesn't seem to really work
	private static int dirCount = 0;
	private static int progressCount = 0;

	public static void main(String[] args){
		if (args.length == 0){
			System.out.println("Empty args");
			return;
		}
		if (args.length == 1){
			System.out.println("Not enough args");
			return;
		}
		if (args.length > 2){
			System.out.println("Too many args");
			return;
		}
		try{
			File dir1 = new File(args[0]);
			File dir2 = new File(args[1]);
			
			//from https://www.tutorialspoint.com/java/io/file_listfiles_filename_filter.htm
			fileNameFilter = new FilenameFilter() {
   
            	@Override
	            public boolean accept(File dir, String name) {
	            	if (dir.isDirectory()){
	            		for (String ignoreFolder : ignoreFolders) {
	            			if (dir.getPath().contains(ignoreFolder)){
	            				return false;
	            			}
	            		}
	            		return true;
	            	}
    	           if(name.lastIndexOf('.') > 0) {
		            	for (String ignoreFile : ignoreFiles) {
		            		if(name.endsWith(ignoreFile)){
	    	        			return false;
	        	    		}
	            			//else{
	            			//Can't print from within FilenameFilter :(
	            			//System.out.println("dir.getPath() " + dir.getPath() + "NOT endsWith(ignoreFile) " + ignoreFile);
	            			//}
		            	}
               
        	          // get last index for '.' char
            	      int lastIndex = name.lastIndexOf('.');
                  
                	  // get extension
	                  String str = name.substring(lastIndex);
                  
    	              // match path name extension
        	          if(str.equals(".cs")) {
            	         return true;
	                  }
    	           }
               
        	       return false;
	            }
    	     };
			//end fileNameFilter
			
			if (phase1(dir1,dir2)){
				System.out.println("Phase 1 passed, proceeding to phase 2...");
			} else {
				//System.out.println("Phase 1 failed.");
				return;
			}
			
			getDirCount(dir1);
	
			if (phase2(dir1,dir2)){
				System.out.println("Phase 2 passed.");
				//System.out.println("dirCount =? " + dirCount);//332?
			} else {
				//System.out.println("Phase 2 failed.");
				return;
			}
			
	    } catch (Exception exception){
	    	System.out.println("Exception caught at " + methodName() + ": " + exception);
	    }
	}
	
	//Basic checks for both phase 1 & 2
	private static boolean baseChecks(File dir1, File dir2){
		if (null == dir1){
			System.out.println("dir1 is null");
			return false;
		}
		
		if (null == dir2){
			System.out.println("dir2 is null");
			return false;
		}
		
		try{
			if (!dir1.exists()){
				System.out.println("dir1 doesn't exist: " + dir1);
				return false;
			}
			if (!dir2.exists()){
				System.out.println("dir2 doesn't exist: " + dir2);
				return false;
			}
			
			//if dir1 and dir2 have different numbers of items, they're not equal
			File[] dir1List = dir1.listFiles(fileNameFilter);
			File[] dir2List = dir2.listFiles(fileNameFilter);
			if (dir1List.length != dir2List.length)
			{
				System.out.println("Failed base check");
				System.out.println("dir1List.length (" + dir1List.length + ") != dir2List.length (" + dir2List.length + ")");
				System.out.println("dir1 = " + dir1 
					+ "\ndir2 = " + dir2);
				System.out.println("dir1 contents:");
				for (File file : dir1List)
				{
					System.out.println("-" + file);
				}
				System.out.println("dir2 contents:");
				for (File file : dir2List)
				{
					System.out.println("-" + file);
				}
				
				return false;
			}
	    } catch (Exception exception){
	    	System.out.println("Exception caught at " + methodName() + ": " + exception);
	    	return false;
	    }
		return true;
	}
	
	//Basic checks for For loops in both phase 1 & 2
	private static boolean baseForChecks(File dir1, File dir2){
		try{
			//dir1 is a folder AND dir2 is NOT a folder
			if (dir1.isDirectory() && !dir2.isDirectory()){
				System.out.println("dir1.isDirectory(" + dir1 + ") & NOT dir2.isDirectory(" + dir2 + ")");
				return false;
			}

			//dir1 is NOT a folder AND dir2 is a folder
			if (!dir1.isDirectory() && dir2.isDirectory()){
				System.out.println("NOT dir1.isDirectory(" + dir1 + ") & dir2.isDirectory(" + dir2 + ")");
				return false;
			}
			
			//both not folders - skip
			if (! dir1.isDirectory() && !dir2.isDirectory()){
				return true;
			}
			//dir1 name != dir2 name
			if (!dir1.getName().equals(dir2.getName())){
				System.out.println("dir1 name (" + dir1.getName() + ") != dir2 name (" + dir2.getName() + ")");
				return false;
			}
	    } catch (Exception exception){
	    	System.out.println("Exception caught at " + methodName() + ": " + exception);
	    	return false;
	    }
		return true;
	}	
	
	//Verify the folder structure is the same
	private static boolean phase1(File dir1, File dir2){
		if (!baseChecks(dir1, dir2)){
	    	return false;
		}
			
		File[] dir1List = dir1.listFiles(fileNameFilter);
		File[] dir2List = dir2.listFiles(fileNameFilter);

		for (int i = 0; i < dir1List.length; i++){
			if(!baseForChecks(dir1List[i], dir2List[i])){
				System.out.println("Failed phase 1 base For check.");
		    	return false;
			}
				
			//recurse
			if (dir1List[i].isDirectory() && dir2List[i].isDirectory()){
				if (phase1(dir1List[i], dir2List[i])){
					continue;
				} else{
					return false;
				}
			}
		}//end for

		return true;
	}
	
	private static void getDirCount(File dir){
		dirCount++;
		File[] dirList = dir.listFiles(fileNameFilter);
		for (File dir0 : dirList){
			if (dir0.isDirectory()){
				getDirCount(dir0);
			}
		}
	}

	//Verify the file contents are the same
	private static boolean phase2(File dir1, File dir2){
		try{
			
			if (!baseChecks(dir1, dir2)){
				System.out.println("Failed phase 2 base check.");
		    	return false;
			}
			
			File[] dir1List = dir1.listFiles(fileNameFilter);
			File[] dir2List = dir2.listFiles(fileNameFilter);
			
			for (int i = 0; i < dir1List.length; i++){
				if(!baseForChecks(dir1List[i], dir2List[i])){
					System.out.println("Failed phase 2 base For check.");
			    	return false;
				}
				
				//recurse
				if (dir1List[i].isDirectory() && dir2List[i].isDirectory()){
					//System.out.println("Comparing " + dir1List[i] + " & " + dir2List[i]);
					//System.out.print(".");
					progressCount++;
					double percentDone = ((1.0 * progressCount) / dirCount) * 100;
					System.out.println(String.format("%.1f", percentDone) + "% done");
					if (!phase2(dir1List[i], dir2List[i])){
						return false;
					}
				}
				
				//One of these is a dir; skip
				if (dir1List[i].isDirectory() || dir2List[i].isDirectory()){
					continue;
				}
				
				//Now we're dealing with 2 files
				FileInputStream fileInputStream1 = new FileInputStream(dir1List[i]);
				FileInputStream fileInputStream2 = new FileInputStream(dir2List[i]);

				Scanner scanner1 = new Scanner(fileInputStream1);
				Scanner scanner2 = new Scanner(fileInputStream2);
				long lineNumber = 1;
				while(areScannersGood(scanner1, scanner2)){
					String line1 = scanner1.nextLine();
					String line2 = scanner2.nextLine();

					if (! line1.equals(line2)){
						System.out.println("Failed phase 2: at these files \n" 
							+ "1: " + dir1List[i] + "\n"
							+ "2: " + dir2List[i] 
							+ "\nLines (#" + lineNumber + ") don't match: \n" 
							+ "1: " + line1 + "\n"
							+ "2: " + line2);
						return false;
					}
					lineNumber++;
				}//end while
				scanner1.close();
				scanner2.close();
			}//end for

	    } catch (FileNotFoundException fnfe){
	    	System.out.println("FileNotFoundException");
	    	return false;
	    } 
		return true;
	}
	
	private static boolean areScannersGood(Scanner scanner1, Scanner scanner2){
		if (!scanner1.hasNextLine() && scanner2.hasNextLine()){
			System.out.println("Scanner 1 NOT has next AND scanner 2 has next.");
	    	return false;
		}
		if (scanner1.hasNextLine() && !scanner2.hasNextLine()){
			System.out.println("Scanner 1 has next AND scanner 2 NOT has next.");
	    	return false;
		}
		if (!scanner1.hasNextLine() && !scanner2.hasNextLine()){
	    	return false;
		}

		return true;

	}
	
	private static String methodName() {
		//https://www.baeldung.com/java-name-of-executing-method
	    String methodName = 
    	  Thread.currentThread()
    	  .getStackTrace()[2]//0 = "getStackTrace"; 1 = "methodName"; 2 = calling method
    	  .getMethodName();
        return methodName;
	}
}