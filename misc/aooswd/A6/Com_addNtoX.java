/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/*************
command object for adding some value to a particular elements in a given dataset
*************/
public class Com_addNtoX extends Command{
      private int n;   
      private int x;
      public Com_addNtoX(){
         n=0;
         x=0;
         op="";
      }
   
      public Com_addNtoX(int addend, int index){
         n=addend;
         x=index;
         op="addToX, "+n+", "+x;
      }
      public void doit(MyList dataset){
         int temp = dataset.get(x).intValue()+n;
         Integer i=new Integer(temp);
         dataset.set(x,i);
      }
   
   }