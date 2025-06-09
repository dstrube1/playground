package body Memory_Allocation_Pak.Worst_Fit is

  procedure Allocate (M: in Worst_Fit_Allocation; L: in out Ordered_List;
    Size: in Block_Size; Success: out Boolean; Block: out Memory_Block) is
    
    begin
      Success := False;
      if not Is_Empty (L => L) then
        declare
          P: Position := First (L => L);
          Worst: Position;
        begin
          while not Is_Off_List (L => L, P => P) loop
            if Memory_Pak.Size (Current_Item (L => L, P => P)) >= Size then
              if not Success then
                Success := True;
                Worst := P;
              elsif Memory_Pak.Size (Current_Item (L => L, P => P)) >
                Memory_Pak.Size (Current_Item (L => L, P => Worst)) then
                Worst := P;
              end if;
            end if;
            Next (L => L, P => P);
          end loop;
          if Success then
            Allocate_Block (L => L, P => Worst, Size => Size, Block => Block);
          end if;
        end;
      end if;
    end Allocate;

end Memory_Allocation_Pak.Worst_Fit;

