Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

Use
Lexington.Token_Vector_Pkg;

Function Lexington.Tokens(Data : Wide_Wide_String) return Vector;
