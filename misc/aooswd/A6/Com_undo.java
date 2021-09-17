/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/*************
command object for undoing previous commands
*************/

public class Com_undo extends Command{
      private Command c;
      private Command undone;
      private boolean doable;
      public Com_undo(){
         op="undo";
         doable=false;
      }

      public void setCommand(Command comm){
         undone=comm;
         setDoable(false);

         int fcp;//first_comma_position;
         int lcp;//last_comma_position;
         fcp=comm.getOp().indexOf(',');
         lcp=comm.getOp().lastIndexOf(',');

         if (comm.getOp().matches("addTo.+")){
            setDoable(true);
            if (comm.getOp().matches("addToX, .+")){
               Integer n = new Integer( comm.getOp().substring( fcp+2, lcp ) );
               Integer x = new Integer( comm.getOp().substring( lcp+2 ) );
               c=new Com_subNtoX(n.intValue(), x.intValue());
            }
            else if(comm.getOp().matches("addToAll, .+")){
               Integer n = new Integer(comm.getOp().substring(fcp+2));
               c= new Com_subNtoAll(n.intValue());
            }
         }
         else if( comm.getOp().matches("subTo.+")){
            setDoable(true);
            if (comm.getOp().matches("subToX, .+")){
               Integer n = new Integer( comm.getOp().substring( fcp+2, lcp ) );
               Integer x = new Integer( comm.getOp().substring( lcp+2 ) );
               c = new Com_addNtoX(n.intValue(), x.intValue());
            }
            else if(comm.getOp().matches("subToAll, .+")){
               Integer n = new Integer(comm.getOp().substring(fcp+2));
               c = new Com_addNtoAll(n.intValue());
            }
         }
         else if (comm.getOp().matches("push, .+")){
            setDoable(true);
            c= new Com_pop();
         }
         else if (comm.getOp().matches("pop, .+")){
            setDoable(true);
            Integer n = new Integer(comm.getOp().substring(fcp+2));
            c= new Com_push(n.intValue());
         }
      }

      public String undoneCommandToString(){
         String result="Can't undo anymore";
         if (isDoable())
            result= undone.getOp();
         return result;}

      public void setDoable(boolean setting){
         doable=setting;
      }

      public boolean isDoable(){
         return doable;}

      public void doit(MyList dataset){
         if (isDoable()){
            c.doit(dataset);
         }
      }


   /*********************************************************************
   This is another place where knowledge can be distributed.  Each individual
   command should know whether it is undoable and, if so, how to redo.
   **********************************************************************/

   }