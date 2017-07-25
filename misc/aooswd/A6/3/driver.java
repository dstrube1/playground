/********************
generate commands (including some undo & redo commands)
display the data set using the toString operation after each command is executed
********************/		

   class driver{
      public static void main(String args[]){
         MyList mine = new MyList();
         Command plusOneToAll 	= new Command("addToAll, 1");
         Command plusTenTo20 		= new Command("addToX, 10, 20");
         Command whoops 			= new Command("undo");
         Command again 				= new Command("redo");
         Command whoops2 			= new Command(whoops);
         Command minusOneToAll 	= new Command("subToAll, 1");
         Command minus20ToTen 	= new Command("subToX, 20, 10");
         Command c_print 			= new Command("print");
      
         CommandInvoker CI = new CommandInvoker();
      
         Integer i=new Integer(0);
         for (int j=0; j<25; j++){
            i=new Integer(j);
            mine.push(i);
         }
      
         System.out.println("Initial data set: ");
         CI.execute(c_print, 			mine);
      
         CI.execute(plusOneToAll, 	mine);
         System.out.println("Plus 1 to all:");
         CI.execute(c_print, 			mine);
      
         CI.execute(plusTenTo20, 	mine);
         System.out.println("Plus 10 to position 20:");
         CI.execute(c_print, 			mine);
      
         CI.execute(minusOneToAll, 	mine);
         System.out.println("Minus 1 to all:");
         CI.execute(c_print, 			mine);
      
         CI.execute(minus20ToTen, 	mine);
         System.out.println("Minus 20 to position 10:");
         CI.execute(c_print, 			mine);
      
         CI.execute(again,				mine);
         System.out.println("Redo:");
         CI.execute(c_print, 			mine);
      
         //System.out.println("History: \n"+CI.historyToString());
      
         CI.execute(whoops2,			mine);
         System.out.println("Undo:");
         CI.execute(c_print, 			mine);
      
         CI.execute(whoops2,			mine);
         System.out.println("Undo:");
         CI.execute(c_print, 			mine);
      
         CI.execute(whoops2,			mine);
         System.out.println("Undo:");
         CI.execute(c_print, 			mine);
      
      }
   }