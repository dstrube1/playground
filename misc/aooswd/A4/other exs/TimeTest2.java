   import java.util.*; 
   import java.io.*;

   public class TimeTest2{
      public static void main (String args[]){
         if (args.length<1){
            /*******************old:
         	Calendar calendar = new GregorianCalendar();
            Date trialTime = new Date();
            calendar.setTime(trialTime);
         
         // print out a bunch of interesting things
            System.out.print(calendar.get(Calendar.HOUR)+ ":" + calendar.get(Calendar.MINUTE));
            System.out.print(":" + calendar.get(Calendar.SECOND));
            System.out.print(":" + calendar.get(Calendar.MILLISECOND));
            System.out.println(calendar.get(Calendar.AM_PM)!=1?"AM":"PM");
         	**********************/
            long ms=System.currentTimeMillis();
            for (int i=0; i<1000; i++){
               while (System.currentTimeMillis()<(ms+1000)){//<1 second passed
               }
               //notify
            	ms=System.currentTimeMillis();
            }
         
         }
         else
            System.out.println("too many parameters");
      }
   }