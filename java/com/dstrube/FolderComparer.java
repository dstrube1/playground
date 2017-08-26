/*
From ~/java:

javac -d bin com/dstrube/FolderComparer.java
java -cp bin com.dstrube.FolderComparer

Phase 1 failed here:
dir1List.length (11) != dir2List.length (14)
dir1 = /Users/dstrube/Downloads/sort/AnimationsDemo/AnimationsDemo; 
dir2 = /Users/dstrube/Downloads/sort/AnimationsDemo/AnimationsDemo2

next, compare contents (phase 2) here:
/Users/dstrube/Downloads/sort/AnimationsDemo/AnimationsDemo/src/com/example/android/animationsdemo
/Users/dstrube/Downloads/sort/AnimationsDemo/AnimationsDemo2/app/src/main/java/com/dstrube/animationsdemo/app
*/

package com.dstrube;

import java.io.File;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.FileInputStream;
import java.util.Scanner;

public class FolderComparer{
	public static void main(String[] args){
		try{
			File file = new File("/Users/dstrube/Downloads/sort/AnimationsDemo");
			//File dir1 = new File(file.getCanonicalPath()+"/AnimationsDemo");
			//File dir2 = new File(file.getCanonicalPath()+"/AnimationsDemo2");
			File dir1 = new File(file.getCanonicalPath()+"/AnimationsDemo/src/com/example/android/animationsdemo");
			File dir2 = new File(file.getCanonicalPath()+"/AnimationsDemo2/app/src/main/java/com/dstrube/animationsdemo/app");
			
			if (phase1(dir1,dir2)){
				System.out.println("Phase 1 passed, proceeding to phase 2...");
			} else {
				System.out.println("Phase 1 failed.");
				return;
			}
	
			if (phase2(dir1,dir2)){
				System.out.println("Phase 2 passed.");
			} else {
				System.out.println("Phase 2 failed.");
				return;
			}
			
//        	System.out.println("file CanonicalPath: "+file.getCanonicalPath());
//        	System.out.println("files listed: ");
//    	    for (File f : file.listFiles()){
//        	    System.out.println(f.getCanonicalPath());
//	        }
	    } catch (IOException ioe){
	    	System.out.println("IOException");
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
				System.out.println("dir1 doesn't exist: "+dir1.getCanonicalPath());
				return false;
			}
			if (!dir2.exists()){
				System.out.println("dir2 doesn't exist: "+dir2.getCanonicalPath());
				return false;
			}
			
			//if dir1 and dir2 have different numbers of items, they're not equal
			File[] dir1List = dir1.listFiles();
			File[] dir2List = dir2.listFiles();
			if (dir1List.length != dir2List.length)
			{
				System.out.println("dir1List.length ("+dir1List.length+") != dir2List.length ("+dir2List.length+")");
				System.out.println("dir1 = "+dir1.getCanonicalPath()+"; dir2 = "+dir2.getCanonicalPath());
				return false;
			}
	    } catch (IOException ioe){
	    	System.out.println("IOException");
	    	return false;
	    }
		return true;
	}
	
	//Basic checks for For loops in both phase 1 & 2
	private static boolean baseForChecks(File dir1, File dir2){
		try{
			//dir1 is a folder AND dir2 is NOT a folder
			if (dir1.isDirectory() && !dir2.isDirectory()){
				System.out.println("dir1.isDirectory("+dir1.getCanonicalPath()+") & NOT dir2.isDirectory("+dir2.getCanonicalPath()+")");
				return false;
			}

			//dir1 is NOT a folder AND dir2 is a folder
			if (! dir1.isDirectory() && dir2.isDirectory()){
				System.out.println("NOT dir1.isDirectory("+dir1.getCanonicalPath()+") & dir2.isDirectory("+dir2.getCanonicalPath()+")");
				return false;
			}

			//dir1 name != dir2 name
			if (!dir1.getName().equals(dir2.getName())){
				System.out.println("dir1 name ("+dir1.getName()+") != dir2 name ("+dir2.getName()+")");
				return false;
			}
	    } catch (IOException ioe){
	    	System.out.println("IOException");
	    	return false;
	    }
		return true;
	}	
	
	//Verify the folder structure is the same
	private static boolean phase1(File dir1, File dir2){
		//try{
			
			if (!baseChecks(dir1, dir2)){
				System.out.println("Failed phase 1 base check.");
		    	return false;
			}
			
			File[] dir1List = dir1.listFiles();
			File[] dir2List = dir2.listFiles();

			for (int i=0; i<dir1List.length; i++){
				if(!baseForChecks(dir1List[i], dir2List[i])){
					System.out.println("Failed phase 1 base For check.");
			    	return false;
				}
				
				//recurse
				if (dir1List[i].isDirectory() && dir2List[i].isDirectory()){
					return phase1(dir1List[i], dir2List[i]);
				}
			}//end for

	    /*} catch (IOException ioe){
	    	System.out.println("IOException");
	    	return false;
	    }*/
		return true;
	}

	//Verify the file contents are the same
	private static boolean phase2(File dir1, File dir2){
		try{
			
			if (!baseChecks(dir1, dir2)){
				System.out.println("Failed phase 2 base check.");
		    	return false;
			}
			
			File[] dir1List = dir1.listFiles();
			File[] dir2List = dir2.listFiles();
			
			for (int i=0; i<dir1List.length; i++){
				if(!baseForChecks(dir1List[i], dir2List[i])){
					System.out.println("Failed phase 2 base For check.");
			    	return false;
				}
				
				//recurse
				if (dir1List[i].isDirectory() && dir2List[i].isDirectory()){
					return phase2(dir1List[i], dir2List[i]);
				}
				
				//Now we're dealing with 2 files
				FileInputStream fileInputStream1 = new FileInputStream(dir1List[i]);
				FileInputStream fileInputStream2 = new FileInputStream(dir2List[i]);
				
				Scanner scanner1 = new Scanner(fileInputStream1);
				Scanner scanner2 = new Scanner(fileInputStream2);
				while(areScannersGood(scanner1, scanner2)){
					String line1 = scanner1.next();
					String line2 = scanner2.next();
					if (! line1.equals(line2)){
						System.out.println("Failed phase 2: at files \n"+
						dir1List[i].getCanonicalPath() + " \nand \n" + dir2List[i].getCanonicalPath()+
						"\nthese lines don't match: file1: \n"+
						line1 +" \nfile2: \n"+ line2);
						return false;
					}
				}
				
			}

	    } catch (FileNotFoundException fnfe){
	    	System.out.println("FileNotFoundException");
	    	return false;
	    } catch (IOException ioe){
	    	System.out.println("IOException");
	    	return false;
	    }
		return true;
	}
	
	private static boolean areScannersGood(Scanner scanner1, Scanner scanner2){
		if (!scanner1.hasNext() && scanner2.hasNext()){
			System.out.println("Scanner 1 NOT has next AND scanner 2 has next.");
	    	return false;
		}
		if (scanner1.hasNext() && !scanner2.hasNext()){
			System.out.println("Scanner 1 NOT has next AND scanner 2 has next.");
	    	return false;
		}
		if (!scanner1.hasNext() && !scanner2.hasNext()){
	    	return true;
		}

		return true;

	}
}