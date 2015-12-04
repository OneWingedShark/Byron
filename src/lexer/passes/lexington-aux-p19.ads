Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Filters out text-artifact tokens.
Procedure Lexington.Aux.P19(Data : in out Token_Vector_Pkg.Vector);
