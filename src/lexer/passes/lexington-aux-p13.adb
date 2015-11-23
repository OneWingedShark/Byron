Pragma Ada_2012;
Pragma Assertion_Policy( Check );


Procedure Lexington.Aux.P13(Data : in out Token_Vector_Pkg.Vector) is

   Procedure Make_Literal(Position : Token_Vector_Pkg.Cursor) is
      Package TVP renames Token_Vector_Pkg;
      This       : Token renames TVP.Element( Position );
      This_ID    : Token_ID renames Token_Pkg.ID(This);
      This_Value : Wide_Wide_String renames Token_Pkg.Lexeme( This );
   begin
      if This_ID = Text then
         declare
            I : Integer renames Integer'Wide_Wide_Value( This_Value );
         begin
            Data.Replace_Element( Position, Token_Pkg.Make_Token(li_Integer, This_Value) );
         end;
      end if;
   exception
      when Constraint_Error => Null;
   End Make_Literal;

Begin
   Data.Iterate( Make_Literal'Access );
End Lexington.Aux.P13;
