Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Ensures that no invalid tokens are emitted.
Procedure Lexington.Aux.P20(Data : in out Token_Vector_Pkg.Vector);
