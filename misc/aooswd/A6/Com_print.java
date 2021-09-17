/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/*************
command object for printing a given dataset
*************/
public class Com_print extends Command{
      public Com_print(){
         op="print";   
      }
      public void doit(MyList dataset){
         System.out.println(dataset.toString());
      }
   }
