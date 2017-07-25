   import java.util.*; 

   public class DateTest { 
   
      public static HM12 hm12_obj;
   /*   public static HMS12 hms12_obj;
      public static HM24 hm24_obj;
      public static HMS24 hms24_obj;
   
   in main;
   	//hms24_obj = new HMS24();
     	//hms24_obj.start();
   //Thread.yield();
   etc
   	*/
      public static void main(String[] args) { 
      
         Date d = new Date();
         Calendar c = new GregorianCalendar();
      
         int second = c.get(Calendar.SECOND);
         System.out.println(d);
         hm12_obj = new HM12();
         hm12_obj.start();
      }
   }
/*


*/
