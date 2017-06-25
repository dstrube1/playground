package com.dstrube;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
//import java.util.ArrayList;


public class FilesComparer {

	public static final String folder1 = "C:\\Users\\david.strube\\Desktop\\temp\\app01\\";
	public static final String folder2 = "C:\\Users\\david.strube\\Desktop\\temp\\app02\\";
	
	public static void main(String[] args) {
		File myFolder1 = new File(folder1);
		File myFolder2 = new File(folder2);
		String[] files1 = myFolder1.list();
		String[] files2 = myFolder2.list();
		for (int i=0; i < files1.length ; i++){
			System.out.println("Comparing: "+files1[i] + " & " +files2[i]);
			readAndCompare(files1[i],files2[i]);
		}
	}
	
	public static void readAndCompare(String f1, String f2){
		File file1 = new File(folder1+f1);
		File file2 = new File(folder2+f2);
		FileReader fr1 = null;
		FileReader fr2 = null;
		BufferedReader br1 = null;
		BufferedReader br2 = null;
		String input1 = "";
		String input2 = "";
		
		if (!file1.canRead() || !file2.canRead()){
			System.out.println("File 1 or 2 is unreadable");
			return;
		}
		
		//System.out.println("setting file reader.");
		try { 
			fr1 = new FileReader(file1);
		}catch (FileNotFoundException e){
			System.out.println("error setting file reader: "+e.getMessage());
			return;
		}
		try { 
			fr2 = new FileReader(file2);
		}catch (FileNotFoundException e){
			System.out.println("error setting file reader: "+e.getMessage());
			return;
		}
		
		//System.out.println("setting buffered reader");
		br1 = new BufferedReader(fr1);
		br2 = new BufferedReader(fr2);
		
		try{
			while ((input1 = br1.readLine()) != null){
				input2 = br2.readLine();
				if (! input1.equals(input2)){
					System.out.println("Mismatch found comparing "+file1.getAbsolutePath() + " to "+file2.getAbsolutePath());
				}
			}
			br1.close();
			br2.close();
			fr1.close();
			fr2.close();
			fr1 = new FileReader(file1);
			fr2 = new FileReader(file2);

			br1 = new BufferedReader(fr1);
			br2 = new BufferedReader(fr2);
			
			while ((input2 = br2.readLine()) != null){
				input1 = br1.readLine();
				if (! input1.equals(input2)){
					System.out.println("Mismatch found comparing "+file2.getAbsolutePath() + " to "+file1.getAbsolutePath());
				}
			}
			br1.close();
			br2.close();
			
			fr1.close();
			fr2.close();
		} catch (IOException e){
			System.out.println("error while comparing: " + e.getMessage());
			return;
		}
	}

}
