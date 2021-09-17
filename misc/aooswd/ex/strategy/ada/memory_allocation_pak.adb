package body Memory_Allocation_Pak is

  procedure Allocate_Block (L: in out Ordered_List; P: in out Position;
    Size: in Block_Size; Block: out Memory_Block) is
    
    begin
      if Memory_Pak.Size (Current_Item (L => L, P => P)) = Size then
        Block := Current_Item (L => L, P => P);
        Delete (L => L, P => P);
      else
        declare
          Addr: Address := Lower_Limit (B => Current_Item (L => L, P => P));
          B1: Memory_Block := Create (Lower => Addr + Size, Upper =>
            Upper_Limit (B => Current_Item (L => L, P => P)));
        begin
          Block := Create (Lower => Addr, Upper => Addr + Size - 1);
          Modify_Current_Item (L => L, P => P, New_Item => B1);
        end;
      end if;
    end Allocate_Block;

end Memory_Allocation_Pak;

