//CharChecker.java
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 8 - State Pattern
***************/

   public class CharChecker{
      //public CharChecker(){
      //}
   
      public static boolean isE(Character c){
         Character e = new Character('e');
         Character E = new Character('E');
         return ((c.compareTo(e) == 0) || (c.compareTo(E) == 0));
      }	
   
      public static boolean isDot(Character c){
         return (c.compareTo(new Character('.')) == 0);
      }
      public static boolean isDollar(Character c){
         return (c.compareTo(new Character('$')) == 0);
      }
      public static boolean isDigit(Character c){
         return Character.isDigit(c.charValue());
      }
      public static boolean isDashOrPlus(Character c){
         Character m = new Character('-');
         Character p = new Character('+');
         return ((c.compareTo(m) == 0)||(c.compareTo(p) == 0));
      }
   }