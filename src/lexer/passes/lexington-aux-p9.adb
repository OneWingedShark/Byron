Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Characters.Conversions,
Ada.Strings.Equal_Case_Insensitive;

Procedure Lexington.Aux.P9(Data : in out Token_Vector_Pkg.Vector) is
   subtype Keyword is Token_ID range kw_Abort..kw_Xor;

   Function To_String(Input : Wide_Wide_String; Sub : Character := ' ') return String
      renames Ada.Characters.Conversions.To_String;

   Function As_Keyword( Input : Token_ID ) return Wide_Wide_String
     with Pre => Input in Keyword;

   Function As_Keyword( Input : Token_ID ) return Wide_Wide_String is
      Image : Wide_Wide_String renames Token_ID'Wide_Wide_Image(Input);
      Start : Positive renames Positive'Succ(Positive'Succ(Positive'Succ(Image'First)));
      Stop  : constant Positive := Image'Last;
      Value : Wide_Wide_String := Image(Start..Stop);
   Begin
      return Value;
   End As_Keyword;

   Function Is_Keyword(Text  : Wide_Wide_String;
                       Which : out Token_ID
                      ) return Boolean is
      -- Ada.Strings.Wide_Wide_Equal_Case_Insensitive is missing on this
      -- installation; this is a TERRIBLE "mostly works" workaround.
      Function "="(Left, Right : String) return Boolean
         renames Ada.Strings.Equal_Case_Insensitive;
      Function "="(Left, Right : Wide_Wide_String) return Boolean is
        (To_String(Left) = To_String(Right));
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

   procedure Check_Keyword(Position : Token_Vector_Pkg.Cursor) is
      Package TVP renames Token_Vector_Pkg;
      Item    : Token renames TVP.Element( Position );
      Value   : Wide_Wide_String renames Lexeme(Item);
      KW      : Token_ID;
   begin
      if Is_Keyword(Text  => Value, Which => KW) then
         Data.Replace_Element(Position,
                              New_Item => Make_Token(KW, As_Keyword(KW))
                             );
      end if;
   End Check_Keyword;

Begin
   Data.Iterate(Check_Keyword'Access);
End Lexington.Aux.P9;
