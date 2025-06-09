/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 6 - Command Pattern
***************/

/************************
data set which supports the following operations:

push back (increase the size by 1 adding the new element at the end)
pop back (decrease the size by 1 by removing the last position)
set (write to a particular location)
get (read from a particular location)
toString (give a string representation of the structure)
***********************/  
   import java.util.List;
   import java.util.ArrayList;
   class MyList{
      private List myL;
      public MyList(){
         myL=new ArrayList();
      }
   
      public int size(){
         return myL.size();}   
   
      public void push(Integer arg){
         myL.add(arg);
      }
      public int pop(){
         int result=0;
         if (myL.size()>0)
            result=( (Integer)myL.remove(myL.size()-1) ).intValue();
         return result;}
   
      public void set(int index, Object element){
         try{
            myL.set(index, element);
         }
            catch(IndexOutOfBoundsException e){
               System.out.println("Set error:");
               System.out.println(e);
            }
      }
   
      public Integer get(int index){
         Integer i = new Integer(0);
         try{
            i = new Integer(myL.get(index).toString());
         }
            catch(IndexOutOfBoundsException e){
               System.out.println("Get error:");
               System.out.println(e);
            }
         return i;}
   
      public String toString(){
         String temp = new String("");
         for (int i=0; i<myL.size(); i++){
            temp+=myL.get(i).toString()+" ";
         }
         return temp;}
   
      public List getList(){
         return myL;}
   }