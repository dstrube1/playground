   class TimerThread extends Thread {
      private Timed target;
      private int interval;
      public TimerThread (Timed t, int i) {
         target = t;
         interval = i;
         setDaemon(true);
      }
      public void run() {
         try {
            while (true) {
               sleep(interval);
               target.update(this);
            }
         } 
            catch (Exception e){
            }
      
      }
   }