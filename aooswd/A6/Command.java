/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/*************
commands:

interface for a command object for each potential operation on the data set
including redo & undo commands
*************/

   public class Command{
      protected String op;

      public Command(){}

      public Command(String operation){
         op=operation;}

      public String getOp(){
         return op;}

      public void doit(MyList dataset){}

      public boolean isDoable(){
         return true;}

		public void setDoable(boolean setting){}

      public void setCommand(Command c){
         op=c.getOp();}

      public String redoneCommandToString(){
         return "";}
      public String undoneCommandToString(){
         return "";}

   }

   /*****************************************************************
   This is where you could distribute responsibilities.  You have the
   responsibility of storing the type of operation here rather than
   having the subclass know that.
   ******************************************************************/

