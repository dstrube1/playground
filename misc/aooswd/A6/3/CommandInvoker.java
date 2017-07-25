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
   
      public CommandInvoker(){
         history= new ArrayList();
      }
   
      public void execute(Command c, MyList dataset)
      {
         boolean result=true;
         Integer n;
         Integer x;
         /*if (c.getOp().matches("fillTo, .+")){
            history.add(c);
            n = new Integer( //String !-> int, so String->Integer->int
                           c.getOp().substring(c.getOp().indexOf(',')+2));
            fillToN(n.intValue(), dataset);
         }
         else*/
         if (c.getOp().matches("addTo.+")){
            history.add(c);
            if (c.getOp().matches("addToX, .+")){
               n = new Integer( 
                              c.getOp().substring( 
                                                c.getOp().indexOf(',')+2, c.getOp().lastIndexOf(',') ) );
               x = new Integer( 
                              c.getOp().substring( 
                                                c.getOp().lastIndexOf(',')+2 ) );
               c.addNtoX(n.intValue(), x.intValue(), dataset);
            }
            else if(c.getOp().matches("addToAll, .+")){
               n = new Integer(c.getOp().substring(c.getOp().indexOf(',')+2));
               c.addNtoAll(n.intValue(), dataset);
            }
         } 
         else if (c.getOp().matches("subTo.+")){
            history.add(c);
            if (c.getOp().matches("subToX, .+")){
               n = new Integer( 
                              c.getOp().substring( 
                                                c.getOp().indexOf(',')+2, c.getOp().lastIndexOf(',') ) );
               x = new Integer( 
                              c.getOp().substring( 
                                                c.getOp().lastIndexOf(',')+2 ) );
               c.subNtoX(n.intValue(), x.intValue(), dataset);
            }
            else if(c.getOp().matches("subToAll, .+")){
               n = new Integer(c.getOp().substring(c.getOp().indexOf(',')+2));
               c.subNtoAll(n.intValue(), dataset);
            }
         }
         else if (c.getOp().matches("undo")){
            result=c.undo( (Command)history.get(history.size()-1),dataset);
            if( result){
               history.remove(history.size()-1);
               result=false;
            }
         }
         else if (c.getOp().matches("redo")){
            result=c.redo( (Command)history.get(history.size()-1), dataset);
            if(result){ 
               execute((Command)history.get(history.size()-1), dataset);
               result=false;
            }
         }
         else if (c.getOp().matches("print")){
            c.print(dataset);
         }
         else if (c.getOp().matches("")){}
         else System.out.println("\nCommand not recognized");
      }
   
      public String historyToString(){
         String output="";
         for (int i = 0; i< history.size(); i++){
            output+= ((Command)history.get(i)).getOp() + '\n';
         }
         return output;
      }
   }