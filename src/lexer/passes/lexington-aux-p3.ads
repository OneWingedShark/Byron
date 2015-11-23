Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Handle comments starting a TEXT token.
-- Note: This doesn't handle, for example This--thing or, more importantly "--".
Procedure Lexington.Aux.P3(Data : in out Token_Vector_Pkg.Vector);
