//David Strube
//CSIS4650
//Assignment 4
//Observer Pattern

//Note: Clocks that print out only once a minute 
//will print out only once a minute (correct)
//		but will do so not necessarily at the beginning of each minute (innaccurate)

// 20/20
   import java.util.*;


   public class ClockMgr implements Observer{
      private int notifications=0;
      protected static HM12 hm12_obj;
      protected static HMS12 hms12_obj;
      protected static HM24 hm24_obj;
      protected static HMS24 hms24_obj;
      protected static Clock c;
   
      //public ClockMgr(){
         //}
   
      public static void main(String[] args) {
         c= new Clock();
         hm12_obj = new HM12();
         hms12_obj = new HMS12();
         hm24_obj = new HM24();
         hms24_obj = new HMS24();
         c.trackTime();
      }
   
      public void update(Observable o, Object arg) { 
         notifications++;
         if (notifications%60==0){
            hm12_obj.print(); 
            hm24_obj.print(); 
         }
         hms12_obj.print(); 
         hms24_obj.print(); 
      } 
   
   }

