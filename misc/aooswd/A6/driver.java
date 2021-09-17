/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/***************************************************************************
You have centralized too much of the knowledge leading structured decision logic.
Distributing the knowledge would lead to polymorphic decision logic.  14/20
***************************************************************************/

/********************
generate commands (including some undo & redo commands)
display the data set using the toString operation after each command is executed
********************/
   import java.io.IOException;

   class driver{
      public static void main(String args[]){
      //create & populate dataset:
         MyList mine = new MyList();

         Integer i=new Integer(0);
         for (int j=0; j<25; j++){
            i=new Integer(j);
            mine.push(i);
         }

      //instantiate commands and command invoker:
         Command push50				= new Com_push(50);
         Command push100			= new Com_push(100);
         Command pop					= new Com_pop();
         Command plusOneToAll 	= new Com_addNtoAll(1);
         Command plusTenTo20 		= new Com_addNtoX(10, 20);
         Command whoops 			= new Com_undo();
         Command again 				= new Com_redo();
         Command minusOneToAll 	= new Com_subNtoAll(1);
         Command minus20ToTen 	= new Com_subNtoX(20, 10);
         Command c_print 			= new Com_print();

         CommandInvoker CI = new CommandInvoker();

      //do stuff:
         System.out.println("Initial data set: ");
         CI.execute(c_print, 			mine);

         CI.execute(pop,				mine);
         System.out.println("Pop:");
         CI.execute(c_print, 			mine);

         CI.execute(push50, 			mine);
         System.out.println("Push 50:");
         CI.execute(c_print, 			mine);

         CI.execute(again,				mine);
         System.out.println("Redo: "+again.redoneCommandToString()+" :");
         CI.execute(c_print, 			mine);

         CI.execute(whoops,			mine);
         System.out.println("Undo: "+whoops.undoneCommandToString()+" :");
         CI.execute(c_print, 			mine);

         CI.execute(whoops,			mine);
         System.out.println("Undo: "+whoops.undoneCommandToString()+" :");
         CI.execute(c_print, 			mine);

         CI.execute(whoops,			mine);
         System.out.println("Undo: "+whoops.undoneCommandToString()+" :");
         CI.execute(c_print, 			mine);

         CI.execute(whoops,			mine);
         System.out.println("Undo: "+whoops.undoneCommandToString()+" :");
         CI.execute(c_print, 			mine);

         CI.execute(again,				mine);
         System.out.println("Redo: "+again.redoneCommandToString()+" :");
         CI.execute(c_print, 			mine);

         CI.execute(plusTenTo20, 	mine);
         System.out.println("Plus 10 to 20:");
         CI.execute(c_print, 			mine);
         HE2C();

         CI.execute(again,				mine);
         System.out.println("Redo: "+again.redoneCommandToString()+" :");
         CI.execute(c_print, 			mine);

         CI.execute(whoops,			mine);
         System.out.println("Undo: "+whoops.undoneCommandToString()+" :");
         CI.execute(c_print, 			mine);

         CI.execute(whoops,			mine);
         System.out.println("Undo: "+whoops.undoneCommandToString()+" :");
         CI.execute(c_print, 			mine);

         CI.execute(whoops,			mine);
         System.out.println("Undo: "+whoops.undoneCommandToString()+" :");
         CI.execute(c_print, 			mine);

         CI.execute(whoops,			mine);
         System.out.println("Undo: "+whoops.undoneCommandToString()+" :");
         CI.execute(c_print, 			mine);
       /*
        System.out.println("\nHistory: \n"+CI.historyToString());

      CI.execute(plusTenTo20, 	mine);
         System.out.println("Plus 10 to 20:");
         CI.execute(c_print, 			mine);

         CI.execute(minusOneToAll, 	mine);
         System.out.println("Minus 1 to all:");
         CI.execute(c_print, 			mine);

      /**/
      }
      public static void HE2C(){
         System.out.print(">>>Hit enter key to continue<<<");
         try {System.in.read();}
            catch (IOException e){
            }
      }
   }