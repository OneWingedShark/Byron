Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Generics.Updater,
Lexington.Token_Vector_Pkg.Tie_In,
Ada.Characters.Wide_Wide_Latin_1;

-- Normalizes line endings.
Procedure Lexington.Aux.P2(Data : in out Token_Vector_Pkg.Vector) is
    Use Lexington.Aux.Token_Pkg;

   Package L renames Ada.Characters.Wide_Wide_Latin_1;

    -- Returns TRUE when the Item at Index is WHITESPACE *AND*
    -- Matches the indicated termination-character. (CR is default.)
   Function Is_EOL( Item  : Token;    CR : Boolean ) return Boolean;
   Function Is_EOL( Index : Positive; CR : Boolean ) return Boolean is
      ( Is_EOL(Data(Index), CR) );


   Function Is_EOL( Item : Token; CR : Boolean ) return Boolean is
      Value : Wide_Wide_String renames Lexeme(Item);
      WS    : constant Boolean := ID(Item) = Whitespace;
   Begin
      return WS and then Value(Value'First) = (if CR then L.CR else L.LF);
   End Is_EOL;


    Function Handle_Unix_and_Apple( Item : in Token ) Return Token is
	(if Is_EOL(Item, True) or Is_EOL(Item, False)
	 then Make_Token(End_of_Line, "") else Item);


    Procedure Handle_LF is new Byron.Generics.Updater(
       Vector_Package  => Lexington.Token_Vector_Pkg.Tie_In,
       Replace_Element => Lexington.Token_Vector_Pkg.Replace_Element,
       Operation       => Handle_Unix_and_Apple
      );

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
   Handle_LF( Data );

End Lexington.Aux.P2;
