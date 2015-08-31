Pragma Ada_2012;
Pragma Assertion_Policy( Check );

-- Byron.Pass is a generic function intended to encapsulate the idea of a
-- compiler pass; it does this by applying a translation -- translations
-- are applied to the input (and the output), if given.

Generic
   Type Input_Type(<>)  is limited private;
   Type Output_Type(<>) is limited private;
   with Function "="(Left, Right : Input_Type ) return Boolean is <>;
   with Function "="(Left, Right : Output_Type) return Boolean is <>;
   with Function Translate(Input : Input_Type) return Output_Type;
   Input_Transformation  : access Procedure( Object : in out Input_Type  ):= Null;
   Output_Transformation : access Procedure( Object : in out Output_Type ):= Null;
Function Byron.Generics.Pass( Input : Input_Type) Return Output_Type;
