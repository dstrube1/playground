with Unchecked_Deallocation;

package body List_Pak_Gen is

  procedure Dispose is new Unchecked_Deallocation (Node, Position);
  
  function Allocate_Node (Datum: in Item; Link: Position := null) return Position is
  
    Temp: Position := new Node' (Datum => Datum, Link => Link);
    
    begin
      return Temp;
      exception
        when Storage_Error =>
          raise Out_Of_Memory;
    end Allocate_Node;
    
  procedure Copy (Source: in List; Dest: in out List) is
  
    begin
      Initialize (L => Dest);
      if not Is_Empty (L => Source) then
        declare
          Temp_Source: Position := First (L => Source);
          Temp_Dest: Position;
        begin
          Dest.Head := Allocate_Node (Datum => Current_Item (L => Source, P => Temp_Source));
          Temp_Dest := Dest.Head;
          Next (L => Source, P => Temp_Source);
          while not Is_Off_List (L => Source, P => Temp_Source) loop
            Temp_Dest.Link := Allocate_Node (Datum => Current_Item (L => Source, P => Temp_Source));
            Next (L => Dest, P => Temp_Dest);
            Next (L => Source, P => Temp_Source);
          end loop;
        end;
      end if;
    end Copy;

  function Current_Item (L: in List; P: in Position) return Item is
  
    begin
      if Is_Empty (L => L) then
        raise Empty;
      end if;
      if Is_Off_List (L => L, P => P) then
        raise Off_List;
      end if;
      return P.Datum;
    end Current_Item;

  function Current_Item (L: in List; P: in Position) return Item_Access is
  
    begin
      if Is_Empty (L => L) then
        raise Empty;
      end if;
      if Is_Off_List (L => L, P => P) then
        raise Off_List;
      end if;
      return P.Datum'Access;
    end Current_Item;
    
  procedure Delete (L: in out List; P: in out Position) is
  
    begin
      if Is_Empty (L => L) then
        raise Empty;
      end if;
      if Is_Off_List (L => L, P => P) then
        raise Off_List;
      end if;
      if Is_First (L => L, P => P) then
        Delete_At_Front (L => L);
      else
        declare
          Temp: Position := P;
        begin
          Prev (L => L, P => Temp);
          Temp.Link := P.Link;
          Dispose (P);
        end;
      end if;
    end Delete;

  procedure Delete_At_End (L: in out List) is
  
    begin
      if Is_Empty (L => L) then
        raise Empty;
      end if;
      declare
        P: Position := First (L => L);
        Temp: Position;
      begin
        if Is_Off_List (L => L, P => P) then
          L.head := null;
        else
          while not Is_Last (L => L, P => P) loop
            Temp := P;
            Next (L => L, P => P);
          end loop;
          Temp.Link := null;
          Dispose (P);
        end if;
      end;
    end Delete_At_End;

  procedure Delete_At_Front (L: in out List) is
  
    begin
      if Is_Empty (L => L) then
        raise Empty;
      end if;
      declare
        Temp: Position := First (L => L);
      begin
        L.Head := Temp.Link;
        Dispose (Temp);
      end;
    end Delete_At_Front;

  function First (L: in List) return Position is
  
    begin
      if Is_Empty (L => L) then
        raise Empty;
      end if;
      return L.Head;
    end First;

  function Is_First (L: in List; P: in Position) return Boolean is
  
    begin
      return not Is_Empty (L => L) and then P = L.Head;
    end Is_First;

  procedure Initialize (L: in out List) is
  
    Temp: Position := L.Head;
    Prev: Position;
    
    begin
      while not Is_Off_List (L => L, P => Temp) loop
        Prev := Temp;
        Next (L => L, P => Temp);
        Dispose (Prev);
      end loop;
      L.Head := null;
    end Initialize;

  procedure Insert (L: in out List; P: in Position; Datum: in Item) is
  
    begin
      if Is_Empty (L => L) then
        raise Empty;
      end if;
      if Is_Off_List (L => L, P => P) then
        raise Off_List;
      end if;
      declare
        Temp: Position := Allocate_Node (Datum => Datum, Link => P.Link);
      begin
        P.Link := Temp;
      end;
    end Insert;

  procedure Insert_At_End (L: in out List; Datum: in Item) is
  
    begin
      if Is_Empty (L => L) then
        Insert_At_Front (L => L, Datum => Datum);
      else
        declare
          P: Position := Last (L => L);
          Temp: Position := Allocate_Node (Datum => Datum);
        begin
          P.Link := Temp;
        end;
      end if;
    end Insert_At_End;

  procedure Insert_At_Front (L: in out List; Datum: in Item) is
  
    Temp: Position := Allocate_Node (Datum => Datum, Link => L.Head);
    
    begin
      L.Head := Temp;
    end Insert_At_Front;

  function Is_Empty (L: in List) return Boolean is
  
    begin
      return L.Head = null;
    end Is_Empty;

  function Is_Off_List (L: in List; P: in Position) return Boolean is
   
    begin
      return P = null;
    end Is_Off_List;

  function Last (L: in List) return Position is
  
    begin
      if Is_Empty (L => L) then
        raise Empty;
      end if;
      declare
        P: Position := First (L => L);
      begin
        while not Is_Last (L => L, P => P) loop
          Next (L => L, P => P);
        end loop;
        return P;
      end;
    end Last;

  function Is_Last (L: in List; P: in Position) return Boolean is
  
    Result: Boolean;
    
    begin
      if Is_Empty (L => L) then
        Result := False;
      elsif Is_Off_List (L => L, P => P) then
        Result := False;
      else
        Result := P.Link = null;
      end if;
      return Result;
    end Is_Last;

  procedure Next (L: in List; P: in out Position) is
  
    begin
      if Is_Empty (L => L) then
        raise Empty;
      end if;
      if Is_Off_List (L => L, P => P) then
        raise Off_List;
      end if;
      P := P.Link;
    end Next;

  procedure Prev (L: in List; P: in out Position) is
  
    begin
      if Is_Empty (L => L) then
        raise Empty;
      end if;
      if Is_Off_List (L => L, P => P) then
        raise Off_List;
      end if;
      if L.Head = P then
        P := null;
      else
        declare
          Temp: Position := First (L => L);
        begin
          while Temp.Link /= P loop
            Next (L => L, P => Temp);
          end loop;
          P := Temp;
        end;
      end if;
    end Prev;
 
  procedure Print (F: in File_Type; L: in List) is
  
    begin
      if not Is_Empty (L => L) then
        declare
          P: Position := First (L => L);
        begin
          while not Is_Off_List (L => L, P => P) loop
            Put (File => F, Datum => P.Datum);
            New_Line (File => F);
            Next (L => L, P => P);
          end loop;
        end;
      end if;
    end Print;

  procedure Search (L: in List; Datum: in Item; Found: out Boolean;
    Location: out Position) is
    
    begin
      Location := First (L => L);
      loop
        if Is_Off_List (L => L, P => Location) then
          Found := False;
          exit;
        elsif Current_Item (L => L, P => Location) = Datum then
          Found := True;
          exit;
        else
          Next (L => L, P => Location);
        end if;
      end loop;
    end Search;

end List_Pak_Gen;

