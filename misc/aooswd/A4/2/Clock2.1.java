   //clock2.1
	import java.util.*;
   import java.text.*;

   public class Clock implements Runnable {
      private volatile Thread timer;       // The thread that displays clock
      private static SimpleDateFormat formatter;  // Formats the date displayed
      private static String lastdate;             // String to hold date displayed
      private static Date currentDate;            // Used to get date to display
   
      public void init() {
         formatter = new SimpleDateFormat ("EEE MMM dd hh:mm:ss yyyy", 
                              Locale.getDefault());
         currentDate = new Date();
         lastdate = formatter.format(currentDate);
      
      }
   
    // Paint is the main part of the program
      public static void main(String[] args) {
         int s = 0, m = 10, h = 10;
         int xcenter = 80, ycenter = 55;
         String today;
      
         currentDate = new Date();
      
         formatter.applyPattern("s");
         try {
            s = Integer.parseInt(formatter.format(currentDate));
         } 
            catch (NumberFormatException n) {
               s = 0;
            }
         formatter.applyPattern("m");
         try {
            m = Integer.parseInt(formatter.format(currentDate));
         } 
            catch (NumberFormatException n) {
               m = 10;
            }    
         formatter.applyPattern("h");
         try {
            h = Integer.parseInt(formatter.format(currentDate));
         } 
            catch (NumberFormatException n) {
               h = 10;
            }
      
        // Get the date to print at the bottom
         formatter.applyPattern("EEE MMM dd HH:mm:ss yyyy");
         today = formatter.format(currentDate);
      
         currentDate = null;
      }
   
      public void start() {
         timer = new Thread(this);
         timer.start();
      }
   
      public void stop() {
         timer = null;
      }
   
      public void run() {
         Thread me = Thread.currentThread();
         while (timer == me) {
            try {
               Thread.currentThread().sleep(100);
            } 
               catch (InterruptedException e) {
               }
            System.out.println(lastdate);
         }
      }
   }
