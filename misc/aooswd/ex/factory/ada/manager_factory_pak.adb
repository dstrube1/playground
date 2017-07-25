with Manager_Pak;

package body Manager_Factory_Pak is

   function Create (M: in Manager_Factory) return Employee_Pak.Employee_Access is
      
   begin
      return new Manager_Pak.Manager;
   end Create;

end Manager_Factory_Pak;

