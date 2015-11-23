Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Ada.Characters.Conversions;

Package Body Lexington.Aux.Validation is

   Generic
      Type Item_Type is private;
      with function Value(Input : Wide_Wide_String) return Item_Type;
   Function Generic_Validate(Text : Wide_Wide_String) return Boolean;

   Function Generic_Validate(Text : Wide_Wide_String) return Boolean is
      Package Conversion renames Ada.Characters.Conversions;
      Img : String renames Conversion.To_String( Text, ' ' );
   Begin
      declare
         I : Item_Type renames Value( Text );
      begin
         return True;
      end;
   exception
      when CONSTRAINT_ERROR => return False;
   End Generic_Validate;


   function Integer_Instance is new
     Generic_Validate(Long_Long_Integer, Long_Long_Integer'Wide_Wide_Value);
   function Float_Instance is new
     Generic_Validate(Long_Long_Float, Long_Long_Float'Wide_Wide_Value);

   function Validate_Float(Text : Wide_Wide_String) return Boolean
     renames Float_Instance;
   function Validate_Integer(Text : Wide_Wide_String) return Boolean
     renames Integer_Instance;

End Lexington.Aux.Validation;
