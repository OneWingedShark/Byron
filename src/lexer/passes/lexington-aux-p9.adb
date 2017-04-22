Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Generics.Vector.Generic_Cursor,
Lexington.Token_Vector_Pkg.Tie_In,
Byron.Internals.SPARK.Pure_Types,
Byron.Internals.SPARK.Functions
;

Procedure Lexington.Aux.P9(Data : in out Token_Vector_Pkg.Vector) is
    Use Lexington.Aux.Token_Pkg, Byron.Internals.SPARK.Pure_Types;

   subtype Keyword is Token_ID range kw_Abort..kw_Xor;

   Function As_Keyword( Input : Token_ID ) return Wide_Wide_String
     with Pre => Input in Keyword;

   Function As_Keyword( Input : Token_ID ) return Wide_Wide_String is
      Image : Wide_Wide_String renames Token_ID'Wide_Wide_Image(Input);

      -- The offset here is to remove the KW_ prefix from the image.
      Start : Positive renames Positive'Succ(Positive'Succ(Positive'Succ(Image'First)));
      Stop  : constant Positive := Image'Last;
      Value : Wide_Wide_String := Image(Start..Stop);
   Begin
      return Value;
   End As_Keyword;

   Function Is_Keyword(Text  : Wide_Wide_String;
                       Which : out Token_ID
                      ) return Boolean is

      Function "="(Left, Right : Internal_String) return Boolean
        renames Byron.Internals.SPARK.Functions.Equal_Case_Insensitive;

      Function "="(Left, Right : Wide_Wide_String) return Boolean is
        ( Internal_String(Left) = Internal_String(Right) );

   begin
      Which:= Nil;
      Return Result : Boolean := False do
         for Index in Keyword loop
            Result:= Result or (Text = As_Keyword(Index));
            Which:= Index;
            Exit when Result;
         end loop;
      end return;
   End Is_Keyword;

    Package Cursors is
      new Lexington.Token_Vector_Pkg.Tie_In.Generic_Cursor(Data);


    Function Check_Keyword (Cursor : Cursors.Cursor'Class) return Token is
	Package TVP renames Token_Vector_Pkg;
	Item    : Token renames Cursor.Element;
	Value   : Wide_Wide_String renames Lexeme(Item);
	KW      : Token_ID;
    begin
	Return
	  (if Is_Keyword(Text  => Value, Which => KW)
	    then Make_Token(KW, As_Keyword(KW))
	    else Item
	  );
    End Check_Keyword;

    Procedure Update is new Cursors.Updater(
       Operation       => Check_Keyword,
       Replace_Element => Lexington.Token_Vector_Pkg.Replace_Element,
       Forward         => True
      );

Begin
    Update;
End Lexington.Aux.P9;
