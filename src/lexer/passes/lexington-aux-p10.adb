Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Ada.Unchecked_Conversion,
Byron.Internals.SPARK.Pure_Types;

Procedure Lexington.Aux.P10(Data : in out Token_Vector_Pkg.Vector) is
    Use Lexington.Aux.Token_Pkg;

    Pragma Assert( Wide_Wide_String'Component_Size =
		     Byron.Internals.SPARK.Pure_Types.Identifier'Component_Size,
		   "ERROR: Internal-string character-size mismatch!"
		  );

    -- Validate the identifier.
    Function Is_Valid( Input: Wide_Wide_String ) return Boolean;

    -- View an Identifier as a subtype of Wide_Wide_String.
    Subtype Identifier is Wide_Wide_String
      with Dynamic_Predicate => Is_Valid( Identifier );

    Function Is_Valid( Input: Wide_Wide_String ) return Boolean is
	Use Byron.Internals.SPARK;
	Subtype Constrained_WWS is Wide_Wide_String(Input'range);
	Subtype Constrained_ID  is Pure_Types.Identifier(Input'Range);

	Function Convert is new Ada.Unchecked_Conversion(
	    Source => Constrained_WWS,
	    Target => Constrained_ID
	   );
    Begin
	Return Convert(Input) in Pure_Types.Identifier;
    End Is_Valid;


   procedure Check_Identifier(Position : Token_Vector_Pkg.Cursor) is
      Package TVP renames Token_Vector_Pkg;
      Item    : Token renames TVP.Element( Position );
      Value   : Wide_Wide_String renames Lexeme(Item);
   begin
      if ID(Item) = Text and Value in Identifier then
         Data.Replace_Element(Position,
                              New_Item => Make_Token(Aux.Identifier, Value)
                             );
      end if;
   End Check_Identifier;

Begin
   Data.Iterate(Check_Identifier'Access);
End Lexington.Aux.P10;
