with
Ada.Strings.Wide_Wide_Unbounded;

Procedure Lexington.Search.Replace_Sequence(Data : in out Token_Vector_Pkg.Vector) is
   Function Is_Match(Index : Positive) return Boolean is
   begin
      declare
         subtype Proposed_Match is Positive range Index..Index+Sequence'Length-1;
         subtype Shifted_Sequence is ID_Sequence(Proposed_Match);
         Shifted : Shifted_Sequence
           with Import, Address => Sequence'Address;
         Use Aux.Token_Pkg;
         Use all type Aux.Token_ID;
      begin
         return (for all Index in Proposed_Match => Shifted(Index) = ID(Data(Index)));
      end;
   exception
      when Constraint_Error => return False;
   end Is_Match;

   Function Make_Token(Index : Positive) return Lexington.Aux.Token is
      use Ada.Strings.Wide_Wide_Unbounded;
      Text : Unbounded_Wide_Wide_String;
   begin
      for Count in Index..Index+Sequence'Length-1 loop
         Append( Text, Aux.Token_Pkg.Lexeme(Data(Count)) );
      end loop;

      return Aux.Token_Pkg.Make_Token(Item_Type, To_Wide_Wide_String(Text));
   end;


   Start_Index : Natural := Data.First_Index;
   Found_Index : Natural := 0;
begin
   loop
      Found_Index:= Search.Index(Data, Start_Index, Sequence(Sequence'First));
      Exit when Found_Index = 0;
      if Is_Match( Found_Index ) then
         declare
            Item : Aux.Token renames Make_Token(Found_Index);
         begin
            if Validator = null or else Validator(Aux.Token_Pkg.Lexeme(Item)) then
               Data.Delete(Index => Found_Index, Count => Sequence'Length);
               Data.Insert(Before=> Found_Index, New_Item => Item);
            end if;
         end;
      end if;
      Start_Index:= Positive'Succ(Found_Index);
   end loop;
End Lexington.Search.Replace_Sequence;
