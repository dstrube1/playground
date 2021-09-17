/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/*************
command object for redoing the previous command
*************/
public class Com_redo extends Command{
      private Command c;
      private boolean doable;
   
      public Com_redo(){
         op="redo";
         doable=false;
      }
   
   
      public void setCommand(Command comm){
         int fcp;//first_comma_position;
         int lcp;//last_comma_position;
         setDoable(false);
      
         fcp=comm.getOp().indexOf(',');
         lcp=comm.getOp().lastIndexOf(',');
      
         if (comm.getOp().matches("addTo.+")){
            setDoable(true);
            if (comm.getOp().matches("addToX, .+")){
               Integer n = new Integer( comm.getOp().substring( fcp+2, lcp ) );
               Integer x = new Integer( comm.getOp().substring( lcp+2 ) );
               c=new Com_addNtoX(n.intValue(), x.intValue());
            }
            else if(comm.getOp().matches("addToAll, .+")){
               Integer n = new Integer(comm.getOp().substring(fcp+2));
               c= new Com_addNtoAll(n.intValue());
            }	
         }
         else if( comm.getOp().matches("subTo.+")){
            setDoable(true);
            if (comm.getOp().matches("subToX, .+")){
               Integer n = new Integer( comm.getOp().substring( fcp+2, lcp ) );
               Integer x = new Integer( comm.getOp().substring( lcp+2 ) );
               c = new Com_subNtoX(n.intValue(), x.intValue());
            }
            else if(comm.getOp().matches("subToAll, .+")){
               Integer n = new Integer(comm.getOp().substring(fcp+2));
               c = new Com_subNtoAll(n.intValue());
            }
         }
         else if (comm.getOp().matches("push, .+") ){
            setDoable(true);
            Integer n = new Integer(comm.getOp().substring(fcp+2));
            c= new Com_push(n.intValue());
         }
         else if (comm.getOp().matches("pop.+")){
            setDoable(true);
            c= new Com_pop();
         }
      }
   
   
      public String redoneCommandToString(){
         String result="Can't redo anymore";
         if (isDoable())
            result= c.getOp();
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
   }