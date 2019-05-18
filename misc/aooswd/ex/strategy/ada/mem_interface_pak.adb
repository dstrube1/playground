with Ordered_List_Pak_Gen, Memory_Allocation_Pak.Random_Fit, Memory_Manager_Pak,
  Memory_Allocation_Pak.First_Fit, Memory_Allocation_Pak.Worst_Fit,
  Memory_Allocation_Pak.Best_Fit;

package body Mem_Interface_Pak is

  package Free_List_Pak is new Ordered_List_Pak_Gen (Memory_Pak.Memory_Block,
    Memory_Pak.Memory_Block_Access, Memory_Pak.Put, Memory_Pak.">");   
  use Free_List_Pak;
  
  package Mem_Allocation_Pak is new Memory_Allocation_Pak (Memory_Pak, Free_List_Pak);
  use Mem_Allocation_Pak;
  
  package Random_Fit_Allocation_Pak is new Mem_Allocation_Pak.Random_Fit;
  
  package First_Fit_Allocation_Pak is new Mem_Allocation_Pak.First_Fit;
  
  package Best_Fit_Allocation_Pak is new Mem_Allocation_Pak.Best_Fit;
  
  package Worst_Fit_Allocation_Pak is new Mem_Allocation_Pak.Worst_Fit;
   
  package Mem_Manager_Pak is new Memory_Manager_Pak (Memory_Pak, Free_List_Pak, Mem_Allocation_Pak,
    First_Fit_Allocation_Pak, Worst_Fit_Allocation_Pak, Best_Fit_Allocation_Pak,
    Random_Fit_Allocation_Pak);
    
  use Mem_Manager_Pak;
 
  M: Memory_Manager;
  B: Memory_Block := Create (Lower => 0, Upper => Memory_Size - 1);
  
  procedure Allocate (Size: in Block_Size; Success: out Boolean;
    Block: out Memory_Block) is
  
    begin
      Allocate (M => M, Size => Size, Success => Success, Block => Block);
    end Allocate;

  procedure DeAllocate (Block: in Memory_Block) is
 
    begin
      DeAllocate (M => M, Block => Block);
    end DeAllocate;
    
  procedure Display_Memory is
  
    begin
      Display_Memory (M => M);
    end Display_Memory;

  procedure Allocation_Choice (Choice: in Allocation_Type) is
  
    Selection: Mem_Manager_Pak.Allocation_Type := 
      Mem_Manager_Pak.Allocation_Type'Val (Allocation_Type'Pos (Choice));
    
    begin
      Allocation_Choice (M => M, Choice => Selection);
    end Allocation_Choice;
    
begin
  Allocation_Choice (Choice => First);
  DeAllocate (M => M, Block => B);
end Mem_Interface_Pak;

