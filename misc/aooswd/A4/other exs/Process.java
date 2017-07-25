   package psimjava;

   import java.io.PrintStream;

// Referenced classes of package psimjava:
//            Sched, Suspend, Startlock, Pobject, 
//            StaticSync

   public abstract class Process extends Sched
   {    private int interrupt_level;
      private boolean comm_flag;
      private String t_name;
      private double remaining_t;
      private static double simul_p;
      private static Startlock stlock;
      public Suspend susobj;
   
      protected Process(String s)
      {
         t_name = new String(s);
         interrupt_level = 0;
         set_state(1);
         susobj = new Suspend();
         stlock = new Startlock();
         StaticSync.incr_created();
         StaticSync.insert(this, 0.0D);
      }
   
      public String get_name()
      {
         return t_name;
      }
   
      private void resultis(double d)
      {
         Pobject pobject = (Pobject)Thread.currentThread();
         Pobject pobject1 = StaticSync.this_process();
         cancel(d);
         if(pobject1 == (Pobject)pobject)
         {
            StaticSync.schedule();
         }
      }
   
      public void terminate()
      {
         cancel(0.0D);
         Process process = (Process)StaticSync.this_process();
         Process process2 = this;
         StaticSync.removerc(this);
         set_state(3);
         StaticSync.place_term(this);
         if(this == process)
         {
            StaticSync.schedule();
            Process process1 = (Process)StaticSync.this_process();
            process1.susobj.proceed();
         }
         try
         {
            susobj.set_flag(true);
            susobj.suswait();
         }
            catch(InterruptedException interruptedexception) { 
            }
      }
   
      public boolean is_terminated()
      {
         return rdstate() == 3;
      }
   
      public void deactivate(Process process)
      {
         StaticSync.deactivate(process);
      }
   
      public void reactivate(Process process)
      {
         StaticSync.reactivate(process);
      }
   
      private void deactivate2()
      {
         if(rdstate() == 2)
         {
            StaticSync.removerc(this);
         }
         StaticSync.schedule();
         long l = (long)(simul_p - StaticSync.get_clock()) * 1000L;
         try
         {
            Thread.sleep(l);
         }
            catch(InterruptedException interruptedexception)
            {
               delay(0.0D);
               return;
            }
      }
   
      public void delay(double d)
      {
         boolean flag = false;
         Pobject pobject = (Pobject)Thread.currentThread();
         Process process = (Process)StaticSync.this_process();
         StaticSync.insert(this, d);
         if(this == process)
         {
            StaticSync.schedule();
            process = (Process)StaticSync.this_process();
            if(this == process)
            {
               flag = true;
            } 
            else
            {
               process.proceed();
            }
         }
         process = (Process)StaticSync.this_process();
         if(!flag && process != this)
         {
            try
            {
               susobj.set_flag(true);
               susobj.suswait();
            }
               catch(InterruptedException interruptedexception) { 
               }
         }
         Thread.yield();
         StaticSync.show_rchain();
      }
   
      public void p_interrupt(int i)
      {
         Process process = (Process)StaticSync.this_process();
         if(rdstate() != 2)
         {
            System.out.println("Proc to interrupt " + get_name() + " is not running");
            Pobject.process_error(19);
         }
         remaining_t = rdtime() - StaticSync.get_clock();
         interrupt_level = i;
         StaticSync.insert(this, 0.0D);
      }
   
      public double get_remain_t()
      {
         return remaining_t;
      }
   
      public void preempt()
      {
         if(rdstate() == 2)
         {
            StaticSync.removerc(this);
         } 
         else
         {
            Pobject.process_error(19);
         }
         remaining_t = rdtime() - StaticSync.get_clock();
         interrupt();
      }
   
      public void schedat(double d)
      {
         double d1 = StaticSync.get_clock();
         if(d < d1)
         {
            Pobject.process_error(21);
         }
         delay(d - d1);
      }
   
      public void run()
      {
         Process process = (Process)StaticSync.this_process();
         start_th();
         Main_body();
      }
   
      private void start_th()
      {
         Process process = this;
         StaticSync.incr_started();
         if(StaticSync.first_process())
         {
            StaticSync.set_first();
            StaticSync.running(process);
            StaticSync.pfirst = process;
         } 
         else
            if(StaticSync.this_process() != this)
            {
               susobj.set_flag(true);
               try
               {
                  susobj.suswait();
               }
                  catch(InterruptedException interruptedexception) { 
                  }
            }
      }
   
      public abstract void Main_body();
   
      public void clear_int()
      {
         interrupt_level = 0;
      }
   
      public int int_level()
      {
         return interrupt_level;
      }
   
      public boolean idle()
      {
         return rdstate() == 1;
      }
   
      public boolean comm_wait()
      {
         return comm_flag;
      }
   
      public void set_comm_flag(boolean flag)
      {
         comm_flag = flag;
      }
   
      public static void set_simul_p(double d)
      {
         simul_p = d;
      }
   
      public static double get_simul_p()
      {
         return simul_p;
      }
   
      private void jjstart_th()
      {
         StaticSync.jjstart_th();
      }
   
      private void check_started()
      {
         StaticSync.incr_started();
         if(StaticSync.get_started() < StaticSync.get_created())
         {
            StaticSync.insert(this, 0.0D);
            try
            {
               susobj.set_flag(true);
               susobj.suswait();
            }
               catch(InterruptedException interruptedexception) { 
               }
         }
      }
   
      public void proceed()
      {
         susobj.proceed();
         for(int i = 1; i < 10; i++)
         {
            Thread.yield();
         }
      
      }
   }
