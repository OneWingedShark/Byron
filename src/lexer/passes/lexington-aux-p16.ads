Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Generate based float literals.
Procedure Lexington.Aux.P16(Data : in out Token_Vector_Pkg.Vector);
