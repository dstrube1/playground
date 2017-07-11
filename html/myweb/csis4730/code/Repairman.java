   import psimjava.*;
//
// Java version with the Psim-J package. J Garrido, Feb. 2001
//
// This class defines behavior of Repairman objects
//
   public class Repairman extends psimjava.Process
   {
      private double mean_rep;     // mean repair period
      private double st_dev;       // standard deviation
      private Normal rep_rand;     // random gen repair
      private Urand job_rand;      // random gen other job
      private double lower = 0.45; // lower limit
      private double upper = 2.3;  // upper limit
      private String myname;
      public Repairman (String name, double rep_dur, double std)
      {
         super(name);
         myname=name;
         mean_rep = rep_dur;
         st_dev = std;
         rep_rand = new Normal (mean_rep, st_dev);
      }
   //
      public void Main_body()
      {
         int damaged_parts;
         double repair_per;            // operation random period
         double job_per;               // period for other job
         job_rand = new Urand (lower, upper);
         while ( get_clock() < Preplace.simPeriod) {
            damaged_parts = Hospital.fault_parts.num_avail();
         // System.out.println("Repairman damaged parts: " +
         //    damaged_parts);
            while ( damaged_parts > 0 ) {
               Hospital.fault_parts.take(1);
               Hospital.out.println(myname+" starting repair at: " +
                                   get_clock());
               repair_per = rep_rand.fdraw();
               delay (repair_per);       // repair period
            // part repaired
               Hospital.out.println(myname+" done repairing parts");
               Hospital.rep_parts.give(1);  // repaired part
            }
            //Hospital.out.println(myname+" to other job at:"+
                                //get_clock());
            job_per = job_rand.fdraw();
            delay(job_per);             // other job
         } // end while
      }   // end Main_body
   }     // end of class Repairmen

