Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Normalizes line endings.
Procedure Lexington.Aux.P2(Data : in out Token_Vector_Pkg.Vector);
