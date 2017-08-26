package com.dstrube.iOSCleaner;
/*
commands to compile and run:

on Windows:
from ~\Documents\java
	javac -d .\bin com\dstrube\iOSCleaner\iOSCleaner.java
	java -cp .\bin com.dstrube.iOSCleaner.iOSCleaner
	
on Mac:
from ~/Projects/java
	javac -d ~/Projects/java/bin com/dstrube/iOSCleaner/iOSCleaner.java
	java -cp ~/Projects/java/bin com.dstrube.iOSCleaner.iOSCleaner
*/
import java.io.File;

public class iOSCleaner{
    public static void main(String[] args)
    {
        try{
            //DONE: test windows dir print out before deleting
			//DONE: test deletes in a temp dir 
            //C:\\Users\\N95607\\Desktop\\temp\\...
            searchDir("C:\\Users\\N95607\\Documents\\Projects\\Communicator\\iOS");
			//"/Users/admin/Projects/iOS"); 
			//
        }
        catch (Exception e){
            System.out.println("Exception: " + e);
        }
		System.out.println("Done");
    }
    
    private static void searchDir(String dir){
        File file = new File(dir);
        File[] files = file.listFiles();
        for (int i=0; i < files.length; i++){
            if (files[i].isDirectory()){
                searchDir(files[i].toString());
            }
            else if (files[i].getName().equals(".DS_Store") || files[i].getName().equals("._.DS_Store") ){
                System.out.println("Deleting " + files[i]);
                try{
	                if (files[i].delete()){
	                	System.out.println("Deleted.");
	                }
    	            else{
    	            	System.out.println("Unable to delete " + files[i]);
    	            }
                } catch(SecurityException e){
        	        System.out.println("SecurityException thrown trying to delete " + files[i]);
                }
            }
        }
    }
}
