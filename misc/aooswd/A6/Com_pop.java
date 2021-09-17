/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/*************
command object for popping an element from a given dataset
*************/
public class Com_pop extends Command{
      int n;
      public Com_pop(){   
         op="pop";
      }
      public void doit(MyList dataset){
         n=dataset.pop();
         op+=", "+n;
      }
   }
