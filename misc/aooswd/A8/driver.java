//driver.java
/****************
David Strube      20/20
CSIS4650-01
Spring 2003
Assignment 8 - State Pattern
***************/

   public class driver{

      private static final int numOfTests = 21;

      public static void main (String[] args){
         String[] tests;
         if (args.length ==0){
            tests	= new String[numOfTests];
            tests = setTest();
         }
         else {
            tests = new String[args.length];
            for (int j=0; j<args.length; j++){
               tests[j] = args[j];
            }
         }
         Recognizer r = new Recognizer();
         for (int k=0; k<tests.length; k++){
         r.parse(tests[k]);
         }
      }

      public static String[] setTest(){
         String[] tests = new String [numOfTests];

      // valids:
         tests[0]="1$";
         tests[1] = "12$";
         tests[2] = "12.3$";
         tests[3] = "12.3e4$";
         tests[4] = "12.3e-4$";
         tests[5] = "12e-41$";
         tests[6] = "12e4$";
         tests[7] = "0.1e41$";
         tests[8] = "100000000000000000000000000000000000$";

      //	invalids:
         tests[9] = "1.$";
         tests[10] = "1-2$";
         tests[11] = "1.-2$";
         tests[12] = "1.2-e3$";
         tests[13] = "1.2-3$";
         tests[14] = "1.23e$";
         tests[15] = "1.23e-$";
         tests[16] = "1.23-e4$";
         tests[17] = "0.1e4.1$";
         tests[18] = "1 2$";
         tests[19] = "-1$";

      	//valid again:
         tests[20] = "2$";
         return tests;
      }
   }