with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Memory_Block_Pak is

  function Create (Lower, Upper: in Address) return Memory_Block is
  
    B: Memory_Block;
    
    begin
      if Upper < Lower then
        raise Address_Order_Error;
      end if;
      B.Lower := Lower;
      B.Upper := Upper;
      return B;
    end Create;

  function Lower_Limit (B: in Memory_Block) return Address is
  
    begin
      return B.Lower;
    end Lower_Limit;

  function Size (B: in Memory_Block) return Block_Size is
  
    begin
      return B.Upper - B.Lower + 1;
    end Size;

  function Upper_Limit (B: in Memory_Block) return Address is
  
    begin
      return B.Upper;
    end Upper_Limit;

  procedure Put (File: in File_Type; B: in Memory_Block) is
  
    begin
      Put (B.Lower,0);
      Put ("::");
      Put (B.Upper,0);
    end Put;

  function ">" (B1, B2: in Memory_Block) return Boolean is
  
    begin
      return B2.Upper < B1.Lower;
    end ">";
 
end Memory_Block_Pak;

