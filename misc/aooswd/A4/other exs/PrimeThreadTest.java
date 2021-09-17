
   		          
   class PrimeThreadTest{
   
      public static void main (String args[]){
         PrimeThread p = new PrimeThread(143);
         p.start();
         p.yield();
      	try{
         p.sleep(500,1);
      	}
      	 catch(InterruptedException e){}
      System.out.println(p.toString());
      }
   }