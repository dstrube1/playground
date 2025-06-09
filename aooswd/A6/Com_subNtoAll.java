/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/*************
command object for subtracting some value to all elements in a given dataset
*************/
public class Com_subNtoAll extends Command{
      int n;
      public Com_subNtoAll(){
         n=0;
         op="";
      }
   
      public Com_subNtoAll(int subtrahend){
         n=subtrahend;
         op="subToAll, "+n;
      }
   
      public void doit(MyList dataset){
      
         Integer i=new Integer(0);
         int temp;
         for (int j=0; j<dataset.size(); j++){
            temp=dataset.get(j).intValue()-n;
            i=new Integer(temp);
            dataset.set(j, i);
         }
      }
   
   
   }