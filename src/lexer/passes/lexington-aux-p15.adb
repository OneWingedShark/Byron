Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Lexington.Aux.Validation,
Lexington.Search.Replace_Sequence,
Ada.Characters.Conversions,
Ada.Strings.Wide_Wide_Fixed;

Procedure Lexington.Aux.P15(Data : in out Token_Vector_Pkg.Vector) is
--     I : Integer:= 03#212#e+4;
--     F : Float  := 11#8A3.1#e-6;
   use Lexington.Aux.Validation;

   Procedure Make_Literal(Position : Token_Vector_Pkg.Cursor) is
      use Ada.Strings.Wide_Wide_Fixed;
      Package TVP renames Token_Vector_Pkg;
      This       : Token renames TVP.Element( Position );
      This_ID    : Token_ID renames Token_Pkg.ID(This);
      This_Value : Wide_Wide_String renames Token_Pkg.Lexeme( This );
      Based      : constant Boolean := This_ID = li_Integer
                                       and Index(This_Value, "#") in Positive;
   begin
      if Based then
         Data.Replace_Element( Position, Token_Pkg.Make_Token(li_Based_Integer, This_Value) );
      end if;
   exception
      when Constraint_Error => Null;
   End Make_Literal;

   procedure Replace_Plus_Exponent is new Search.Replace_Sequence(
      Sequence  => (Text, ch_Plus, li_Integer),
      Item_Type => li_Based_Integer,
      Validator => Validate_Integer'Access
     );

Begin
   Data.Iterate( Make_Literal'Access );
   Replace_Plus_Exponent( Data );
End Lexington.Aux.P15;
