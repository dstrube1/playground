with Ada.Command_Line;
with Ada.Text_Io;
with Employee_Factory_Pak;
with Employee_Pak;
with Manager_Factory_Pak;
with Developer_Factory_Pak;
with Employee_Wisdom_Pak;

procedure Try is
   
begin
   if Ada.Command_Line.Argument_Count = 0 then
      Ada.Text_IO.Put_Line ("go back to Athens");
   else
      declare
         F: Employee_Factory_Pak.Employee_Factory_Access;
         E: Employee_Pak.Employee_Access;
      begin
         if Ada.Command_Line.Argument (1) = "m" then
            F := new Manager_Factory_Pak.Manager_Factory;
         else
            F := new Developer_Factory_Pak.Developer_Factory;
         end if;
         E := Employee_Factory_Pak.Create (F.All);
         Employee_Wisdom_Pak.Display_Wisdom (E.all);
      end;
   end if;   
end Try;
