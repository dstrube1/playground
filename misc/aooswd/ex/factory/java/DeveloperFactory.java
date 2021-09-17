public class DeveloperFactory extends EmployeeFactory
{
   
   public DeveloperFactory ()
   {
   }
   
   public Employee create ()
   {
      return new Developer();
   }
   
}
