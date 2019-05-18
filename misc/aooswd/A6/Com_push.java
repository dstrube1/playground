/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/*************
command object for pushing an element onto a given dataset
*************/
public class Com_push extends Command{
      int n;
      public Com_push(int pushari){
         n=pushari;
         op="push, "+n;   
      }
      public void doit(MyList dataset){
         dataset.push(new Integer(n));
      }
   }
