package body Ordered_List_Pak_Gen is

  procedure Copy (Source: in Ordered_List; Dest: in out Ordered_List) is
  
    begin
      List_Pak.Copy (Source => Source.L, Dest => Dest.L);
      exception
        when Out_Of_Memory =>
          raise Out_Of_Memory;
    end Copy;

  function Current_Item (L: in Ordered_List; P: in Position) return Item is
  
    begin
      return List_Pak.Current_Item (L => L.L, P => List_Pak.Position (P));
      exception
        when List_Pak.Empty =>
          raise Empty;
        when List_Pak.Off_List =>
          raise Off_List;
    end Current_Item;

  procedure Delete (L: in out Ordered_List; P: in out Position) is
  
    begin
      List_Pak.Delete (L => L.L, P => List_Pak.Position (P));
      exception
        when List_Pak.Empty =>
          raise Empty;
        when List_Pak.Off_List =>
          raise Off_List;
    end Delete;

  procedure Delete_At_End (L: in out Ordered_List) is
  
    begin
      List_Pak.Delete_At_End (L => L.L);
      exception
        when List_Pak.Empty =>
          raise Empty;
    end Delete_At_End;

  procedure Delete_At_Front (L: in out Ordered_List) is
  
    begin
      List_Pak.Delete_At_Front (L => L.L);
      exception
        when List_Pak.Empty =>
          raise Empty;
    end Delete_At_Front;

  function First (L: in Ordered_List) return Position is
  
    begin
      return Position (List_Pak.First (L => L.L));
      exception
        when List_Pak.Empty =>
          raise Empty;
    end First;

  procedure Initialize (L: in out Ordered_List) is
  
    begin
      List_Pak.Initialize (L => L.L);
    end Initialize;

  procedure Insert (L: in out Ordered_List; Datum: in Item) is
    
    begin
      if Is_Empty (L => L) then
        List_Pak.Insert_At_Front (L => L.L, Datum => Datum);
      else
        declare
          Previous: Position;
          Current: Position := First (L => L);
        begin
          if Datum < Current_Item (L => L, P => Current) then
            List_Pak.Insert_At_Front (L => L.L, Datum => Datum);
          else
            while not Is_Off_List (L => L, P => Current) and then
              Current_Item (L => L, P => Current) < Datum  loop
              Previous := Current;
              Next (L => L, P => Current);
            end loop;
            List_Pak.Insert (L => L.L, P => List_Pak.Position (Previous),
              Datum => Datum);
          end if;
        end;
      end if;
    end Insert;

  function Is_Empty (L: in Ordered_List) return Boolean is
  
    begin
      return List_Pak.Is_Empty (L => L.L);
    end Is_Empty;
 
  function Is_First (L: in Ordered_List; P: in Position) return Boolean is
  
    begin
      return List_Pak.Is_First (L => L.L, P => List_Pak.Position (P));
    end Is_First;

  function Is_Last (L: in Ordered_List; P: in Position) return Boolean is
  
    begin
      return List_Pak.Is_Last (L => L.L, P => List_Pak.Position (P));
    end Is_Last;

  function Is_Off_List (L: in Ordered_List; P: in Position) return Boolean is
  
    begin
      return List_Pak.Is_Off_List (L => L.L, P => List_Pak.Position (P));
    end Is_Off_List;

  function Last (L: in Ordered_List) return Position is
  
    begin
      return Position (List_Pak.Last (L => L.L));
      exception
        when List_Pak.Empty =>
          raise Empty;
    end Last;

  procedure Modify_Current_Item (L: in out Ordered_List; P: in Position;
    New_Item: in Item) is
    
    begin
      if Is_Empty (L => L) then
        raise Empty;
      end if;
      if Is_Off_List (L => L, P => P) then
        raise Off_List;
      end if;
      if not Is_First (L => L, P => P) then
        declare
          Temp: Position := P;
        begin
          Prev (L => L, P => Temp);
          if New_Item < Current_Item (L => L, P => Temp) then
            raise Out_Of_Order;
          end if;
        end;
      end if;
      if not Is_Last (L => L, P => P) then
        declare
          Temp: Position := P;
        begin
          Next (L => L, P => Temp);
          if Current_Item (L => L, P => Temp) < New_Item then
            raise Out_Of_Order;
          end if;
        end;
      end if;
      declare
        X: Item_Access := List_Pak.Current_Item (L => L.L, P => List_Pak.Position (P));
      begin
        X.all := New_Item;
      end;
    end Modify_Current_Item;

  procedure Next (L: in Ordered_List; P: in out Position) is
  
    begin
      List_Pak.Next (L => L.L, P => List_Pak.Position (P));
      exception
        when List_Pak.Empty =>
          raise Empty;
        when List_Pak.Off_List =>
          raise Off_List;
    end Next;

  procedure Prev (L: in Ordered_List; P: in out Position) is
  
    begin
      List_Pak.Prev (L => L.L, P => List_Pak.Position (P));
      exception
        when List_Pak.Empty =>
          raise Empty;
        when List_Pak.Off_List =>
          raise Off_List;
    end Prev;

  procedure Print (F: in File_Type; L: in Ordered_List) is
  
    begin
      List_Pak.Print (F => F, L => L.L);
    end Print;

  procedure Search (L: in Ordered_List; Datum: in Item; Found: out Boolean;
    Location: out Position) is
    
    begin
      if Is_Empty (L => L) then
        Found := False;
      else
        Location := First (L => L);
        loop
          if Is_Off_List (L => L, P => Location) then
            Found := False;
            exit;
          elsif Datum < Current_Item (L => L, P => Location) then
            Found := False;
            exit;
          elsif Datum = Current_Item (L => L, P => Location) then
            Found := True;
            exit;
          else
            Next ( L => L, P => Location);
          end if;
        end loop;
      end if;
    end Search;

end Ordered_List_Pak_Gen;

