   import java.io.*;
   import psimjava.*;
	
// A model of machine parts replacement system.
// Several life-support machines in a hospital each have a part that fails
// periodically. The part that fails needs to be removed from
// the machine, and a replacement part, if available, installed.
// The parts that fail are to be repaired by repairmen, who
// also have other jobs to carry out when not repairing parts.
// If a machine is not fixed by a certain time, a dealine is missed, 
//	a patient may die, and the system will be incorrect
//
// Main class: Hospital, based on Preplace from
// Psim-J package, J. Garrido, March 2001.
//
   public class Hospital extends psimjava.Process
   {
      public static final int nM = 3;
      public static final int nR = 3;
      public static Machine[] machines;
      public static Repairman[] repairmen;
      //public static Manager manager;
   
      public static Hospital preplace_obj;
   
      public static Bin fault_parts;     // faulty parts
      public static Bin rep_parts;       // replacement parts
   
      public static final int MAX_REP = 0;   // initial num replac parts
      public static final int MAX_FAULT = 0; // initial num faulty parts
   
      public static double simPeriod = 625d;    // simulation period
      public static double moperate = 32.5d;    // m operate per
      public static double oper_std = 6.5;
     // public static double mremoval = 2.3d;     // m removal per
      // public static double mreplace = 2.3d;     // m replacement per
      public static double mrepair = 2.3d;     // m repair per
      public static double rep_std = 0.5;
   //
      public static double aserv = 0d;     // accum oper per
      public static double adown = 0d;     // accum down per
      public static int warnings = 0;
   //
      public static int num_serv = nM;      // machines serviced
   
      public static Simulation sim;
      public static PrintStream out = System.out;
      public Hospital( String ss) {
         super(ss);
      }
   //
      public static void main(String[] args)
      {
      // set-up simulation
         sim = new Simulation("Life-Support Machine Parts Replacement System");
      
      	//establish output file
         File f;
         if (args.length>0)
            f = new File(args[0]);
         else 
            f = new File("output.txt");
         try{
            PrintStream p = new PrintStream(new FileOutputStream(f, true), //true enables file append
                              true); //true enables autoflush
            System.setOut(p);
         }
            catch (FileNotFoundException e){
            }
      
      
      // create passive objects
         fault_parts = new Bin("Fault parts", MAX_FAULT);  // passive obj
         rep_parts = new Bin("Replacement parts", MAX_REP); // passive obj
      // Create and start active objects
         preplace_obj = new Hospital ("Machine Shop");
         preplace_obj.start();
      // machine objects
         machines = new Machine[nM];
         for (int i=0; i < machines.length; i++){
            machines[i] = new Machine("Machine "+(i+1), moperate, oper_std);
            machines[i].start();
         }
      
      //repairmen
         repairmen = new Repairman[nR];
         for (int j=0; j< repairmen.length; j++){
            repairmen[j] = new Repairman ("Repairman "+(j+1), mrepair, rep_std); // obj
            repairmen[j].start();
         }
      
         //manager = new Manager("Bossman");
      }
   //
      public void Main_body() {
         double avedown;
         double aveup;
         out.println ("Workload " +
                     " mean oper.: " + moperate + " mean repair: " + mrepair);
         out.println("---------------------------------------------------------");
         sim.start_sim(simPeriod);
         out.println("---------------------------------------------------------");
         out.println ("Total machines serviced: " +
                     num_serv);
         if (num_serv > 0) {
            avedown = adown / num_serv;
            aveup = aserv / num_serv;
            out.println ("Average down period: " +
                        avedown);
            out.println ("Average up period: " +
                        aveup);
            out.println("Average machine utilization: " +
                       aveup / simPeriod);
            out.println("Warnings: "+ warnings);
         }
         System.exit(0);
      }
   }  // end of class Hospital

