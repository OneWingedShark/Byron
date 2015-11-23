Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Generate double-character delimiters.
Procedure Lexington.Aux.P5(Data : in out Token_Vector_Pkg.Vector);
