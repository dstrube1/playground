//urls
// Created: 02-12-22 336p
// http://java.sun.com/j2se/1.4/docs/api/
//

   import java.io.*;
   import java.net.*;
   import numbers.*;

   public class urls
   {
   
      public static boolean urlexists(URL findme, String tag404){
         boolean exists = true;
         final String notfound_str = tag404;
         try {
            URLConnection uc = findme.openConnection();
            BufferedReader br = new BufferedReader(
                              new InputStreamReader(
                                                uc.getInputStream()));
            String input;
            int count = 0; //if not found in the first few lines...
         
            while ((input = br.readLine()) != null && count<=3) {
               if (input.equals(notfound_str)){
                  exists=false;
                  break;
               }
               count++;
            }
            br.close();
         }  // end test url try
            catch (IOException e) {
               System.out.println("IOException: " + e);
            }
         return exists;
      }
   
      public static void printIf(String urltext){
         final String tag404 = "<html><head><title>x.COM</title>";
         try {
            URL archive = new URL(urltext);
         
            if (! urlexists(archive, tag404)){
                  //then it doesnt exist, boo-hoo
            }
            else {
               System.out.println(archive);
                        	//System.out.println(": found");
            }
         }//end make url try
         
         
            catch (MalformedURLException e){
               System.out.println("Malformed URL: " + e);
            }
      
      }
   
      public static void main( String args[] )
      {
      
      
      	/****************************
      	//		Constants
      	****************************/
         final String domain = "http://ldbfkldjfbkdsjfb.com/rnd/img/";
         final String ending=".jpg";
         final String img_name[] = {"x"}; 
      
         /****************************
      	//		Variables
      	****************************/
         String urltext="";
         numbers n = new numbers();
      
         //int count=0;
         boolean notfound = false;
      
         for (int h=0; h<img_name.length; h++){ //each img_name
            for (int i=0; i<3; i++){ //each number format
               if (i==0){
                  for(int j=0; j<n.num0_99.length;j++){
                     urltext = (domain + img_name[h] +n.num0_99[j]+ ending);
                     //System.out.println("Testing "+urltext+"...");
                     printIf(urltext);
                  }
               }
               else if (i==1){
                  for(int k=0; k<n.num00_99.length;k++){
                     urltext = (domain + img_name[h] +n.num00_99[k]+ ending);
                     printIf(urltext);
                  }
               }	
               else{
                  for(int m=0; m<n.num000_999.length;m++){
                     urltext = (domain + img_name[h] +n.num000_999[m]+ ending);
                     printIf(urltext);
                  }
               }
            
            
            } //end cycling number formats
         } //end img_names
      } //close main
   } //close urls
