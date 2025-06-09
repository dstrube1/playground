//David Strube
//CSIS4650
//Assignment 4
//Observer Pattern

import java.util.Observable; 

   public class Clock extends Observable {
   
      private int duration=1000;
      private long ms; // milliseconds
   
      public Clock(){
      //initialize observer(s)
         addObserver(new ClockMgr()); 
      
      }
   
      public void trackTime() {
         //System.out.println("in track time");
         for (int i=0; i<duration; i++){
            //System.out.println("in for: i="+i);
            ms=System.currentTimeMillis();
            while (System.currentTimeMillis()<(ms+1000)){//<1 second passed
               //System.out.println("in while; ");
            }
            setChanged(); 
            notifyObservers(); 
         }
      
      }
   }