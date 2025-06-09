//State.java
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 8 - State Pattern
***************/

   public abstract class State{
      private Recognizer rec;
      public State(Recognizer r){
         rec=r;
      }
      public abstract boolean transition(Character c);
   }