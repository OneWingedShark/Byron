Pragma Ada_2012;
Pragma Assertion_Policy( Check );

-- Byron.Transformation is a generic procedure which, given a possibly null
-- access to a transformation applies it if appropriate; if it is null then the
-- identity is applied instead.

Generic
   Type Input_Type(<>) is limited private;
   Transformation : access Procedure( Object : in out Input_Type );
Function Byron.Generics.Optional_Transformation_Function( Item : Input_Type ) return Input_Type;
