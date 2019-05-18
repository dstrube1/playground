//StartState.java
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 8 - State Pattern
***************/

   public class StartState extends State{
      private Recognizer r;
   
      public StartState(Recognizer r){
         super(r);
         this.r=r;
      }
   
      public boolean transition(Character c){
         boolean anser=false;
         if (CharChecker.isDigit(c)){
            anser=true;
            r.setState(1);
         }
         //else System.out.println("Invalid number string at StartState");
         return anser;
      }
   }