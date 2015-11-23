Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Generate Identifiers.
Procedure Lexington.Aux.P10(Data : in out Token_Vector_Pkg.Vector);
