//State3.java
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 8 - State Pattern
***************/

   public class State3 extends State{
      private Recognizer r;
      public State3(Recognizer r){
         super(r);
         this.r=r;
      }
   
      public boolean transition(Character c){
         boolean anser=false;
         if (CharChecker.isDashOrPlus(c)){
            anser=true;
            r.setState(5);
         } 
         else if (CharChecker.isDigit(c)){
            anser=true;
            r.setState(6);
         }
         //else System.out.println("Invalid number string at State3");
         return anser;
      }
   }