//State2.java
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 8 - State Pattern
***************/

   public class State2 extends State{
      private Recognizer r;
      public State2(Recognizer r){
         super(r);
         this.r=r;
      }
   
      public boolean transition(Character c){
         boolean anser=false;
         if (CharChecker.isDigit(c)){
            anser=true;
            r.setState(4);
         }
         //else System.out.println("Invalid number string at State2");
         return anser;
      }
   }