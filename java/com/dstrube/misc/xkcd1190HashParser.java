package com.dstrube;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class xkcd1190HashParser {

	public static final String IN_FILE="C:\\Users\\david.strube\\Desktop\\in.txt";

	public static void main(String[] args) {
		File f = new File(IN_FILE);
		String input = "";
		FileReader fr = null;
		BufferedReader br = null;
		StringBuilder sb = new StringBuilder();
		ArrayList<String> rows = new ArrayList<String>();
		if (!f.canRead()){
			System.out.println("File is unreadable");
			return;
		}

		try { 
			fr = new FileReader(f);
		}catch (FileNotFoundException e){
			System.out.println("error setting file reader: "+e.getMessage());
			return;
		}
		//System.out.println("setting buffered reader");
		br = new BufferedReader(fr);
		
		try{
			while ((input = br.readLine()) != null){
				if (! input.contains(":")){
					rows.add(input);
					continue;
				}
				rows.add(parsed(input));
			}
			br.close();
			fr.close();
		} catch (IOException e){
			System.out.println(e.getMessage());
			return;
		}
		
		for (int i=0; i< rows.size(); i++){
			System.out.println(rows.get(i));
		}

	}

	private static String parsed(String input) {
		int lastTab = input.lastIndexOf('\t');
		
		if (lastTab==-1){return "error on "+input;}
		
		input = input.substring(lastTab+1);
		return input;
	}

}
