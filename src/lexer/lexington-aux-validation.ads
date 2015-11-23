Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Package Lexington.Aux.Validation with Pure is

   function Validate_Float(Text : Wide_Wide_String) return Boolean;
   function Validate_Integer(Text : Wide_Wide_String) return Boolean;

End Lexington.Aux.Validation;
