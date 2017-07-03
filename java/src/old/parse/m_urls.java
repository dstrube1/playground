// m_urls
// Created: 02-12-22 355p (yy-mm-dd time is more logical)
// http://java.sun.com/j2se/1.4/docs/api/
//

   import java.io.*;
   import java.net.*;

   public class m_urls
   {
   
      public static boolean urlexists(URL findme){
         boolean exists = true;
         final String notfound_str = "<html><head><title>x.COM</title>";//404 tag
         String input;
         int count = 0; //if not found in the first few lines...
      
         try {
            URLConnection uc = findme.openConnection();
            BufferedReader br = new BufferedReader(
                              new InputStreamReader(
                                                uc.getInputStream()));
         
            while ((input = br.readLine()) != null && count<=5) {
               if (input.equals(notfound_str)){
                  exists=false;
                  break;
               }
            	count++;
            }
            br.close();
         }  // end test url try condition...now the catch condition:
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
         final String domain = "http://kjdbkjdfnb.com/rnd/img/";
         final String ending="sm.jpg";
      
      
         /****************************
      	//		Variables
      	****************************/
         String urltext;
         String img_name="x"; 
      		//          ^^^edit this per image name indicator
         int count=0;
         boolean notfound = false;
      
         for (int i=0; i<99; i++){ //0-99
            urltext = (domain+img_name+i+ending);
            try {
               URL archive = new URL(urltext);
               //System.out.print(archive);
            
               if (! urlexists(archive)){
                  // System.out.println("  - 404");
               	//not found - boohoo
               }
               else {
                  System.out.println(archive);
                        	//System.out.println(": found");
               }
            }//end make url try
            
               catch (MalformedURLException e){
               
                  System.out.println("Malformed URL: " + e);
               }
         
         
            //for (int j=0; j<12; j++){ //00-99
            //}
         
         } //end cycling thru dates
      } //close main
   } //close class
