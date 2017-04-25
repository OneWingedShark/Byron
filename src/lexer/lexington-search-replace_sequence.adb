With
Byron.Generics.Vector.Generic_Cursor,
Lexington.Token_Vector_Pkg.Tie_In;

Procedure Lexington.Search.Replace_Sequence(Data : in out Token_Vector_Pkg.Vector) is
    Package Cursors is new Lexington.Token_Vector_Pkg.Tie_In.Generic_Cursor
      (Container => Data);

--     Function Is_Match(Index : Positive) return Boolean is
--     begin
--        declare
--           subtype Proposed_Match is Positive range Index..Index+Sequence'Length-1;
--           subtype Shifted_Sequence is ID_Sequence(Proposed_Match);
--           Shifted : Shifted_Sequence
--             with Import, Address => Sequence'Address;
--           Use Aux.Token_Pkg;
--           Use all type Aux.Token_ID;
--        begin
--           return (for all Index in Proposed_Match => Shifted(Index) = ID(Data(Index)));
--        end;
--     exception
--        when Constraint_Error => return False;
--     end Is_Match;

    -- Returns true when the sequence IDs match.
    Function Match(Cursor : Cursors.Cursor;
		   ID_Set : ID_Sequence    := Sequence
		  ) return Boolean is
	Use Aux.Token_Pkg;
	Use type Aux.Token_ID;
    Begin
	Return Result : Constant Boolean :=
	  (if ID_Set'Length not in Positive then True
	    else ID_Set(ID_Set'First) = ID(Cursor.Element) and then
	    Match(Cursor.Succ,ID_Set(Positive'Succ(ID_Set'First)..ID_Set'Last))
	  );
    End Match;

    -- Constructs a new token from the sequence of tokens indicated in the parameter.
    Function Make_Token(Cursor : Cursors.Cursor) return Lexington.Aux.Token is
	Function Get_Text(
		   Cursor    : Cursors.Cursor := Make_Token.Cursor;
		   Remainder : Natural        := Sequence'Length
		  ) return Wide_Wide_String is
	  (if Remainder not in Positive then ""
	   else Lexington.Aux.Token_Pkg.Lexeme(Cursor.Element)
		    & Get_Text(Cursor.Succ, Remainder - 1)
	  );
    begin
	return Aux.Token_Pkg.Make_Token(Item_Type, Get_Text);
    end;

    -- Replaces the sequence at the indicated cursor with the indicated value.
    Procedure Replace_Sequence(Cursor   : in Cursors.Cursor;
			       New_Item : in Lexington.Aux.Token
			      ) is
	Procedure Replace is new Cursors.Replace_Element
	  ( Token_Vector_Pkg.Replace_Element );
	Procedure Delete is new Cursors.Generic_Delete
	  (Token_Vector_Pkg.Delete);
	use type Cursors.Cursor;
	Marker : Cursors.Cursor := Cursor.Succ;
    Begin
	Delete (Marker, Natural'Pred(Sequence'Length));
	Replace(Cursor, New_Item);
    End Replace_Sequence;


   Start_Index : Natural := Data.First_Index;
   Found_Index : Natural := 0;
begin
    -- If there's nothing to find, don't search.
    if Sequence'Length not in positive then
	return;
    end if;

    FIND:
    loop
	Found_Index:= Search.Index(Data, Start_Index, Sequence(Sequence'First));
	Exit when Found_Index = 0;

	TEST:
	declare
	    Cursor : Cursors.Cursor renames Cursors.To_Cursor(Found_Index);
	begin
	    if Match( Cursor ) then
		REPLACE:
		declare
		    Item : Aux.Token renames Make_Token(Cursor);
		begin
		    if Validator = null or else Validator(Aux.Token_Pkg.Lexeme(Item)) then
			Replace_Sequence(Cursor, Item);
		    end if;
		end REPLACE;
	    end if;
	end TEST;

	Start_Index:= Positive'Succ(Found_Index);
    end loop FIND;
End Lexington.Search.Replace_Sequence;
