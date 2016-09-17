Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Characters.Wide_Wide_Latin_1;

-- Normalizes line endings.
Procedure Lexington.Aux.P2(Data : in out Token_Vector_Pkg.Vector) is
    Use Lexington.Aux.Token_Pkg;

   Package L renames Ada.Characters.Wide_Wide_Latin_1;

   Function Is_EOL( Index : Positive; CR : Boolean ) return Boolean is
      Item  : Token  renames Data(Index);
      Value : Wide_Wide_String renames Lexeme(Item);
      WS    : constant Boolean := ID(Item) = Whitespace;
   Begin
      return WS and then Value(Value'First) = (if CR then L.CR else L.LF);
   End Is_EOL;

   Index : Positive;
Begin
   if Data.Is_Empty then
      return;
   end if;

   -- RFC822-style (CRLF)
   Index:= Data.First_Index;
   loop
      exit when Index >= Data.Last_Index-1;
      if Is_EOL(Index, True) and then Is_EOL(Index+1,False) then
         Data.Replace_Element(
            Index    => Index,
            New_Item => Make_Token(End_of_Line, "")
           );
         Data.Delete(Index+1);
      end if;

      Index:= Positive'Succ( Index );
   end loop;

   -- Unix and Apple (LF & CR)
   For Index in Data.First_Index..Data.Last_Index loop
      if Is_EOL(Index, True) or Is_EOL(Index,False) then
         Data.Replace_Element(
            Index    => Index,
            New_Item => Make_Token(End_of_Line, "")
           );
      end if;
   end loop;

End Lexington.Aux.P2;
