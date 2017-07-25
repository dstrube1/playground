/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/*******************
command invoker:

executes the commands
maintains a history list for support of undo & redo
******************/

   import java.util.List;
   import java.util.ArrayList;
	//import java.util.regex.Pattern;

   class CommandInvoker{
      private List history; //list of reversible commands that have been executed
      private int hPtr;
      public CommandInvoker(){
         history= new ArrayList();
         hPtr=0;
      }

      public void execute(Command c, MyList dataset)
      {
         if (c.getOp().matches("addTo.+") || c.getOp().matches("subTo.+")
            || c.getOp().matches("push.+") || c.getOp().matches("pop")){
            c.doit(dataset);
            history.add(hPtr++,c);
         	//System.out.println("\nhPtr="+hPtr);
         }

         /*****************************************************************
         It would be better to build this knowledge into the command object.
         *****************************************************************/

         else if (c.getOp().matches("print")){
            c.doit(dataset);
         }
         else if (c.getOp().matches("undo") ){
            if (hPtr>0){
               c.setCommand((Command)history.get(hPtr-1));
               if( c.isDoable()){
                  hPtr--;
               	//System.out.println("\nUndoing: hPtr="+hPtr);
                  c.doit(dataset);
               }
            }
            else c.setDoable(false);
            //System.out.println("\nHistory: \n"+historyToString());
         }
         else if (c.getOp().matches("redo")){
            if (hPtr>=0 && hPtr<=history.size()){
               if (hPtr==0)
                  c.setCommand((Command)history.get(hPtr));
               else c.setCommand((Command)history.get(hPtr-1));
               if( c.isDoable()){
                  //System.out.println("\nRedoing: hPtr="+hPtr);
                  c.doit(dataset);
                  if (hPtr==0){
                     history.set(hPtr, (Command)history.get(hPtr));
                  }
                  else if (hPtr<history.size()){
                     //System.out.println("Where hPtr="+hPtr+" and history.size="+history.size());
                     history.set(hPtr, (Command)history.get(hPtr-1));
                  }
                  else
                     history.add((Command)history.get(hPtr-1));

                  hPtr++;
               }
            }

            /*************************************************************
            It would be cleaner to separate the history list operations
            from the command invoker operations.
            *************************************************************/

            else {
               c.setDoable(false);
               //System.out.println("\nRedoing: hPtr="+hPtr+">=history.size()="+history.size());
            }
            //System.out.println("\nHistory: \n"+historyToString());
         }
         else if (c.getOp().matches("")){System.out.println("\nBlank Command");}
         else System.out.println("\nCommand not recognized");

      }

      public String historyToString(){
         String output="";
         for (int i = 0; i<history.size(); i++){
            output+= ( (Command)history.get(i) ).getOp();
            if (i==hPtr-1)
               output+="\t<------ you are here";
            output+= '\n';
         }
         return output;
      }
   }