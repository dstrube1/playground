// b_urls
// Created: 02-7-22 336p
// http://java.sun.com/j2se/1.4/docs/api/
//

   import java.io.*;
   import java.net.*;

   public class b_urls
   {
   
      public static boolean urlexists(URL findme){
         boolean exists = true;
         final String notfound_str = "<TITLE>404 Not Found</TITLE>";
         try {
            URLConnection uc = findme.openConnection();
            BufferedReader br = new BufferedReader(
                              new InputStreamReader(
                                                uc.getInputStream()));
            String input;
         
            while ((input = br.readLine()) != null) {
               if (input.equals(notfound_str)){
                  exists=false;
                  break;
               }
            }
            br.close();
         }  // end test url try
            catch (IOException e) {
               System.out.println("IOException: " + e);
            }
         return exists;
      }
   
      public static void main( String args[] )
      {
      	/****************************
      	//		Constants
      	****************************/
         final String domain = "http://www.kjdbkljndsb.com/";
         final String ending=".htm";
         final String mon[] = new String[12]; 
         mon[0]="jan";
         mon[1]="feb";
         mon[2]="march";
         mon[3]="april";
         mon[4]="may";
         mon[5]="june";
         mon[6]="july";
         mon[7]="aug";
         mon[8]="sept";
         mon[9]="oct";
         mon[10]="nov";
         mon[11]="dec"; 
      
         final int day[]= new int[31];
         for (int h=0; h<31; h++)
            day[h]=h+1;
      
         final String year[]= new String[2];
         year[0] = "-01";
         year[1] = "-02";
      
         /****************************
      	//		Variables
      	****************************/
         String urltext;
         int count=0;
         boolean notfound = false;
      
         for (int l=0; l<2; l++){ //year
            for (int j=0; j<12; j++){ //mon
               for (int k=0; k<31; k++){ //day
               
                  urltext = (domain+mon[j]+day[k]+year[l]+ending);
                  try {
                     URL archive = new URL(urltext);
                  
                     	/*************************
                     	TEST PRINT OUTS:
                     	System.out.print(archive);
                        System.out.println(" :");
                        System.out.println(archive.getContent());
                        System.out.println(archive.openConnection().getContent());
                        System.out.println(archive.openConnection().toString());
                        System.out.println("===================================");
                     	*************************/
                  
                     if (! urlexists(archive)){
                        	//try with 1st letter capitalised
                        urltext = (domain+
                                  mon[j].toUpperCase().substring(0,1)+
                                  mon[j].substring(1,mon[j].length())
                                  +day[k]+year[l]+ending);
                     
                        archive = new URL(urltext);
                     
                        if (urlexists(archive)){
                           System.out.println(archive);
                        }
                     }
                     else {
                        System.out.println(archive);
                        	//System.out.println(": found");
                     }
                  }//end make url try
                     catch (MalformedURLException e){
                        System.out.println("Malformed URL: " + e);
                     }
               }}} //end cycling thru dates
      } //close main
   } //close class
