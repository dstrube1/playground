// file_lines
// Created: 2003-1-4 9p
// http://java.sun.com/j2se/1.4/docs/api/
// Prints out contents of a file, one line at a time
   //package file_lines;

   import java.io.*;
   import java.nio.channels.*;

   public class file_lines
   /************************
   	Object types:
   BufferedReader
   File
   FileChannel
   InputStream
   InputStreamReader
   RandomAccessFile
   String
   ***********************/
   {
      public static void main(String args[])
      {
         try {
         // Create a read/writeable file channel
            //File file = new File("filename");
            //FileChannel channel = new RandomAccessFile(file, "rw").getChannel();
            FileChannel channel = new RandomAccessFile(
                              new File("investigation.txt"), 
                              //read-only:
                              "r").getChannel();
         		//read/write:
         			//"rw").getChannel();
         
         // Create an output stream on the channel
            //OutputStream os = Channels.newOutputStream(channel);
         
         // Create an inputstream on the channel
            InputStream is = Channels.newInputStream(channel);
            BufferedReader br = new BufferedReader(
                              new InputStreamReader(is));
            String input;
            int count=0;
         
            while ((input = br.readLine()) != null && count < 5) {
               System.out.println(input);
            }
         
            // Close the channel
            br.close();
            is.close();
            channel.close();
         } 
            catch (IOException e) {
            
               System.out.println("IOException: " + e);
            }
      } //close main
   } //close class
