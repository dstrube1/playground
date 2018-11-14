package com.dstrube;

/*
commands to compile and run:

from mac ~/java:
compile:
javac -cp bin:bin/jsoup-1.11.1.jar -d bin com/dstrube/DeliciousScraper.java
run:
java -cp bin:bin/jsoup-1.11.1.jar com.dstrube.DeliciousScraper

*/

import java.io.IOException;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import org.jsoup.Jsoup;
import org.jsoup.nodes.*;
import org.jsoup.select.Elements;
//http://jsoup.org/cookbook/extracting-data/attributes-text-html

public class DeliciousScraper {

	private static final String PAGE_ROOT = "https://del.icio.us/";
	private static final String DEFAULT_USER="trending";
	private static final String PAGE_SUFFIX = "?&page=";
	private static final String DEFAULT_OUTPUT_PATH = "./deliciousOut.txt";
	private static final List<String> lines = new ArrayList<>();
	private static String user;
	private static int pageNum = 1;
	private static String outputPath;
		
	
	public static void main(String[] args) {
		//Get user param
		if (args.length > 0){
			//Ex: ...DeliciousScraper myUser
			user = args[0];
		}
		else{
			user = DEFAULT_USER;
		}
		
		//Get output path param
		if (args.length > 1){
			//Ex: ...DeliciousScraper myUser ./blah.txt
			outputPath = args[1];
		}
		else{
			outputPath = DEFAULT_OUTPUT_PATH;
		}
		final Path file = Paths.get(outputPath);
		if (Files.exists(file)){
			System.out.println("WARNING: File already exists: " + outputPath);
			System.out.println("Do you want to overwrite? (y/n)");
			final Scanner input = new Scanner(System.in);
			final String answer = input.next().toLowerCase();
			if (!answer.equals("y")){
				System.out.println("I didn't get a 'y', so I'll let you sort this out before proceeding.");
				return;
			}
		}
		
		//Get start page number param
		if (args.length > 2){
			//Ex: ...DeliciousScraper myUser ./blah.txt 624
			try{
				int temp = Integer.parseInt(args[2]);
				if (temp > 0){
					pageNum = temp;
				}
				else{
					System.out.println("Invalid page number: " + temp + "; using default: " + pageNum);
				}
			}
			catch(NumberFormatException e){
				System.out.println("Invalid page number: " + args[2] + "; using default: " + pageNum);
			}
		}
		
		String page = PAGE_ROOT + user + PAGE_SUFFIX + pageNum;
		System.out.println("Going to " + page + "...");
		
		//Get the data
		while (parsePage(page) ){
			pageNum++;
			page = PAGE_ROOT + user + PAGE_SUFFIX + pageNum;
			//If you want to stop after the first page, uncomment this:
			//break;
		}
		
		//Write data to file
		try{
			Files.write(file, lines, Charset.forName("UTF-8"));
		}
		catch(IOException e){
			System.out.println("\nCaught exception: " + e);		
		}
		
		System.out.println("\nDone");		
	}

	private static boolean parsePage(String page){
		try{
			Document doc = Jsoup.connect(page).get();
			
			if (pageNum % 100 == 0){
				System.out.println(pageNum);
			}
			else{
				System.out.print(".");
			}
			//System.out.print(page+"; ");
			//System.out.println("doc.title: " + doc.title());
			//Element el = doc.body();
			//System.out.println("el.html = " + el.html());
			Elements divElements = doc.getElementsByClass("articleThumbBlock");
			if (!verifyAtLeastOne(divElements, "bookmarks")){
				return false;
			}
			for(Element divElement : divElements){
				Elements titleElements = divElement.getElementsByClass("articleTitlePan");
				if (!verifyAtLeastOne(titleElements, "title")){
					return false;
				}
				//System.out.println("Title: " + titleElements.text());
				lines.add(titleElements.text());
				
				Elements infoElements = divElement.getElementsByClass("articleInfoPan");
				if (!verifyAtLeastOne(infoElements, "info")){
					return false;
				}
				
				Elements aTags = divElement.getElementsByTag("a");
				if (!verifyAtLeastOne(aTags, "url")){
					return false;
				}
				int i = 0;
				for(Element aTag : aTags){
					if (i == 0){
						//ignore
						i++;
						continue;
					}
					else if (i == 1){
						//System.out.println("URL: " + aTag.text());
						lines.add(aTag.attr("href"));
						break;
					}
				}
				
				Elements notes = divElement.getElementsByClass("thumbTBriefTxt");
				if (!verifyAtLeastOne(notes, "note")){
					return false;
				}
				//System.out.println("Notes / tags: " + notes.text());
				lines.add(notes.text());
				
			} 
		}
		catch (IOException e){
			System.out.println("\nstopping here: " + page + " because " + e.toString());
			return false;
		}
		return true;
	}
	
	private static boolean verifyAtLeastOne(final Elements element, final String fieldName){
		if (element == null){
			System.out.println("\nError: element '" + fieldName + "' is null at page " + pageNum);
			return false;
	   	}
	   	if (element.size() == 0){
			System.out.println("\nElement '" + fieldName + "' is empty at page " + pageNum + ". This may be the end of the line.");
			return false;
		}
		return true;
	}
}
