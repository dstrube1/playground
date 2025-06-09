   public class StringTest{
      public static void main (String[]args){
         String blah="blah";
      	System.out.println(blah+" "+blah.indexOf(",")+" "+blah.lastIndexOf(","));
Integer i = new Integer(blah.substring(blah.indexOf(",")));
      }
   }