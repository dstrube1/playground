package com.dstrube;

/*
commands to compile and run:

from mac ~/java:
compile:
javac -cp bin:bin/jsoup-1.11.1.jar -d bin com/dstrube/misc/TinyGhostsParser.java
run:
java -cp bin:bin/jsoup-1.11.1.jar com.dstrube.TinyGhostsParser

note, currently located in com/dstrube/misc, but the package is just com.dstrube
*/

import java.io.IOException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.*;
import org.jsoup.select.Elements;
//http://jsoup.org/cookbook/extracting-data/attributes-text-html

public class TinyGhostsParser {

	private static final String PAGE_ROOT = "http://www.tinyghosts.com/archive/";
	private static final String BEGIN_BEGIN_PAGE = PAGE_ROOT + "tinyghosts000.html";
	
	public static void main(String[] args) {
		int index = 0;
		String page = BEGIN_BEGIN_PAGE;
		System.out.println("Testing each page for a back and next");
		while (parsePage(page,index) ){
			index++;
			if (index < 10){
				page = BEGIN_BEGIN_PAGE.replace("000", "00"+index);
			}
			else if (index >= 10 && index < 100){
				page = BEGIN_BEGIN_PAGE.replace("000", "0"+index);
			}
			else if (index >= 100){
				page = BEGIN_BEGIN_PAGE.replace("000", ""+index);
			}
			//break;
		}
		System.out.println("Done");		
	}

	private static boolean parsePage(String page, int pageNum){
		try{
			Document doc = Jsoup.connect(page).get();
			if (pageNum > 0 && pageNum % 100 == 0){
				System.out.println(pageNum);
			}
			else{
				System.out.print(".");
			}
			//System.out.print(page+"; ");
			//System.out.print(doc.title());
			Element el = doc.body();
			//System.out.println("el.html = " + el.html());
			Elements tds = el.getElementsByTag("td");
			String prefix = "tinyghosts";
			String suffix = ".html";
			
			for (Element td : tds){
				if (td.toString().contains("back")){
					//not all pages have a Back
					String backPage = td.toString().substring(td.toString().indexOf(prefix),td.toString().indexOf(suffix)+suffix.length());
					//System.out.print("; backPage: " + backPage);
					int backPageNum = Integer.parseInt(backPage.replace(prefix, "").replace(suffix, ""));
					if (backPageNum != pageNum-1){
						System.out.println("\n************ERROR with back page here: "+doc.title() + "************");
					}
				}
				if (td.toString().contains("next")){
					//all pages have a Next
					String nextPage = td.toString().substring(td.toString().indexOf(prefix), td.toString().indexOf(suffix)+suffix.length());
					//System.out.println("; nextPage: " + nextPage);
					int nextPageNum = Integer.parseInt(nextPage.replace(prefix, "").replace(suffix, ""));
					if (nextPageNum != pageNum+1 && nextPageNum != 1){
						System.out.println("\n************ERROR with next page here: "+doc.title() + "************"); 
					}
				}
			}

		}catch (IOException e){
			//System.out.println("\nstopping here: " + page + " because " + e.toString());
			return false;
		}
		return true;
	}
}
