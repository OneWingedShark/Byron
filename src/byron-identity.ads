Pragma Ada_2012;
Pragma Assertion_Policy( Check );

-- Byron.Transformation_Function is a generic function that takes transformation
-- procedure and allows it to be used as a function; it is intended to be used
-- by Byron.Pass.

Generic
   Type Input_Type(<>) is limited private;
Function Byron.Identity(Input : Input_Type) return Input_Type
with Pure, Pure_Function, Inline;
