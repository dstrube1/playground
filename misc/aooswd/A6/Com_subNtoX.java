/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/*************
command object for subtracting some value to a particular elements in a given dataset
*************/
public class Com_subNtoX extends Command{
      private int n;   
      private int x;
   
      public Com_subNtoX(){
         n=0;
         x=0;
         op="";
      }
   
      public Com_subNtoX(int subtrahend, int index){
         n=subtrahend;
         x=index;
         op="subToX, "+n+", "+x;
      }
   
      public void doit(MyList dataset){
         int temp = dataset.get(x).intValue()-n;
         Integer i=new Integer(temp);
         dataset.set(x,i);
      }
   }