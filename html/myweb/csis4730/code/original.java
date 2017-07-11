import java.io.*;
import psimjava.*;
// A model of machine parts replacement system.
// Several machines in a shop each have a part that fails
// periodically. The part that fails needs to be removed from
// the machine, and a replacement part, if available, installed.
// The parts that fail are to be repaired by a repairman, who
// also have other jobs to carry out when not repairing parts.
//
// Psim-J package, J. Garrido, March 2001.
// Main class: Preplace
//
public class Preplace extends psimjava.Process
{
  public static Machine machine_1;     //
  public static Machine machine_2;     //
  public static Machine machine_3;     //
  public static Repairman repair_obj;
  
  public static Preplace preplace_obj;

  public static Bin fault_parts;     // faulty parts
  public static Bin rep_parts;       // replacement parts

  public static final int MAX_REP = 0;   // initial num replac parts
  public static final int MAX_FAULT = 0; // initial num faulty parts

  public static double simPeriod = 625d;    // simulation period
  public static double moperate = 32.5d;    // m operate per
  public static double oper_std = 6.5;
  public static double mremoval = 2.3d;     // m removal per
  public static double mreplace = 2.3d;     // m replacement per
  public static double mrepair = 23.3d;     // m repair per
  public static double rep_std = 0.5;
  //
  public static double aserv = 0d;     // accum oper per
  public static double adown = 0d;     // accum down per
  //
  public static int num_serv = 3;      // machines serviced

  public static Simulation sim;
  public static PrintStream out = System.out;
  public Preplace( String ss) {
    super(ss);
  }
  //
  public static void main(String[] args)
  {
    // set-up simulation
    sim = new Simulation("Machine Parts Replacement System");
    // create passive objects
    fault_parts = new Bin("Fault parts", MAX_FAULT);  // passive obj
    rep_parts = new Bin("Replacement parts", MAX_REP); // passive obj
    // Create and start active objects
    preplace_obj = new Preplace ("Machine Shop");
    preplace_obj.start();
    // machine objects
    machine_1 = new Machine("Machine 1", moperate, oper_std);
    machine_1.start();
    machine_2 = new Machine("Machine 2", moperate, oper_std);
    machine_2.start();
    machine_3 = new Machine("Machine 3", moperate, oper_std);
    machine_3.start();
    repair_obj = new Repairman ("Repairman", mrepair, rep_std); // obj
    repair_obj.start();
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
    }
    System.exit(0);
  }
}  // end of class Preplace

