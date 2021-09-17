with Memory_Block_Pak, Mem_Interface_Pak,Ada.Text_IO;
use Ada.Text_IO;

procedure Test is

  Memory_Size: Positive := 1000;
  
  package Memory_Pak is new Memory_Block_Pak (Memory_Size);
  use Memory_Pak;
   
  package Memory_Interface_Class is new Mem_Interface_Pak (Memory_Pak);
  use Memory_Interface_Class;
  
  Success: Boolean;
  B1, B2, B3, B4: Memory_Block;
  
  begin
    Allocation_Choice (Random);
    Display_Memory;
    New_Line;
    Allocate (40, Success, B1);
    Display_Memory;
    New_Line;
    Allocate (15, Success, B2);
    Display_Memory;
    New_Line;
    DeAllocate (B1);
    Display_Memory;
    New_Line;
    Allocate (10, Success, B3);
    Display_Memory;
    New_Line;
    Allocate (20, Success, B4);
    Display_Memory;
    New_Line;
    DeAllocate (B2);
    Display_Memory;
    New_Line;
    DeAllocate (B3);
    Display_Memory;
    New_Line;
    DeAllocate (B4);
    Display_Memory;
    New_Line;
  end Test;
