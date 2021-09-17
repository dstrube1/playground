public class Try
{
   
   public Try ()
   {
   }
   
   public static void main (String[] args)
   {
      if (args.length == 0)
         System.out.println ("go back to Athens");
      else
      {
         EmployeeFactory f;
         if (args[0].equals ("m"))
            f = new ManagerFactory();
         else
            f = new DeveloperFactory();
         Employee e = f.create();
         EmployeeWisdom w = new EmployeeWisdom ();
         w.displayWisdom (e);
      }
   }
   
}
