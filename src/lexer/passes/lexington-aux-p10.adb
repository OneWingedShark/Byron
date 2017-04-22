Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Generics.Updater,
Lexington.Token_Vector_Pkg.Tie_In,
Byron.Internals.SPARK.Pure_Types;

Procedure Lexington.Aux.P10(Data : in out Token_Vector_Pkg.Vector) is
    Use Lexington.Aux.Token_Pkg, Byron.Internals.SPARK.Pure_Types;

    Pragma Assert( Wide_Wide_String'Component_Size =
		     Byron.Internals.SPARK.Pure_Types.Identifier'Component_Size,
		   "ERROR: Internal-string character-size mismatch!"
		  );

    -- Validate the identifier.
    Function Is_Valid( Input : Wide_Wide_String ) return Boolean;

    -- View an Identifier as a subtype of Wide_Wide_String.
    Subtype Identifier is Wide_Wide_String
      with Dynamic_Predicate => Is_Valid( Identifier );

    Function Is_Valid( Input : Wide_Wide_String ) return Boolean is
	Use Byron.Internals.SPARK;
	Internal : Pure_Types.Internal_String renames Convert(Input);
    Begin
	Return Internal in Pure_Types.Identifier;
    End Is_Valid;


    -- If the item is a text-token and conforms to Identifier, then make it one.
    Function Make_Identifier (Item : Token) return Token is
      (if ID(Item) = Text and Lexeme(Item) in Identifier then
	     Make_Token(Aux.Identifier, Lexeme(Item))
       else  Item
      );

    Procedure Update is new Byron.Generics.Updater(
       Vector_Package  => Lexington.Token_Vector_Pkg.Tie_In,
       Replace_Element => Lexington.Token_Vector_Pkg.Replace_Element,
       Operation       => Make_Identifier
      );

Begin
    Update( Data );
End Lexington.Aux.P10;
