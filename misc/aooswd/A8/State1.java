//State1.java
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 8 - State Pattern
***************/

   public class State1 extends State{
      private Recognizer r;
      public State1(Recognizer r){
         super(r);
         this.r=r;
      }
   
      public boolean transition(Character c){
         boolean anser=false;
         if (CharChecker.isDigit(c)){
            anser=true;
            r.setState(1);
         }
         else if (CharChecker.isDot(c)){
            anser=true;
            r.setState(2);
         }
         else if (CharChecker.isE(c)){
            anser=true;
            r.setState(3);
         } 
         else if (CharChecker.isDollar(c)){
            anser=false;
            r.setState(7);
         }
         //else System.out.println("Invalid number string at State1");
         return anser;
      }
   }