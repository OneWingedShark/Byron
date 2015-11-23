Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Takes a string, returns a vector containing a single-token  (a TEXT token).
Function Lexington.Aux.P0(Input : Wide_Wide_String) return Token_Vector_Pkg.Vector;
