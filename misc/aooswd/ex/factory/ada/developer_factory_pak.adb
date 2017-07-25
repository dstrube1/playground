with Developer_Pak;

package body Developer_Factory_Pak is

   function Create (F: in Developer_Factory) return Employee_Pak.Employee_Access is
      
   begin
      return new Developer_Pak.Developer;
   end Create;

end Developer_Factory_Pak;

