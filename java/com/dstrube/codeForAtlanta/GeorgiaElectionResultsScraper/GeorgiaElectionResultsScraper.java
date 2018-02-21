import java.io.IOException;
import java.io.InputStream;
import java.io.FileOutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.jsoup.Jsoup;
import org.jsoup.Connection.Response;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/*

This java program scrapes the GeorgiaElectionResults site for files.

The program outputs downloaded files to the local downloads folder (not to be confused with ~/Downloads).

TODO: If the file already exists before running the program, user is prompted for 
whether they want to overwrite the file.

Using the 3rd party Jsoup for scraping, if timeouts occur due to slow internet, 
increase the JSOUP_TIMEOUT. (If it's going too slowly, feel free to decrease it, 
but be aware that 6000 seems to be the lower limit.)

Lots of debugging statements have been commented out. 
Feel free to uncomment them if you want to troubleshoot something or just know what it's doing.

Any questions? Contact the author here:
dstrube@gmail.com

Compile:
Mac:
javac -cp bin:bin/jsoup-1.11.1.jar -d bin GeorgiaElectionResultsScraper.java
Windows [unverified]:
javac -cp bin;bin\jsoup-1.11.1.jar; -d bin GeorgiaElectionResultsScraper.java

Run:
Mac:
java -cp bin:bin/jsoup-1.11.1.jar GeorgiaElectionResultsScraper
Windows [unverified]:
java -cp bin;bin\jsoup-1.11.1.jar; GeorgiaElectionResultsScraper

*/

/*
Some useful example URLs:
http://results.enr.clarityelections.com/GA/Appling/63993/183625/en/summary.html
http://results.enr.clarityelections.com/GA/Atkinson/63994/182984/en/summary.html

http://results.enr.clarityelections.com/GA/63991/184321/en/select-county.html

http://results.enr.clarityelections.com/GA/Appling/63993/index.html
->
http://results.enr.clarityelections.com/GA/Appling/63993/183625/en/summary.html

http://results.enr.clarityelections.com/GA/Appling/63993/183625/reports/summary.zip
detailxls.zip
detailtxt.zip
detailxml.zip
*/



public class GeorgiaElectionResultsScraper {
	private static final String URL0 = "http://results.enr.clarityelections.com/GA";
	private static final String URL1 = "/63991/184321/en/select-county.html";
	private static final int JSOUP_TIMEOUT = 8000;
	
