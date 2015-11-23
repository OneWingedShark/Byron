Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Generate keywords.
Procedure Lexington.Aux.P12(Data : in out Token_Vector_Pkg.Vector);
