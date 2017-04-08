Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Generic
    Type Element is limited private;
    with function Img( Input : Element ) return Wide_Wide_String;
Function Byron.Internals.Image( Input : Element ) Return Wide_Wide_String
with Pure, SPARK_Mode => On;
