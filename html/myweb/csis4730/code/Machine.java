   import psimjava.*;
//
// Java version with the Psim-J package. J Garrido, Feb. 2001
//
// This class defines behavior of Machine objects
//
   public class Machine extends psimjava.Process
   {
   // private int machineNum;      // machine number
      private double mean_oper;    // mean operation period
      private double st_dev;       // standard deviation
      private Normal oper_rand;    // random gen
      private double removal_per = 0.45; // may be modified to random
      private double replace_per = 0.45; // same
   
      public Machine(String name, double oper_dur, double std)
      {
         super(name);
         mean_oper = oper_dur;
         st_dev = std;
         oper_rand = new Normal (mean_oper, st_dev);
      }
   //
      public void Main_body()
      {
         double start_wait;            // time machine starts to wait
         double wait_p;                // wait period for machine
         double operation_per;         // operation random period
      	final double deadline = 6.0;
         while ( get_clock() < Hospital.simPeriod) {
            operation_per = oper_rand.fdraw();
            delay (operation_per);       // machine operation period
         // part failed
            start_wait = get_clock();
            Hospital.out.println(get_name() +
                                " failed at " + get_clock());
            delay(removal_per);           // removal of part
            Hospital.out.println(get_name() +
                                " 	requesting replacement at " + get_clock());
            Hospital.fault_parts.give(1);  // damaged part to repair
         // process will keep trying until replacement available
            Hospital.rep_parts.take(1);
            delay(replace_per);
            Hospital.out.println(get_name() + " got replacement at: "
                                + get_clock());
         // now compute this wait period
            wait_p = get_clock() - start_wait;
            if (wait_p > deadline){
               Hospital.out.println("############################");
               Hospital.out.println("WARNING, PATIENT DYING on "+get_name()+"!!!");
               Hospital.out.println("###########################");
               Hospital.warnings++;
            }
            Hospital.adown += wait_p;        // accumulate wait period
            Hospital.aserv += operation_per; // accumulate operation per
         } // end while
      }   // end Main_body
   }     // end of class Machine

