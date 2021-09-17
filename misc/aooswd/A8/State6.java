//State6.java
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 8 - State Pattern
***************/

   public class State6 extends State{
      private Recognizer r;
      public State6(Recognizer r){
         super(r);
         this.r=r;
      }
   
      public boolean transition(Character c){
         boolean anser=false;
         if (CharChecker.isDigit(c)){
            anser=true;
            r.setState(6);
         }
         else if (CharChecker.isDollar(c)){
            anser=false;
            r.setState(7);
         }
         //else System.out.println("Invalid number string at State6");
         return anser;
      }
   }