	public static void main(String[] args) {
		//Get the counties
		Elements countyElements;
		try {
			final Response countiesResponse = Jsoup.connect(URL0 + URL1).timeout(JSOUP_TIMEOUT).execute(); 
			//anything less than 6000 times out for me during normal network conditions; 
			//8000 is safer during heavy traffic

			final Document countiesDocument = countiesResponse.parse();

			if (countiesDocument == null){
				System.out.println("Error: countiesDocument is null.");
				return;
			}
			
			countyElements = countiesDocument.getElementsByTag("li");
			if (!verifyAtLeastOne(countyElements, "counties")){
				return;
			}
			
			System.out.println("Number of counties: " + countyElements.size());
			
			final String valueHeader = " value=\"";
			final String valueFooter = " href=";
			
			for (final Element countyRow : countyElements) {
				//System.out.println("row: " + countyRow.text() + "; value: " + countyRow.html());
				
				final String countyName = countyRow.text();
				
				int beginOfValue = countyRow.html().indexOf(valueHeader);
				if (beginOfValue == -1){
					System.out.println("Error: begin of value not found for " + countyName + ". Skipping on to the next...");
					continue;
				}
				beginOfValue += valueHeader.length();
				final int endOfValue = countyRow.html().indexOf(valueFooter) - 1;
				if (endOfValue == -1){
					System.out.println("Error: end of value not found for " + countyName + ". Skipping on to the next...");
					continue;
				}
				
				final String value = countyRow.html().substring(beginOfValue, endOfValue);
				
				//System.out.println("value = " + value);
				//Ex: /Appling/63993/index.html
				//This is the first half of the actual download page URL
				
				final Response countyResponse0 = Jsoup.connect(URL0 + value).timeout(JSOUP_TIMEOUT).execute(); 
				final Document countyDocument0 = countyResponse0.parse();
				if (countyDocument0 == null){
					System.out.println("Error: countyDocument0 is null for " + countyName + ". Skipping on to the next...");
					continue;
				}
				//System.out.println("html: " + countyDocument0.toString());
				final String scriptSrcHeader = "<script src=\".";
				final String scriptSrcFooter = "/js/version.js";
				int beginOfScriptSrc = countyDocument0.toString().indexOf(scriptSrcHeader);
				if (beginOfScriptSrc == -1){
					System.out.println("Error: begin of scriptSrc not found for " + countyName + ". Skipping on to the next...");
					continue;
				}
				beginOfScriptSrc += scriptSrcHeader.length();
				final int endOfScriptSrc = countyDocument0.toString().indexOf(scriptSrcFooter);
				if (endOfScriptSrc == -1){
					System.out.println("Error: end of scriptSrc not found for " + countyName + ". Skipping on to the next...");
					continue;
				}
				
				final String scriptSrc = countyDocument0.toString().substring(beginOfScriptSrc, endOfScriptSrc);
				//System.out.println("scriptSrc: " + scriptSrc);
				//Ex: /183625
				//This is the second half of the actual download page URL
				
				//final String summaryHtml = "/en/summary.html";
				//final String countyUrl = URL0 + value.substring(0, value.indexOf("/index.html")) + scriptSrc + summaryHtml;
				//System.out.println("countyUrl: " + countyUrl);
				//Ex: http://results.enr.clarityelections.com/GA/Appling/63993/183625/en/summary.html
				//This is the full page with all the download links, but it is not exactly the download urls
				
				/*final Response countyResponse1 = Jsoup.connect(countyUrl).timeout(JSOUP_TIMEOUT).execute(); 
				final Document countyDocument1 = countyResponse1.parse();
				if (countyDocument1 == null){
					System.out.println("Error: document is null.");	
					return;
				}
				//System.out.println("countyUrl html: " + countyDocument1.toString());
				*/
				System.out.println("Downloading files for " + countyName);
				final String[] filenames = {"summary.zip","detailxls.zip","detailtxt.zip","detailxml.zip"};
				for (String filename : filenames){
					URL url = new URL(URL0 + value.substring(0, value.indexOf("/index.html")) + scriptSrc + "/reports/"+filename);
					//TODO This has only been tested on a Mac. Is a different directory separator needed in Windows?
					final String directory = "./downloads/" + countyName;
					try{
						if (!createDir(directory)){
							//TODO Do we want to stop here or skip?
							System.out.println("Error creating directory " + countyName + ". Stopping.");
							return;
						}
						downloadFromUrl(url, directory + "/" + filename);
					}
					catch(IOException e){
						//TODO Do we want to stop here or skip?
						System.out.println("Caught IOException at " + countyName + ". Stopping.");
						return;
					}
				}
				//If you want to run thru this for only the first county, uncomment this line:
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
			System.out.println("Error: " + fieldName + " is empty");
			return false;
		}
		return true;
	}
	
	private static void downloadFromUrl(URL url, String localFilename) throws IOException {
	//from https://stackoverflow.com/questions/14413774/download-file-via-http-with-unknown-length-with-java		
		InputStream is = null;
		FileOutputStream fos = null;
		try {
			URLConnection urlConn = url.openConnection();//connect

			is = urlConn.getInputStream();               //get connection inputstream
    		fos = new FileOutputStream(localFilename);   //open outputstream to local file

			byte[] buffer = new byte[4096];              //declare 4KB buffer
			int len;

			//while we have availble data, continue downloading and storing to local file
			while ((len = is.read(buffer)) > 0) {  
				fos.write(buffer, 0, len);
			}
		} finally {
			try {
				if (is != null) {
					is.close();
				}
			} finally {
				if (fos != null) {
					fos.close();
				}
			}
		}
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