package body Memory_Allocation_Pak.First_Fit is

  procedure Allocate (M: in First_Fit_Allocation; L: in out Ordered_List;
    Size: in Block_Size; Success: out Boolean; Block: out Memory_Block) is
 
    P: Position;
    B: Memory_Block := Create (Lower => 0, Upper => Size - 1);
    
    function "=" (B1, B2: in Memory_Block) return Boolean is
    
      begin
        return Memory_Pak.Size (B => B1) < Memory_Pak.Size (B => B2);
      end "=";
      
    procedure Allocate_Search is new Search ("=");
      
    begin
      Allocate_Search (L => L, Datum => B, Found => Success, Location => P);
      Success := not Is_Off_List (L => L, P => P);
      if Success then
        Allocate_Block (L => L, P => P, Size => Size, Block => Block);
      end if;
    end Allocate;

end Memory_Allocation_Pak.First_Fit;

