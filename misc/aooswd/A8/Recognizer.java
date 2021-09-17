//Recognizer.java
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 8 - State Pattern
***************/

   public class Recognizer{
      private State s;
      private boolean success;
   
      public Recognizer(){
         s = new StartState(this);
         success = false;
      }              
   
      public void setState(int i){
         if (i == 1){
            s = new State1(this);
         }
         else if (i == 2){
            s = new State2(this);
         }
         else if (i == 3){
            s = new State3(this);
         }
         else if (i == 4){
            s = new State4(this);
         }
         else if (i == 5){
            s = new State5(this);
         }
         else if (i == 6){
            s = new State6(this);
         }
         else if (i == 7){
            success = true;
         }
         else System.out.println("Invalid State setting");
      }
   
      public void parse(String blah){
         s = new StartState(this);
         boolean go_on=true;
         success = false;
         int index=0;
         //System.out.println("Of string "+blah+" :");
         while (go_on){
            //System.out.println("testing blah at "+index+": "+blah.charAt(index));
            go_on=s.transition(new Character(blah.charAt(index++)));
            //if (go_on) System.out.println(blah.charAt(index-1)+" is valid");
         }
         if (success){
            System.out.println("This is a valid string representation of a floating point:");
         }
         else{
            System.out.println("This is an invalid string representation of a floating point:");
         }
         System.out.println(blah);
      
      }
   
   }