Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Splits TEXT tokens into WHITESPACE and TEXT.
Procedure Lexington.Aux.P1(Data : in out Token_Vector_Pkg.Vector);
