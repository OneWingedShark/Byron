Pragma Ada_2012;
Pragma Assertion_Policy( Check );

-- Byron.Transformation_Function is a generic function that takes transformation
-- procedure and allows it to be used as a function; it is intended to be used
-- by Byron.Pass.

Generic
   Type Input_Type(<>) is limited private;
   with Procedure Transform(Input : in out Input_Type);
Function Byron.Generics.Transformation_Function( Input : Input_Type ) Return Input_Type;
