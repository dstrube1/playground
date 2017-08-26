// investigation2
// Created: 2003-1-3 421p
// http://java.sun.com/j2se/1.4/docs/api/
// Takes in file with all urls under investigation;
//no need for formatted numbers package

   import java.io.*;
   import java.net.*;
   import java.nio.channels.*;

   public class investigation2
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
      	//		Variables
      	****************************/
         String urltext="";
         int count=0;
         boolean notfound = false;
         try {
            FileChannel channel = new RandomAccessFile(
                              new File("investigation.txt"), "r").getChannel();
            InputStream is = Channels.newInputStream(channel);
            BufferedReader br = new BufferedReader(new InputStreamReader(is));
         
            while((urltext= br.readLine()) != null && count < 500){
               //System.out.println("Testing "+urltext+"...");
               printIf(urltext);
            	count++;
            }
            br.close();
            channel.close();
         } 
         
            catch (IOException e) {
               System.out.println("IOException: " + e);
            }
      } //close main
   } //close class
