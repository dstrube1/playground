/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/*************
command object for adding some value to all elements in a given dataset
*************/
public class Com_addNtoAll extends Command{
      private int n;   
      public Com_addNtoAll(){
         n=0;
         op="";
      }
   
      public Com_addNtoAll(int addend){
         n=addend;
         op="addToAll, "+n;
      }
   
      public void doit(MyList dataset){
      
         Integer i=new Integer(0);
         int temp;
         for (int j=0; j<dataset.size(); j++){
            temp=dataset.get(j).intValue()+n;
            i=new Integer(temp);
            dataset.set(j, i);
         }
      }
   
   }