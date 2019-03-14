package com.dstrube.codeForAtlanta.electionMoney;

import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.jsoup.Jsoup;
import org.jsoup.Connection.Response;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.jsoup.nodes.FormElement;

/*

This java program scrapes the Georgia Government Transparency and Campaign Finance Commission site.

The program outputs files to the local downloads folder (not to be confused with ~/Downloads).

Using the 3rd party Jsoup for scraping, if timeouts occur due to slow internet, 
increase the JSOUP_TIMEOUT. (If it's going too slowly, feel free to decrease it, 
but be aware that 6000 seems to be the lower limit.)

Lots of debugging statements have been commented out. 
Feel free to uncomment them if you want to troubleshoot something or just know what it's doing.

Any questions? Contact the author here:
dstrube@gmail.com

Compile:
Mac:
javac -cp bin:bin/jsoup-1.11.1.jar -d bin com/dstrube/codeForAtlanta/electionMoney/Scraper.java
Windows [unverified]:
javac -cp bin;bin\jsoup-1.11.1.jar; -d bin Scraper.java

Run:
Mac:
java -cp bin:bin/jsoup-1.11.1.jar com.dstrube.codeForAtlanta.electionMoney.Scraper
Windows [unverified]:
java -cp bin;bin\jsoup-1.11.1.jar; Scraper

*/

/*
Some useful example URLs:
list page:
http://media.ethics.ga.gov/search/Campaign/Campaign_Namesearchresults.aspx?CommitteeName=&LastName=a&FirstName=&Method=0

empty candidate page:
http://media.ethics.ga.gov/search/Campaign/Campaign_Name.aspx?NameID=13093&FilerID=C2011004358&Type=candidate

non-empty candidate page:
http://media.ethics.ga.gov/search/Campaign/Campaign_Name.aspx?NameID=23979&FilerID=C2016000169&Type=candidate

*/

public class Scraper {
	private static final String URL0 = "http://media.ethics.ga.gov/search/Campaign/Campaign_Namesearchresults.aspx?CommitteeName=&LastName=";
	private static final String URL1 = "&FirstName=&Method=0";
	private static final int JSOUP_TIMEOUT = 8000;
	private static final String ALPHANUM = "abcdefghijklmnopqrstuvwxyz1234567890";
	
	public static void main(String[] args) {
		try {
			//Create the dir if it doesn't exist
			final String DIRECTORY_PATH = "./downloads/";
			final File dir = new File(DIRECTORY_PATH);
			if (!dir.exists()){
				if (!createDir(DIRECTORY_PATH)){
					return;
				}
				System.out.println("Created directory " + dir);
			}
			
			for (int i = 0; i < ALPHANUM.length(); i++){
				final File file = new File(DIRECTORY_PATH + ALPHANUM.charAt(i) + ".txt");
				if (file.exists()){
					System.out.println("File already exists: " + file + "; skipping on to next...");
					continue;
				}
				
				final String url = URL0 + ALPHANUM.charAt(i) + URL1;
				System.out.println(url);
				final Response response = Jsoup.connect(url).timeout(JSOUP_TIMEOUT).execute(); 
				final Document document = response.parse();
				if (document == null){
					System.out.println("Error: document is null.");
					return;
				}
			
				final Elements elements = document.getElementsByClass("highlightcolor");
				if (!verifyAtLeastOne(elements, "elements")){
					System.out.println("Skipping on to next...");
					continue;
				}
			
				System.out.println("Number of elements at " + ALPHANUM.charAt(i) + ": " + elements.size());
				
				if (!file.createNewFile()){
					System.out.println("Problem creating: " + file);
					return;
				}
				
				final FileOutputStream fos = new FileOutputStream(file);
				final DataOutputStream outStream = new DataOutputStream(new BufferedOutputStream(fos));
				final StringBuilder sb = new StringBuilder();
				for (final Element row : elements) {
					final String name = row.text();
					//System.out.println("Name: " + name);
					sb.append(name);
					sb.append("\n");
				}
				outStream.writeUTF(sb.toString());
				outStream.close();
				fos.close();
				
				/*
				final Element potentialForm = document.select("form#aspnetForm").first();
				if (potentialForm == null){
					System.out.println("Error: potentialForm is null.");
					return;
				}
				//https://jsoup.org/apidocs/org/jsoup/nodes/FormElement.html#submit--
				//https://stackoverflow.com/questions/31190892/how-to-fill-a-form-with-jsoup
				final FormElement form = (FormElement) potentialForm;
				final Element eventTarget = form.select("#__EVENTTARGET").first();
				final Element eventArgument = form.select("#__EVENTARGUMENT").first();
				final Element viewState = form.select("#__VIEWSTATE").first();
				final Element viewStateGenerator = form.select("#__VIEWSTATEGENERATOR").first();
				final Element eventValidation = form.select("#__EVENTVALIDATION").first();
				
				//System.out.println("viewState: " + viewState.val());

				eventTarget.val("ctl00$ContentPlaceHolder1$Search_List$ctl02$lnkViewID");
				eventArgument.val("");
				*/
				//final Document result = form.submit()/*.cookies(response.cookies())*/.post();
				//System.out.println(result.text());

				//break;
			}
			
			System.out.println("Done!"); 
			
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}
	}
	
	private static boolean verifyAtLeastOne(final Elements element, final String fieldName){
		if (element == null){
			System.out.println("Error: " + fieldName + " is null");
			return false;
	   	}
	   	if (element.size() == 0){
			System.out.println("Warning: " + fieldName + " is empty");
			return false;
		}
		return true;
	}
	
	private static boolean createDir(String path) throws IOException{
		//from https://stackoverflow.com/questions/3634853/how-to-create-a-directory-in-java
		
		//If the directory already exists, this should still return true;
		try{
			Files.createDirectories(Paths.get(path));
		} 
		catch(SecurityException se){
			System.out.println("SecurityException creating " + path);
			return false;
		}   
		return true;
	}
	
}