   class PrimeThread extends Thread {
      long minPrime;
      PrimeThread(long minPrime) {
         this.minPrime = minPrime;
      }
   
      public void run() {
             // compute primes larger than minPrime
         System.out.println("Computing primes larger than "+minPrime);
      }
   }
