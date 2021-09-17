   import java.util.List;
   import java.util.ArrayList;
   import java.util.ListIterator;
   import java.util.NoSuchElementException;
	//http://java.sun.com/docs/books/tutorial/collections/interfaces/list.html

   public class LITest{
      public static void main (String[]args){
         List list = new ArrayList();
         List history = new ArrayList();
      	int i=0; 
         for (;i<20; i++){
            list.add(new Integer(i));
         }
      	int j=0;
         for (ListIterator LI = list.listIterator(); LI.hasNext();){ 
            LI.add(list.get(j++));
            System.out.println("In for: "+LI.next().toString());
         }
         ListIterator LI2= list.listIterator();
         System.out.println(LI2.next().toString());
         System.out.println(LI2.next().toString());
         try{
            System.out.println(LI2.next().toString());
         }
            catch(NoSuchElementException e){
               System.out.println("Ran out of list:"+e);
            }
      
      
      }
   }