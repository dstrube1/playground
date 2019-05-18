//State4.java
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 8 - State Pattern
***************/

   public class State4 extends State{
      private Recognizer r;
      public State4(Recognizer r){
         super(r);
         this.r=r;
      }
   
      public boolean transition(Character c){
         boolean anser=false;
         if (CharChecker.isDigit(c)){
            anser=true;
            r.setState(4);
         }
         else if (CharChecker.isE(c)){
            anser=true;
            r.setState(3);
         }
         else if (CharChecker.isDollar(c)){
            anser=false;
            r.setState(7);
         }
         //else System.out.println("Invalid number string at State4");
         return anser;
      }
   }