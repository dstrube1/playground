with Ada.Text_IO; use Ada.Text_IO;

package body Memory_Manager_Pak is

  procedure Allocate (M: in out Memory_Manager; Size: in Block_Size;
    Success: out Boolean; Block: out Memory_Block) is
    
    begin
      Mem_Allocation_Pak.Allocate (M => M.A.all, L => M.L.all, Size => Size,
        Success => Success, Block => Block);
    end Allocate;

  procedure Coalesce_Front (L: in out Ordered_List; P: in Position;
    B: in Memory_Block) is
    
    New_B: Memory_Block := Create (Lower => Lower_Limit (B => B),
      Upper => Upper_Limit (B => Current_Item (L => L, P => P)));
      
    begin
      Modify_Current_Item (L => L, P => P, New_Item => New_B);
    end Coalesce_Front;

  procedure Coalesce_Rear (L: in out Ordered_List; P: in Position;
    B: in Memory_Block) is
    
    New_B: Memory_Block := Create (Lower => Lower_Limit (B => Current_Item (L => L, P => P)),
      Upper => Upper_Limit (B => B));
      
    begin
      Modify_Current_Item (L => L, P => P, New_Item => New_B);
    end Coalesce_Rear;
    
  procedure Coalesce_Both (L: in out Ordered_List; P_First, P_Second: in out Position) is
    
    New_B: Memory_Block := Create (Lower => Lower_Limit (B => Current_Item (L => L, P => P_First)),
      Upper => Upper_Limit (B => Current_Item (L => L, P => P_Second)));
      
    begin
      Modify_Current_Item (L => L, P => P_First, New_Item => New_B);
      Delete (L => L, P => P_Second);
    end Coalesce_Both;

  procedure Insert_At_End (L: in out Ordered_List; B: in Memory_Block) is

    begin
      if Upper_Limit (B => Current_Item (L => L, P => Last (L => L))) + 1 =
        Lower_Limit (B => B) then
        Coalesce_Front (L => L, P => Last (L => L), B => B);
      else
        Insert (L => L, Datum => B);
      end if;
    end Insert_At_End;

  procedure Insert_Before (L: in out Ordered_List; P: in out Position; B: in Memory_Block) is
  
    Previous: Position := P;
    
    begin
      Prev (L => L, P => Previous);
      if Is_Off_List (L => L, P => Previous) or else Upper_Limit (B => Current_Item (L => L, P => Previous))
        + 1 /= Lower_limit (B => B) then
        if Upper_Limit (B => B) + 1 = Lower_Limit (B => Current_item (L => L, P => P)) then
          Coalesce_Front (L => L, P => P, B => B);
        else
          Insert (L => L, Datum => B);
        end if;
      elsif Upper_Limit (B => B) + 1 = Lower_Limit (B => Current_Item (L => L, P => P)) then
        Coalesce_Both (L => L, P_First => Previous, P_Second => P);
      else
        Coalesce_Rear (L => L, P => Previous, B => B);
      end if;
    end Insert_Before;

  procedure DeAllocate (M: in out Memory_Manager; Block: in Memory_Block) is
   
    function "=" (B1, B2: in Memory_Block) return Boolean is
    
      begin
        return Upper_Limit (B => B1) < Lower_Limit (B => B2);
      end "=";
      
    procedure DeAllocate_Search is new Search ("=");
    
    begin
      if Is_Empty (L => M.L.all) then
        Insert (L => M.L.all, Datum => Block);
      else
        declare
          Found: Boolean;
          P: Position;
        begin
          DeAllocate_Search (L => M.L.all, Datum => Block, Found => Found, Location => P);
          if Is_Off_List (L => M.L.all, P => P) then
            Insert_At_End (L => M.L.all, B => Block);
          else
            Insert_Before (L => M.L.all, P => P, B => Block);
          end if;
        end;
      end if;
    end DeAllocate;
    
  procedure Display_Memory (M: in Memory_Manager) is
  
    begin
      Print (F => Standard_Output, L => M.L.all);
    end Display_Memory;

  procedure Allocation_Choice (M: in out Memory_Manager; Choice: in Allocation_Type) is
  
    begin
      case Choice is
        when First =>
          M.A := new First_Fit_Allocation_Pak.First_Fit_Allocation;
        when Best =>
          M.A := new Best_Fit_Allocation_Pak.Best_Fit_Allocation;
        when Worst =>
          M.A := new Worst_Fit_Allocation_Pak.Worst_Fit_Allocation;
        when Random =>
          M.A := new Random_Fit_Allocation_Pak.Random_Fit_Allocation;
      end case;
    end Allocation_Choice;
    
end Memory_Manager_Pak;

